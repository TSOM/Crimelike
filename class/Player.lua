--Bay 12
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--


require "engine.class"
require "mod.class.Actor"
require "engine.interface.PlayerRest"
require "engine.interface.PlayerRun"
require "engine.interface.PlayerMouse"
require "engine.interface.PlayerHotkeys"
local Map = require "engine.Map"
local Dialog = require "engine.Dialog"
local ActorTalents = require "engine.interface.ActorTalents"
local DeathDialog = require "mod.dialogs.DeathDialog"
local Astar = require"engine.Astar"
local DirectPath = require"engine.DirectPath"
local LevelupStatsDialog = require "mod.dialogs.LevelupStatsDialog"
local LevelupTalentsDialog = require "mod.dialogs.LevelupTalentsDialog"

--- Defines the player
-- It is a normal actor, with some redefined methods to handle user interaction.<br/>
-- It is also able to run and rest and use hotkeys
module(..., package.seeall, class.inherit(
	mod.class.Actor,
	engine.interface.PlayerRest,
	engine.interface.PlayerRun,
	engine.interface.PlayerMouse,
	engine.interface.PlayerHotkeys
))

function _M:init(t, no_default)
	t.display=t.display or '@'
	t.color_r=t.color_r or 230
	t.color_g=t.color_g or 230
	t.color_b=t.color_b or 230
	t.default_r = t.color_r
	t.default_g = t.color_g
	t.default_b = t.color_b
	
	t.player = true
	t.type = t.type or "humanoid"
	t.subtype = t.subtype or "player"
	t.faction = t.faction or "players"

	t.lite = t.lite or 0
	t.unique = t.unique or true

	mod.class.Actor.init(self, t, no_default)
	engine.interface.PlayerHotkeys.init(self, t)
	self.descriptor = {}
end

function _M:move(x, y, force)
	local moved = mod.class.Actor.move(self, x, y, force)
	if moved then
		game.level.map:moveViewSurround(self.x, self.y, 8, 8)
	end
	-- Check for objects in the same tile as the player
	local i, nb = 1, 0
	local obj = game.level.map:getObject(self.x, self.y, i)
	while obj do
		nb = nb + 1
		i = i + 1
		obj = game.level.map:getObject(self.x, self.y, i)
	end
	if nb >= 2 then
		game.logSeen(self, "There is more than one objects lying here.")
	elseif nb == 1 then
		game.logSeen(self, "There is an item here: %s", game.level.map:getObject(self.x, self.y, 1):getName{do_color=true})
	end
	return moved
end

function _M:act()
	if not mod.class.Actor.act(self) then return end

	-- Clean log flasher
	game.flash:empty()

	-- Resting ? Running ? Otherwise pause
	if not self:restStep() and not self:runStep() and self.player then
		game.paused = true
	end
	
	if self._mo then
		self._mo:invalidate()
		game.level.map:updateMap(self.x, self.y)
	end
end

function _M:playerFOV()
	-- Clean FOV before computing it
	game.level.map:cleanFOV()
	-- Compute both the normal and the lite FOV, using cache
	self:computeFOV(self.sight or 20, "block_sight", function(x, y, dx, dy, sqdist)
		game.level.map:apply(x, y, math.max((20 - math.sqrt(sqdist)) / 14, 0.6))
	end, true, false, true)
	self:computeFOV(self.lite, "block_sight", function(x, y, dx, dy, sqdist) game.level.map:applyLite(x, y) end, true, true, true)
end

--- Called before taking a hit, overload mod.class.Actor:onTakeHit() to stop resting and running
function _M:onTakeHit(value, src)
	self:runStop("taken damage")
	self:restStop("taken damage")
	local ret = mod.class.Actor.onTakeHit(self, value, src)
	if self.life < self.max_life * 0.3 then
		local sx, sy = game.level.map:getTileToScreen(self.x, self.y)
		game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, 2, "LOW HEALTH!", {255,0,0}, true)
	end
	return ret
end

function _M:die(src)
	if self.game_ender then
		mod.class.interface.ActorLife.die(self, src)
		game.paused = true
		self.energy.value = game.energy_to_act
		game:registerDialog(DeathDialog.new(self))
	else
		mod.class.Actor.die(self, src)
	end
