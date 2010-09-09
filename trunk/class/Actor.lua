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
require "engine.Actor"
require "engine.Autolevel"
require "mod.class.interface.ComplexInventory"
require "engine.interface.ActorTemporaryEffects"
require "engine.interface.ActorProject"
require "engine.interface.ActorLevel"
require "engine.interface.ActorStats"
require "engine.interface.ActorTalents"
require "engine.interface.ActorQuest"
require "engine.interface.ActorResource"
require "engine.interface.ActorFOV"
require "mod.class.interface.Combat"
require "mod.class.interface.ActorLife"

local Faction = require "engine.Faction"
local Map = require "engine.Map"
local Chat = require "engine.Chat"
local Object = require "mod.class.Object"

module(..., package.seeall, class.inherit(
	engine.Actor,
	mod.class.interface.ComplexInventory,
	engine.interface.ActorTemporaryEffects,
	mod.class.interface.ActorLife,
	engine.interface.ActorProject,
	engine.interface.ActorLevel,
	engine.interface.ActorStats,
	engine.interface.ActorTalents,
	engine.interface.ActorQuest,
	engine.interface.ActorResource,
	engine.interface.ActorFOV,
	mod.class.interface.Combat
))

_M.__do_distance_map = true

function _M:init(t, no_default)
	-- Define some basic combat stats
	t.combat_armor = 0

	-- Default regen
	t.vload_regen = t.vload_regen or 1
	t.life_regen = t.life_regen or 0.25 -- Life regen real slow
	t.stamina_regen = t.stamina_regen or 0.3
	t.vload = t.vload or 0

	-- Default melee barehanded damage
	t.combat = t.combat or { dam=1, }

	t.unused_stats = t.unused_stats or 0
	t.unused_talents =  t.unused_talents or 0
    t.unused_generics = t.unused_generics or 0
	t.unused_talents_types = t.unused_talents_types or 0
	
    t.talent_cd_reduction = t.talent_cd_reduction or {}
    
	engine.Actor.init(self, t, no_default)
	mod.class.interface.ComplexInventory.init(self, t)
	engine.interface.ActorTemporaryEffects.init(self, t)
	mod.class.interface.ActorLife.init(self, t)
	engine.interface.ActorProject.init(self, t)
	engine.interface.ActorTalents.init(self, t)
	engine.interface.ActorResource.init(self, t)
	engine.interface.ActorStats.init(self, t)
	engine.interface.ActorLevel.init(self, t)
	engine.interface.ActorFOV.init(self, t)
end

function _M:act()
	if not engine.Actor.act(self) then return end

	self.changed = true

	-- Cooldown talents
	self:cooldownTalents()
	-- Regen resources
	self:regenLife()
	self:regenResources()
	-- Compute timed effects
	self:timedEffects()

	if self:attr("stunned") then self.energy.value = 0 end

	-- Still enough energy to act ?
	if self.energy.value < game.energy_to_act then return false end

	return true
end

function _M:move(x, y, force)