end

function _M:setName(name)
	self.name = name
	game.save_name = name
end

--- Notify the player of available cooldowns
function _M:onTalentCooledDown(tid)
	local t = self:getTalentFromId(tid)

	local x, y = game.level.map:getTileToScreen(self.x, self.y)
	game.flyers:add(x, y, 30, -0.3, -3.5, ("%s available"):format(t.name:capitalize()), {0,255,00})
	game.log("#00ff00#Talent %s is ready to use.", t.name)
end

function _M:levelup()
	mod.class.Actor.levelup(self)

	local x, y = game.level.map:getTileToScreen(self.x, self.y)
	game.flyers:add(x, y, 80, 0.5, -2, "LEVEL UP!", {0,255,255})
	game.log("#00ffff#Welcome to level %d.", self.level)
	if self.unused_stats > 0 then game.log("You have %d stat point(s) to spend. Press G to use them.", self.unused_stats) end
	if self.unused_talents > 0 then game.log("You have %d talent point(s) to spend. Press G to use them.", self.unused_talents) end
	if self.unused_talents_types > 0 then game.log("You have %d category point(s) to spend. Press G to use them.", self.unused_talents_types) end
end

--- Tries to get a target from the user
function _M:getTarget(typ)
	return game:targetGetForPlayer(typ)
end

--- Sets the current target
function _M:setTarget(target)
	return game:targetSetForPlayer(target)
end

local function spotHostiles(self)
	local seen = false
	-- Check for visible monsters, only see LOS actors, so telepathy wont prevent resting
	core.fov.calc_circle(self.x, self.y, 20, function(_, x, y) return game.level.map:opaque(x, y) end, function(_, x, y)
		local actor = game.level.map(x, y, game.level.map.ACTOR)
		if actor and self:reactionToward(actor) < 0 and self:canSee(actor) and game.level.map.seens(x, y) then seen = true end
	end, nil)
	return seen
end

function _M:sneakToggle()
	if self:attr("sneak") then
	self:removeTemporaryValue("sneak", self.sneakid)
	self.sneakid = nil
	print('Remove Sneak')
	game.logPlayer(self, "You stop sneaking.")
	else
	game.logPlayer(self, "You start sneaking.")
	self.sneakid = self:addTemporaryValue("sneak", 1)
	end

end

function _M:sprintToggle()
	if self:attr("sprint") then
	self:removeTemporaryValue("sprint", self.sprintid)
	self.sprintid = nil
	game.logPlayer(self, "You stop sprinting.")
	else
	game.logPlayer(self, "You start sprinting.")
	self.sprintid = self:addTemporaryValue("sprint", 1)
	end

end

--- Can we continue resting ?
-- We can rest if no hostiles are in sight, and if we need life/mana/stamina (and their regen rates allows them to fully regen)
function _M:restCheck()
	if spotHostiles(self) then return false, "hostile spotted" end

	-- Check resources, make sure they CAN go up, otherwise we will never stop
	if self.vload > 0 and self.vload_regen < 0 then return true end
	if self.life < self.max_life and self.life_regen> 0 then return true end
	if self:getStamina() < self:getMaxStamina() and self.stamina_regen> 0 then return true end

	return false, "all resources and life at maximun"
end

--- Can we continue running?
-- We can run if no hostiles are in sight, and if we no interresting terrains are next to us
function _M:runCheck()
	if spotHostiles(self) then return false, "hostile spotted" end

	-- Notice any noticable terrain
	local noticed = false
	self:runScan(function(x, y)
		-- Only notice interresting terrains
		local grid = game.level.map(x, y, Map.TERRAIN)
		if grid and grid.notice then noticed = "interesting terrain" end

		-- Objects are always interresting
		local obj = game.level.map:getObject(x, y, 1)
		if obj then noticed = "object seen" end
	end)
	if noticed then return false, noticed end

	self:playerFOV()

	return engine.interface.PlayerRun.runCheck(self)
end

--- Move with the mouse
-- We just feed our spotHostile to the interface mouseMove
function _M:mouseMove(tmx, tmy)
	return engine.interface.PlayerMouse.mouseMove(self, tmx, tmy, spotHostiles)
end

function _M:getEncumberTitleUpdator(title)
	return function()
		local enc, max = self:getEncumbrance(), self:getMaxEncumbrance()
		return ("%s - Encumbered %d/%d"):format(title, enc, max)
	end
end

function _M:playerInventory()
	local d
	d = self:showComplexInv("Inventory", nil, {function(o, inven, item, parentObject)
		if inven and inven ~= self.INVEN_FLOOR then
			if inven == self.INVEN_AIR then return end
			
			local air = self:getInven(self.INVEN_AIR)[1]
			local slot
			local wearable
			if parentObject then
				slot = parentObject:getInven(inven)[item]
				wearable = parentObject.inven_def[inven].is_worn
			else
				slot = self:getInven(inven)[item]
				wearable = self.inven_def[inven].is_worn
			end
			
			if not air and not slot then return end
			
			if not parentObject then --If an item in the player's inventory was selected
				if not air then
					if wearable then
						if self:takeoffObject(inven, item) then
							if not self:addObject(self.INVEN_AIR, slot) then
								self:wearObject(slot, false, false, inven)
							end
						end
					elseif self:removeObject(inven, item, true) then
						if not self:addObject(self.INVEN_AIR, slot) then
							self:addObject(inven, slot)
						end
					end
				elseif not slot then
					if wearable then
						if self:removeObject(self.INVEN_AIR, 1, true) then
							if not self:wearObject(air, false, false, inven) then
								self:addObject(self.INVEN_AIR, air)
							end
						end
					elseif self:removeObject(self.inven[self.INVEN_AIR], 1, true) then
						if not self:addObject(inven, air) then
							self:addObject(self.INVEN_AIR, air)
						end
					end
				else
					if wearable then
						if self:removeObject(self.INVEN_AIR, 1, true) then
							if self:takeoffObject(inven, item) then
								if self:wearObject(air, false, false, inven) then
									self:addObject(self.INVEN_AIR, slot)
								else
									self:addObject(self.INVEN_AIR, air)
									self:wearObject(slot, false, false, inven)
								end
							else
								self:addObject(self.INVEN_AIR, air)
							end
						end
					else
						if self:removeObject(self.INVEN_AIR, 1, true) then
							if self:removeObject(inven, item, true) then
								if self:addObject(inven, air) then
									self:addObject(self.INVEN_AIR, slot)
								else
									self:addObject(self.INVEN_AIR, air)
									self:addObject(inven, slot)
								end
							else
								self:addObject(self.INVEN_AIR, air)
							end
						end
					end
				end
			else --An object within another object was selected
				if not air then
					if parentObject:removeObject(inven, item, true) then
						if not self:addObject(self.INVEN_AIR, slot) then
							parentObject:addObject(inven, slot)
						end
					end
				elseif not slot then
					if not parentObject.inven_def[inven].is_worn or parentObject:canWearObject(air, inven, true) then
						if self:removeObject(self.inven[self.INVEN_AIR], 1, true) then
							if not parentObject:addObject(inven, air) then
								self:addObject(self.INVEN_AIR, air)
							end
						end
					end
				else
					if not parentObject.inven_def[inven].is_worn or parentObject:canWearObject(air, inven, true) then	
						if self:removeObject(self.INVEN_AIR, 1, true) then
							if parentObject:removeObject(inven, item, true) then
								if parentObject:addObject(inven, air) then
									self:addObject(self.INVEN_AIR, slot)
								else
									self:addObject(self.INVEN_AIR, air)
									parentObject:addObject(inven, slot)
								end
							else
								self:addObject(self.INVEN_AIR, air)
							end
						end
					end
				end
			end
		elseif inven == self.INVEN_FLOOR then
			self:dropFloor(self.INVEN_AIR, 1, true, true)
		elseif item then --An item on the ground was selected
			if self:getInven(self.INVEN_AIR)[1] then self:dropFloor(self.INVEN_AIR, 1, true, true) end
			self:pickupFloor(item, true, true, self.INVEN_AIR)
		end
		
		self.changed = true
	end,
	function() --If the player closes the screen with an item in the air, drop it.
		if self:getInven(self.INVEN_AIR)[1] then  self:dropFloor(self.INVEN_AIR, 1, true, true) end
	end})