--if game.level.map:checkEntity(x, y, engine.Map.TERRAIN, "block_move") then return false end
	local moved = false
	local energy_per_step
	local stamina_per_step = self:attr("stamina_per_step") or 0
	-- If we are the player, check if there is something to talk to
	if self == game.player then
		if game.level.map:checkEntity(x, y, engine.Map.TERRAIN, "can_talk") then
			local target = game.level.map(x, y, engine.Map.TERRAIN)
			local chat = Chat.new(target.can_talk, target, self)
			chat:invoke()
		elseif game.level.map:checkEntity(x, y, engine.Map.ACTOR, "can_talk") then
			local target = game.level.map(x, y, engine.Map.ACTOR)
			if self:reactionToward(target) >= 0 then
				if self.player and target.can_talk then
					local chat = Chat.new(target.can_talk, target, self)
					chat:invoke()
				elseif target.player and self.can_talk then
					local chat = Chat.new(self.can_talk, self, target)
					chat:invoke()
				end
			end
		elseif game.level.map:checkEntity(x, y, engine.Map.OBJECT, "can_talk") then
			local target = game.level.map(x, y, engine.Map.OBJECTs)
			local chat = Chat.new(target.can_talk, target, self)
			chat:invoke()
		end
		if game.level.map:checkEntity(x, y, engine.Map.TERRAIN, "block_move") then
		game.flash:empty()
		game.logPlayer(self, "Can't move that way. ")
			if game.level.map:checkEntity(x, y, engine.Map.TERRAIN, "locked") then
			game.logPlayer(self, "It's locked")
			end
		return moved
		end
	end
	-- Check if the actor is running
	if self:attr("sprint") then
		energy_per_step = game.energy_to_act / self:attr("movement_speedup")
		stamina_per_step = stamina_per_step + 1 + 10 * self:getEncumbrance() / self:getMaxEncumbrance()
	end
	if force or self:enoughEnergy(energy_per_step) then
		if not stamina_per_step or self:getStamina() >= stamina_per_step then
			moved = engine.Actor.move(self, x, y, force)
			if stamina_per_step and self.x == x and self.y ==y then self:incStamina(-stamina_per_step) end
		else
			moved = true
			game.logPlayer(self, "#FF0000#You are too tired to move!")
		end
		if not force and moved and not self.did_energy then self:useEnergy(energy_per_step) end
	end
	self.did_energy = false
	return moved
end

function _M:tooltip()
	local factcolor, factstate = "#ANTIQUE_WHITE#", "neutral"
	if self:reactionToward(game.player) < 0 then factcolor, factstate = "#LIGHT_RED#", "hostile"
	elseif self:reactionToward(game.player) > 0 then factcolor, factstate = "#LIGHT_GREEN#", "friendly"
	end
	return ([[%s
#00ffff#Level: %d
#ff0000#HP: %d (%d%%)
Stats: %d / %d / %d
%s
Faction: %s%s (%s)]]):format(
	self.name,
	self.level,
	self.life, self.life * 100 / self.max_life,
	self.vload,
	self:getStr(),
	self:getAgi(),
	self:getCon(),
	self.desc or "",
	factcolor, Faction.factions[self.faction].name, factstate
	)
end

function _M:onTakeHit(value, src)
	return value
end

function _M:die(src, mutated)
	mod.class.interface.ActorLife.die(self, src)

	-- Gives the killer some exp for the kill
	if src and src.gainExp then
		src:gainExp(self:worthExp(src))
	end

	-- Player killed this actor?
	if src and src.player then
		-- Achievements
		-- Record kills
		src.all_kills = src.all_kills or {}
		src.all_kills[self.name] = src.all_kills[self.name] or 0
		src.all_kills[self.name] = src.all_kills[self.name] + 1
	end
	
	-- Finally drop the body and stuff
	if not mutated and self.corpse then
		local corpse = Object.new(self.corpse)
		game.zone:addEntity(game.level, corpse, "object", self.x, self.y)
	end
	for inven_id, inven in pairs(self.inven) do
		for i, o in ipairs(inven) do
			if not o.no_drop then
				o.droppedBy = self.name
				game.level.map:addObject(self.x, self.y, o)
			end
		end
	end
	self.inven = {}
	return true
end

function _M:levelup()
	-- Increase the stats and talents
	self.unused_stats = self.unused_stats + 1
	self.unused_talents = self.unused_talents + 1
	self.unused_generics = self.unused_generics + 1

	-- Heal up on new level
	self.life = self.max_life
	self.stamina = self:getMaxStamina()
	if self.type ~= "zombie" then
		self.vload = 0
	end
end

--- Notifies a change of stat value
function _M:onStatChange(stat, v)
	if stat == self.STAT_CON then
		self.max_life = self.max_life + 2
	end
end

function _M:attack(target)
	self:bumpInto(target)
end

function _M:fireWeapon(target)
local weapon, ammo = self:hasGunWeapon()
ammo_radius = ammo.combat and ammo.combat.radius or 0
self:getTarget{type="bolt", range=30}
self:firearmShoot(tg)
end

--- Gets the talent cooldown, checking cooldown reduction
-- @param t the talent to get the cooldown for
function _M:getTalentCooldown(t)
    if not t.cooldown then return end
    local cd
    if type(t.cooldown) == "function" then
    else
        cd = t.cooldown
    end
    if self.talent_cd_reduction[t.id] then cd = math.max(0, cd - self.talent_cd_reduction[t.id]) end
    return cd
end

--- Starts a talent cooldown; overloaded from the default to handle talent cooldown reduction
-- @param t the talent to cooldown
function _M:startTalentCooldown(t)
	local cd = self:getTalentCooldown(t)
	self.talents_cd[t.id] = cd
	self.changed = true
end

--- Called before a talent is used
-- Check the actor can cast it
-- @param ab the talent (not the id, the table)
-- @return true to continue, false to stop
function _M:preUseTalent(ab, silent)
	if not self:enoughEnergy() then print("fail energy") return false end

	if not silent then
		-- Allow for silent talents
        if ab.mode == "sustained" then
            if ab.sustain_stamina and self.getMaxStamina() < ab.sustain_stamina and not self:isTalentActive(ab.id) then
                game.logPlayer(self, "You do not have enough stamina to activate %s.", ab.name)
                return false
            end
        else
            if ab.stamina and self:getStamina() < ab.stamina then
                game.logPlayer(self, "You do not have enough stamina to use %s.", ab.name)
                return false
            end
        end
		if ab.message ~= nil then
			if ab.message then
				game.logSeen(self, "%s", self:useTalentMessage(ab))
			end
		elseif ab.mode == "sustained" and not self:isTalentActive(ab.id) then
			game.logSeen(self, "%s activates %s.", self.name:capitalize(), ab.name)
		elseif ab.mode == "sustained" and self:isTalentActive(ab.id) then
			game.logSeen(self, "%s deactivates %s.", self.name:capitalize(), ab.name)
		else
			game.logSeen(self, "%s uses %s.", self.name:capitalize(), ab.name)
		end
	end
	return true
end

--- Called before a talent is used
-- Check if it must use a turn, mana, stamina, ...
-- @param ab the talent (not the id, the table)
-- @param ret the return of the talent action
-- @return true to continue, false to stop
function _M:postUseTalent(ab, ret)
	if not ret then return end
    
    if ab.mode == "sustained" then
		if not self:isTalentActive(ab.id) then
			if ab.sustain_stamina then
                self:incMaxStamina(-ab.sustain_stamina)
			end
        else
            if ab.sustain_stamina then
                self:incMaxStamina(ab.sustain_stamina)
            end
        end
    else
        if ab.stamina then
			self:incStamina(-ab.stamina)
		end
    end
    
	self:useEnergy()

	return true
end