end

function _M:playerPickup()
	local attemptPickup = function(item)
		for priority, data in pairs(self.invenPriorities) do
			if data.inven then
				self:pickupFloor(item, false, true, data.inven)
			elseif data.object then
				for inven_id, inven in pairs(self.inven) do
					for items, object in pairs(inven) do
						if object == data.object then
							self:pickupFloor(item, false, true, data.itemInven, object)
						end
					end
				end
			end
			if game.level.map:getObject(self.x, self.y, item) ~= o then
				break
			end
		end
	end
	-- If 2 or more objects, display a pickup dialog, otehrwise just picks up
	if game.level.map:getObject(self.x, self.y, 2) then
		local titleupdator = self:getEncumberTitleUpdator("Pickup")
		local d d = self:showPickupFloor(titleupdator(), nil, function(o, item)
			attemptPickup(item)
			if game.level.map:getObject(self.x, self.y, item) ~= o then 
				game.logSeen(self, "%s picks up: %s.", self.name:capitalize(), o:getName{do_color=true})
			else 
				game:unregisterDialog(d)
				self:pickupFloor(item, true, true, self.INVEN_AIR)
				self:playerInventory()
			end
			self.changed = true
			d.title = titleupdator()
			d:used()
		end)
	else
		o = game.level.map:getObject(self.x, self.y, 1)
		attemptPickup(1)
		if game.level.map:getObject(self.x, self.y, 1) ~= o then 
			game.logSeen(self, "%s picks up: %s.", self.name:capitalize(), o:getName{do_color=true})
		else
			self:pickupFloor(1, true, true, self.INVEN_AIR)
			self:playerInventory()
		end
		self:useEnergy()
	self.changed = true
	end
end

function _M:playerUseItem(object, item, inven)
	if game.zone.wilderness then game.logPlayer(self, "You can not use items on the world map.") return end

	local use_fct = function(o, inven, item)
		self.changed = true
		local ret, no_id = o:use(self)
		if not no_id then
			o:identify(true)
		end
		if ret and ret == "destroy" then
			if o.multicharge and o.multicharge > 1 then
				o.multicharge = o.multicharge - 1
			else
				local _, del = self:removeObject(self:getInven(inven), item)
				if del then
					game.log("You have no more %s.", o:getName{no_count=true, do_color=true})
				else
					game.log("You have %s.", o:getName{do_color=true})
				end
				self:sortInven(self:getInven(inven))
			end
			return true
		end
		self:breakStealth()
		self.changed = true
	end

	if object and item then return use_fct(object, inven, item) end

	local titleupdator = self:getEncumberTitleUpdator("Use object")
	self:showComplexInv(titleupdator(),
		function(o)
			return o:canUseObject()
		end,
		{use_fct,
		function() end},
		true
	)
end

function _M:doDrop(inven, item)
	if game.zone.wilderness then game.logPlayer(self, "You can not drop on the world map.") return end
	self:dropFloor(inven, item, true, true)
	self:sortInven()
	self:useEnergy()
	self.changed = true
end

function _M:doWear(inven, item, o)
	self:removeObject(inven, item, true)
	local ro = self:wearObject(o, true, true)
	if ro then
		if type(ro) == "table" then self:addObject(inven, ro) end
	elseif not ro then
		self:addObject(inven, o)
	end
	self:sortInven()
	self:useEnergy()
	self.changed = true
end

function _M:doTakeoff(inven, item, o)
	if self:takeoffObject(inven, item) then
		self:addObject(self.INVEN_INVEN, o)
	end
	self:sortInven()
	self:useEnergy()
	self.changed = true
end

function _M:playerLevelup(on_finish)
	if self.unused_stats > 0 then
		local ds = LevelupStatsDialog.new(self, on_finish)
		game:registerDialog(ds)
	else
		local dt = LevelupTalentsDialog.new(self, on_finish)
		game:registerDialog(dt)
	end
end