--- Return the full description of a talent
-- @param t the talent to describe
-- @param addlevel the offset from the current talent level to describe
function _M:getTalentFullDescription(t, addlevel)
	local old = self.talents[t.id]
	self.talents[t.id] = (self.talents[t.id] or 0) + (addlevel or 0)

	local d = {}

	if t.mode == "passive" then d[#d+1] = "#6fff83#Use mode: #00FF00#Passive"
	elseif t.mode == "sustained" then d[#d+1] = "#6fff83#Use mode: #00FF00#Sustained"
	else d[#d+1] = "#6fff83#Use mode: #00FF00#Activated"
	end

	if t.stamina or t.sustain_stamina then d[#d+1] = "#6fff83#Stamina cost: #ffcc80#"..(t.stamina or t.sustain_stamina) end
	if self:getTalentRange(t) > 1 then d[#d+1] = "#6fff83#Range: #FFFFFF#"..self:getTalentRange(t)
	else d[#d+1] = "#6fff83#Range: #FFFFFF#melee/personal"
	end
	if t.cooldown then d[#d+1] = "#6fff83#Cooldown: #FFFFFF#"..self:getTalentCooldown(t) end
	local speed = self:getTalentProjectileSpeed(t)
	if speed then d[#d+1] = "#6fff83#Travel Speed: #FFFFFF#"..(speed * 100).."% of base"
	else d[#d+1] = "#6fff83#Travel Speed: #FFFFFF#instantaneous"
	end

	local ret = table.concat(d, "\n").."\n#6fff83#Description: #FFFFFF#"..t.info(self, t)

	self.talents[t.id] = old

	return ret
end

--- How much experience is this actor worth
-- @param target to whom is the exp rewarded
-- @return the experience rewarded
function _M:worthExp(target)
	if not target.level or self.level < target.level - 3 then return 0 end

	local mult = 2
	if self.unique then mult = 6
	elseif self.egoed then mult = 3 end
	return self.level * mult * self.exp_worth
end

--- Can the actor see the target actor
-- This does not check LOS or such, only the actual ability to see it.<br/>
-- Check for telepathy, invisibility, stealth, ...
function _M:canSee(actor, def, def_pct)
	if not actor then return false, 0 end

	
	if actor:attr("sneak") and actor ~= self then
		local def = self:getPer()
		local hit, chance = self:checkHit(def, actor:attr("sneak") + (actor:attr("inc_stealth") or 0), 0, 100)
		if not hit then
			print('SNEAKING' .. chance)
			return false, chance
		end
	end

	if def ~= nil then
		return def, def_pct
	else
		return true, 100
	end
end

--- Can the target be applied some effects
-- @param what a string describing what is being tried
function _M:canBe(what)
	if what == "poison" and rng.percent(100 * (self:attr("poison_immune") or 0)) then return false end
	if what == "cut" and rng.percent(100 * (self:attr("cut_immune") or 0)) then return false end
	if what == "confusion" and rng.percent(100 * (self:attr("confusion_immune") or 0)) then return false end
	if what == "blind" and rng.percent(100 * (self:attr("blind_immune") or 0)) then return false end
	if what == "stun" and rng.percent(100 * (self:attr("stun_immune") or 0)) then return false end
	if what == "fear" and rng.percent(100 * (self:attr("fear_immune") or 0)) then return false end
	if what == "knockback" and rng.percent(100 * (self:attr("knockback_immune") or 0)) then return false end
	if what == "instakill" and rng.percent(100 * (self:attr("instakill_immune") or 0)) then return false end
	return true
end

function _M:getMaxEncumbrance()
	return math.floor(40 + self:getStr() * 1.8) + (self.max_encumber or 0)
end

function _M:getEncumbrance()
	-- Compute encumbrance
	local enc = 0
	for inven_id, inven in pairs(self.inven) do
		for item, o in ipairs(inven) do
			o:forAllStack(function(so) enc = enc + so.encumber end)
		end
	end
--	print("Total encumbrance", enc)
	return enc
end

function _M:checkEncumbrance()
	-- Compute encumbrance
	local enc, max = self:getEncumbrance(), self:getMaxEncumbrance()

	-- We are pinned to the ground if we carry too much
	if not self.encumbered and enc > max then
		game.logPlayer(self, "#FF0000#You carry too much, you are encumbered!")
		game.logPlayer(self, "#FF0000#Drop some of your items.")
		self.encumbered = self:addTemporaryValue("never_move", 1)
	elseif self.encumbered and enc <= max then
		self:removeTemporaryValue("never_move", self.encumbered)
		self.encumbered = nil
		game.logPlayer(self, "#00FF00#You are no longer encumbered.")
	end
end

function _M:magicMap(radius, x, y)
	x = x or self.x
	y = y or self.y
	radius = math.floor(radius)
	for i = x - radius, x + radius do for j = y - radius, y + radius do
		if game.level.map:isBound(i, j) and core.fov.distance(x, y, i, j) < radius then
			game.level.map.remembers(i, j, true)
			game.level.map.has_seens(i, j, true)
		end
	end end
end