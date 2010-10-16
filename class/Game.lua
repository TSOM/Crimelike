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
require "engine.interface.GameTargeting"
require "engine.GameTurnBased"
require "engine.KeyBind"
local Savefile = require "engine.Savefile"
local DamageType = require "engine.DamageType"
local Zone = require "engine.Zone"
local Map = require "engine.Map"
local Target = require "engine.Target"
local Level = require "engine.Level"
local Birther = require "engine.Birther"

local Grid = require "mod.class.Grid"
local Actor = require "mod.class.Actor"
local Player = require "mod.class.Player"
local NPC = require "mod.class.NPC"

local HotkeysDisplay = require "engine.HotkeysDisplay"
local ActorsSeenDisplay = require "engine.ActorsSeenDisplay"
local LogDisplay = require "engine.LogDisplay"
local LogFlasher = require "engine.LogFlasher"
local DebugConsole = require "engine.DebugConsole"
local FlyingText = require "engine.FlyingText"
local Tooltip = require "engine.Tooltip"
local HIDEN = require "mod.class.HIDEN"
local PlayerDisplay = require "mod.class.PlayerDisplay"
--local MinimapDisplay = require "engine.MinimapDisplay"

local QuitDialog = require "mod.dialogs.Quit"

module(..., package.seeall, class.inherit(engine.GameTurnBased, engine.interface.GameTargeting))

function _M:init()
	engine.GameTurnBased.init(self, engine.KeyBind.new(), 1000, 100)

	-- Pause at birth
	self.paused = true

	-- Same init as when loaded from a savefile
	self:loaded()
end

function _M:run()
	self.flash = LogFlasher.new(0, 0, self.w, 20, nil, nil, nil, {255,255,255}, {0,0,0})
	self.log_display = LogDisplay.new(0, self.h * 0.8, self.w * 0.5 - 18, self.h * 0.2, nil, nil, nil, {255,255,255}, {30,30,30})
	self.player_display = PlayerDisplay.new(0, 220, 200, self.h * 0.8 - 220, {30,30,0})
	self.hotkeys_display = HotkeysDisplay.new(nil, self.w * 0.5, self.h * 0.8, self.w * 0.5, self.h * 0.2, {30,30,30})
	self.npcs_display = ActorsSeenDisplay.new(nil, self.w * 0.5, self.h * 0.8, self.w * 0.5, self.h * 0.2, {30,30,30})
	--self.calendar = Calendar.new("/data/calendar_rivendell.lua", "Today is the %s %s of the %s year of the Fourth Age of Middle-earth.\nThe time is %02d:%02d.", 122)
	self.tooltip = Tooltip.new(nil, nil, {255,255,255}, {30,30,30})
	self.flyers = FlyingText.new()
	self:setFlyingText(self.flyers)
	self.minimap_bg, self.minimap_bg_w, self.minimap_bg_h = core.display.loadImage("/data/gfx/ui/minimap.png"):glTexture()
	self.icons = { display_x = game.w * 0.5 - 14, display_y = game.h * 0.8 + 3, w = 12, h = game.h * 0.2}
	--self:createSeparators()

	self.log = function(style, ...) if type(style) == "number" then self.log_display(...) self.flash(style, ...) else self.log_display(style, ...) self.flash(self.flash.NEUTRAL, style, ...) end end
	self.logSeen = function(e, style, ...) if e and self.level.map.seens(e.x, e.y) then self.log(style, ...) end end
	self.logPlayer = function(e, style, ...) if e == self.player then self.log(style, ...) end end

	self.log(self.flash.GOOD, "Prepare to begin your #00FF00#life of crime!")

	-- Setup inputs
	self:setupCommands()
	self:setupMouse()

	-- Starting from here we create a new game
	if not self.player then self:newGame() end

	self.hotkeys_display.actor = self.player
	self.npcs_display.actor = self.player

	--self:initTargeting()
engine.interface.GameTargeting.init(self)
	self.HIDEN = HIDEN:init()
	-- Ok everything is good to go, activate the game in the engine!
	self:setCurrent()

	-- Run the current music if any
	--self:playMusic()

	if self.level then self:setupDisplayMode() end
end

function _M:newGame()
	self.player = Player.new{name=self.player_name, game_ender=true}
	Map:setViewerActor(self.player)
	self:setupDisplayMode()

	local birth = Birther.new(self.player, {"base", "sex", "race", "role", "location" }, function()
		self:changeLevel(self.player.starting_level, self.player.starting_zone)
		print("[PLAYER BIRTH] resolve...")
		self.player:resolve()
		self.player:resolve(nil, true)
		self.player.energy.value = self.energy_to_act
		self.paused = true
		print("[PLAYER BIRTH] resolved!")
		--self.player:grantQuest(self.player.starting_quest)
		--self:registerDialog(require("mod.dialogs.IntroDialog").new(self.player))

	end)
	self:registerDialog(birth,self:registerDialog(require("mod.dialogs.LevelupStatsDialog").new(self.player)))

end

function _M:loaded()
	engine.GameTurnBased.loaded(self)
	Zone:setup{npc_class="mod.class.NPC", grid_class="mod.class.Grid", object_class="mod.class.Object", }
	Map:setViewerActor(self.player)
	self:setupDisplayMode()
	self.key = engine.KeyBind.new()
end

function _M:onResolutionChange()
	engine.Game.onResolutionChange(self)
	print("[RESOLUTION] changed to ", self.w, self.h)
	self:setupDisplayMode()
	self.flash:resize(0, 0, self.w, 20)
	self.log_display:resize(0, self.h * 0.8, self.w * 0.5 - 18, self.h * 0.2)
	self.player_display:resize(0, 220, 200, self.h * 0.8 - 220)
	self.hotkeys_display:resize(self.w * 0.5, self.h * 0.8, self.w * 0.5, self.h * 0.2)
	self.npcs_display:resize(self.w * 0.5, self.h * 0.8, self.w * 0.5, self.h * 0.2)
	self.icons = { display_x = game.w * 0.5 - 14, display_y = game.h * 0.8 + 3, w = 12, h = game.h * 0.2}
	-- Reset mouse bindings to account for new size
	self:setupMouse(true)

	--self:createSeparators()
end

function _M:setupDisplayMode()
	print("[DISPLAY MODE] 32x32 ASCII/background")
	Map:setViewPort(200, 20, self.w - 200, math.floor(self.h * 0.80) - 20, 32, 32, nil, 22, true, true)
	Map:resetTiles()
	Map.tiles.use_images = true
end

function _M:save()
	return class.save(self, self:defaultSavedFields{}, true)
end

function _M:getSaveDescription()
	return {
		name = self.player.name,
		description = ([[Exploring level %d of %s.]]):format(self.level.level, self.zone.name),
	}
end

function _M:leaveLevel(level, lev, old_lev)
	if level:hasEntity(self.player) then
		level.exited = level.exited or {}
		if lev > old_lev then
			level.exited.up = {x=self.player.x, y=self.player.y}
		else
			level.exited.down = {x=self.player.x, y=self.player.y}
		end
		level.last_turn = game.turn
		level:removeEntity(self.player)
	end
end

function _M:changeLevel(lev, zone, use_current_position)
	local old_level = self.level
	local old_lev = (self.level and not zone) and self.level.level or -1000
	if zone then
		if self.zone then
			self.zone:leaveLevel(false, lev, old_lev)
			self.zone:leave()
		end
		if type(zone) == "string" then
			self.zone = Zone.new(zone)
		else
			self.zone = zone
		end
	end
	self.zone:getLevel(self, lev, old_lev)

	-- Check if we used stairs to get here
	local src_x, src_y, dst_x, dst_y
	if old_level then
		local exit = (lev > old_lev) and old_level.exited.up or old_level.exited.down
		src_x, src_y = exit.x, exit.y
	end
	-- Find the dst based on the subtype of the src stairs
	if src_x and src_y then
		for i, spot in ipairs(old_level.spots) do
			if spot.type == 'stairs' and spot.x == src_x and spot.y == src_y then
				--Find the matching subtype on the current level
				for i, dest_spot in ipairs(self.level.spots) do
					if dest_spot.type == 'stairs' and dest_spot.subtype == spot.subtype then
						dst_x = dest_spot.x
						dst_y = dest_spot.y
					end
				end
			end
		end
	end
	if dst_x and dst_y then
		self.player:move(dst_x, dst_y, true)
	elseif use_current_position then
		self.player:move(src_x, src_y, true)
	-- Otherwise use the default location
	else
		if lev < old_lev then
			self.player:move(self.level.default_up.x, self.level.default_up.y, true)
		else
			self.player:move(self.level.default_down.x, self.level.default_down.y, true)
		end
	end
	self.level:addEntity(self.player)
	-- Change the zone/level name
	self.zone_name_s = nil
	self.level.map:redisplay()
end

function _M:getPlayer()
	return self.player
end

function _M:tick()
	if self.level then
		if self.target.target.entity and not self.level:hasEntity(self.target.target.entity) then self.target.target.entity = false end

		engine.GameTurnBased.tick(self)
		-- Fun stuff: this can make the game realtime, although callit it in display() will make it work better
		-- (since display is on a set FPS while tick() ticks as much as possible
		-- engine.GameEnergyBased.tick(self)
	end
	if game.turn - HIDEN.lastRun >= 100 then
	HIDEN:run()
	end
	-- When paused (waiting for player input) we return true: this means we wont be called again until an event wakes us
	if game.paused then return true end
end

--- Called every game turns
function _M:onTurn()
	-- The following happens only every 10 game turns (once for every turn of 1 mod speed actors)
	if self.turn % 10 ~= 0 then return end

	-- Process overlay effects
	self.level.map:processEffects()
end

function _M:display()

	-- Now the map, if any
	if self.level and self.level.map and self.level.map.finished then
		-- Display the map and compute FOV for the player if needed
		if self.level.map.changed then
			self.player:playerFOV()
		end

		-- Level background
		if self.level.data.background then
			self.level.data.background(self.level)
		end

		-- Display using Framebuffer, sotaht we can use shaders and all
		if self.fbo then
			self.fbo:use(true)
			self.level.map:display(0, 0)
			self.target:display(0, 0)
			self.fbo:use(false)
			_2DNoise:bind(1, false)
			self.fbo:toScreen(
				self.level.map.display_x, self.level.map.display_y,
				self.level.map.viewport.width, self.level.map.viewport.height,
				self.fbo_shader.shad
			)

		-- Basic display
		else
			self.level.map:display()
			self.target:display()
		end

		if not self.zone_name_s then
			local s = core.display.drawStringBlendedNewSurface(self.player_display.font, ("%s (%d)"):format(self.zone.name, self.level.level), 0, 255, 255)
			self.zone_name_w, self.zone_name_h = s:getSize()
			self.zone_name_s, self.zone_name_tw, self.zone_name_th = s:glTexture()
		end
		self.zone_name_s:toScreenFull(
			self.level.map.display_x + self.level.map.viewport.width - self.zone_name_w,
			self.level.map.display_y + self.level.map.viewport.height - self.zone_name_h,
			self.zone_name_w, self.zone_name_h,
			self.zone_name_tw, self.zone_name_th
		)

		-- Minimap display
		self.minimap_bg:toScreenFull(0, 20, 200, 200, self.minimap_bg_w, self.minimap_bg_h)
		self.level.map:minimapDisplay(0, 20, util.bound(self.player.x - 25, 0, self.level.map.w - 50), util.bound(self.player.y - 25, 0, self.level.map.h - 50), 50, 50, 1)
	end

	-- We display the player's interface
	self.flash:toScreen()
	self.log_display:toScreen()
	self.player_display:toScreen()
	if self.show_npc_list then
		self.npcs_display:toScreen()
	else
		self.hotkeys_display:toScreen()
	end
	if self.player then self.player.changed = false end

	-- Separators
	--self.bottom_separator:toScreenFull(0, 20 - 3, self.w, 6, self.bottom_separator_w, self.bottom_separator_h)
	--self.bottom_separator:toScreenFull(0, self.h * 0.8 - 3, self.w, 6, self.bottom_separator_w, self.bottom_separator_h)
	--self.split_separator:toScreenFull(self.w * 0.5 - 3 - 15, self.h * 0.8, 6, self.h * 0.2, self.split_separator_w, self.split_separator_h)
	--self.split_separator:toScreenFull(self.w * 0.5 - 3, self.h * 0.8, 6, self.h * 0.2, self.split_separator_w, self.split_separator_h)
	--self.player_separator:toScreenFull(200 - 3, 20, 6, self.h * 0.8 - 20, self.player_separator_w, self.player_separator_h)

	-- Icons
	--self:displayUIIcons()

	engine.GameTurnBased.display(self)

	-- Tooltip is displayed over all else, even dialogs
	self:targetDisplayTooltip(self.w, self.h)
end


function _M:createSeparators()
	self.bottom_separator, self.bottom_separator_w, self.bottom_separator_h = self:createVisualSeparator("horizontal", self.w)
	self.split_separator, self.split_separator_w, self.split_separator_h = self:createVisualSeparator("vertical", math.floor(self.h * 0.2))
	self.player_separator, self.player_separator_w, self.player_separator_h = self:createVisualSeparator("vertical", math.floor(self.h * 0.8) - 20)
end

--- Setup the keybinds
function _M:setupCommands()
	-- One key handler for targeting
	self.targetmode_key = engine.KeyBind.new()
	self.targetmode_key:addCommands{ _SPACE=function() self:targetMode(false, false) end, }
	self.targetmode_key:addBinds
	{
		TACTICAL_DISPLAY = function() self:targetMode(false, false) end,
		ACCEPT = function()
			self:targetMode(false, false)
			self.tooltip_x, self.tooltip_y = nil, nil
		end,
		EXIT = function()
			self.target.target.entity = nil
			self.target.target.x = nil
			self.target.target.y = nil
			self:targetMode(false, false)
			self.tooltip_x, self.tooltip_y = nil, nil
		end,
		-- Targeting movement
		RUN_LEFT = function() self.target:freemove(4) self.tooltip_x, self.tooltip_y = self.level.map:getTileToScreen(self.target.target.x, self.target.target.y) end,
		RUN_RIGHT = function() self.target:freemove(6) self.tooltip_x, self.tooltip_y = self.level.map:getTileToScreen(self.target.target.x, self.target.target.y) end,
		RUN_UP = function() self.target:freemove(8) self.tooltip_x, self.tooltip_y = self.level.map:getTileToScreen(self.target.target.x, self.target.target.y) end,
		RUN_DOWN = function() self.target:freemove(2) self.tooltip_x, self.tooltip_y = self.level.map:getTileToScreen(self.target.target.x, self.target.target.y) end,
		RUN_LEFT_DOWN = function() self.target:freemove(1) self.tooltip_x, self.tooltip_y = self.level.map:getTileToScreen(self.target.target.x, self.target.target.y) end,
		RUN_RIGHT_DOWN = function() self.target:freemove(3) self.tooltip_x, self.tooltip_y = self.level.map:getTileToScreen(self.target.target.x, self.target.target.y) end,
		RUN_LEFT_UP = function() self.target:freemove(7) self.tooltip_x, self.tooltip_y = self.level.map:getTileToScreen(self.target.target.x, self.target.target.y) end,
		RUN_RIGHT_UP = function() self.target:freemove(9) self.tooltip_x, self.tooltip_y = self.level.map:getTileToScreen(self.target.target.x, self.target.target.y) end,

		MOVE_LEFT = function() if self.target_style == "lock" then self.target:scan(4) else self.target:freemove(4) end self.tooltip_x, self.tooltip_y = self.level.map:getTileToScreen(self.target.target.x, self.target.target.y) end,
		MOVE_RIGHT = function() if self.target_style == "lock" then self.target:scan(6) else self.target:freemove(6) end self.tooltip_x, self.tooltip_y = self.level.map:getTileToScreen(self.target.target.x, self.target.target.y) end,
		MOVE_UP = function() if self.target_style == "lock" then self.target:scan(8) else self.target:freemove(8) end self.tooltip_x, self.tooltip_y = self.level.map:getTileToScreen(self.target.target.x, self.target.target.y) end,
		MOVE_DOWN = function() if self.target_style == "lock" then self.target:scan(2) else self.target:freemove(2) end self.tooltip_x, self.tooltip_y = self.level.map:getTileToScreen(self.target.target.x, self.target.target.y) end,
		MOVE_LEFT_DOWN = function() if self.target_style == "lock" then self.target:scan(1) else self.target:freemove(1) end self.tooltip_x, self.tooltip_y = self.level.map:getTileToScreen(self.target.target.x, self.target.target.y) end,
		MOVE_RIGHT_DOWN = function() if self.target_style == "lock" then self.target:scan(3) else self.target:freemove(3) end self.tooltip_x, self.tooltip_y = self.level.map:getTileToScreen(self.target.target.x, self.target.target.y) end,
		MOVE_LEFT_UP = function() if self.target_style == "lock" then self.target:scan(7) else self.target:freemove(7) end self.tooltip_x, self.tooltip_y = self.level.map:getTileToScreen(self.target.target.x, self.target.target.y) end,
		MOVE_RIGHT_UP = function() if self.target_style == "lock" then self.target:scan(9) else self.target:freemove(9) end self.tooltip_x, self.tooltip_y = self.level.map:getTileToScreen(self.target.target.x, self.target.target.y) end,
	}

	self.normal_key = self.key

	-- One key handled for normal function
	self.key:addBinds
	{
		-- Movements
		MOVE_LEFT = function() self.player:moveDir(4) end,
		MOVE_RIGHT = function() self.player:moveDir(6) end,
		MOVE_UP = function() self.player:moveDir(8) end,
		MOVE_DOWN = function() self.player:moveDir(2) end,
		MOVE_LEFT_UP = function() self.player:moveDir(7) end,
		MOVE_LEFT_DOWN = function() self.player:moveDir(1) end,
		MOVE_RIGHT_UP = function() self.player:moveDir(9) end,
		MOVE_RIGHT_DOWN = function() self.player:moveDir(3) end,
		MOVE_STAY = function() self.player:useEnergy() end,

		RUN_LEFT = function() self.player:runInit(4) end,
		RUN_RIGHT = function() self.player:runInit(6) end,
		RUN_UP = function() self.player:runInit(8) end,
		RUN_DOWN = function() self.player:runInit(2) end,
		RUN_LEFT_UP = function() self.player:runInit(7) end,
		RUN_LEFT_DOWN = function() self.player:runInit(1) end,
		RUN_RIGHT_UP = function() self.player:runInit(9) end,
		RUN_RIGHT_DOWN = function() self.player:runInit(3) end,

		-- Hotkeys
		HOTKEY_1 = function() self.player:activateHotkey(1) end,
		HOTKEY_2 = function() self.player:activateHotkey(2) end,
		HOTKEY_3 = function() self.player:activateHotkey(3) end,
		HOTKEY_4 = function() self.player:activateHotkey(4) end,
		HOTKEY_5 = function() self.player:activateHotkey(5) end,
		HOTKEY_6 = function() self.player:activateHotkey(6) end,
		HOTKEY_7 = function() self.player:activateHotkey(7) end,
		HOTKEY_8 = function() self.player:activateHotkey(8) end,
		HOTKEY_9 = function() self.player:activateHotkey(9) end,
		HOTKEY_10 = function() self.player:activateHotkey(10) end,
		HOTKEY_11 = function() self.player:activateHotkey(11) end,
		HOTKEY_12 = function() self.player:activateHotkey(12) end,
		HOTKEY_SECOND_1 = function() self.player:activateHotkey(13) end,
		HOTKEY_SECOND_2 = function() self.player:activateHotkey(14) end,
		HOTKEY_SECOND_3 = function() self.player:activateHotkey(15) end,
		HOTKEY_SECOND_4 = function() self.player:activateHotkey(16) end,
		HOTKEY_SECOND_5 = function() self.player:activateHotkey(17) end,
		HOTKEY_SECOND_6 = function() self.player:activateHotkey(18) end,
		HOTKEY_SECOND_7 = function() self.player:activateHotkey(19) end,
		HOTKEY_SECOND_8 = function() self.player:activateHotkey(20) end,
		HOTKEY_SECOND_9 = function() self.player:activateHotkey(21) end,
		HOTKEY_SECOND_10 = function() self.player:activateHotkey(22) end,
		HOTKEY_SECOND_11 = function() self.player:activateHotkey(23) end,
		HOTKEY_SECOND_12 = function() self.player:activateHotkey(24) end,
		HOTKEY_THIRD_1 = function() self.player:activateHotkey(25) end,
		HOTKEY_THIRD_2 = function() self.player:activateHotkey(26) end,
		HOTKEY_THIRD_3 = function() self.player:activateHotkey(27) end,
		HOTKEY_THIRD_4 = function() self.player:activateHotkey(28) end,
		HOTKEY_THIRD_5 = function() self.player:activateHotkey(29) end,
		HOTKEY_THIRD_6 = function() self.player:activateHotkey(30) end,
		HOTKEY_THIRD_7 = function() self.player:activateHotkey(31) end,
		HOTKEY_THIRD_8 = function() self.player:activateHotkey(31) end,
		HOTKEY_THIRD_9 = function() self.player:activateHotkey(33) end,
		HOTKEY_THIRD_10 = function() self.player:activateHotkey(34) end,
		HOTKEY_THIRD_11 = function() self.player:activateHotkey(35) end,
		HOTKEY_THIRD_12 = function() self.player:activateHotkey(36) end,
		HOTKEY_PREV_PAGE = function() self.player:prevHotkeyPage() end,
		HOTKEY_NEXT_PAGE = function() self.player:nextHotkeyPage() end,

		-- Actions
		CHANGE_LEVEL = function()
			local e = self.level.map(self.player.x, self.player.y, Map.TERRAIN)
			if self.player:enoughEnergy() and e.change_level then
				self:changeLevel(e.change_zone and e.change_level or self.level.level + e.change_level, e.change_zone)
			else
				self.log("There is no way out of this level here.")
			end
		end,
		FIREWEAPON = function()
			--self.player:fireWeapon()
		end,
		REST = function()
			self.player:restInit()
		end,

		CLOSE = function()
			self.player:useTalents()
		end,
		
		OPEN = function()
			self.player:useTalents()
		end,
		
		USE_TALENTS = function()
			self.player:useTalents()
		end,

		SAVE_GAME = function()
			self:saveGame()
		end,

		SHOW_CHARACTER_SHEET = function()
			self:registerDialog(require("mod.dialogs.CharacterSheet").new(self.player))

		end,

		-- Exit the game
		QUIT_GAME = function()
			self:onQuit()
		end,

		-- Lua console
		LUA_CONSOLE = function()
			self:registerDialog(DebugConsole.new())
		end,

		EXIT = function()
			local menu menu = require("engine.dialogs.GameMenu").new{
				"resume",
				"keybinds",
				"resolution",
				"save",
				"quit"
			}
			self:registerDialog(menu)
		end,

		TACTICAL_DISPLAY = function()
			if Map.view_faction then
				self.always_target = nil
				Map:setViewerFaction(nil)
			else
				self.always_target = true
				Map:setViewerFaction("players")
			end
		end,

		LOOK_AROUND = function()
			self.flash:empty(true)
			self.flash(self.flash.GOOD, "Looking around... (direction keys to select interesting things, shift+direction keys to move pointer freely)")
			local co = coroutine.create(function() self.player:getTarget{type="hit", no_restrict=true, range=2000} end)
			local ok, err = coroutine.resume(co)
			if not ok and err then print(debug.traceback(co)) error(err) end
		end,

		PICKUP_FLOOR = function()
			self.player:playerPickup()
		end,

		DROP_FLOOR = "SHOW_INVENTORY",

		SHOW_INVENTORY = function()
			self.player:playerInventory()
		end,

		SHOW_EQUIPMENT = "SHOW_INVENTORY",

		WEAR_ITEM = "SHOW_INVENTORY",

		TAKEOFF_ITEM = "SHOW_INVENTORY",

		USE_ITEM = function()
			self.player:playerUseItem()
		end,
		SHOW_CHARACTER_SHEET = function()
			self:registerDialog(require("mod.dialogs.CharacterSheet").new(self.player))
		end,
		SPRINT = function()
			self.player:sprintToggle()
		end,
		SNEAK = function()
		self:registerDialog(require("mod.dialogs.LevelUpTalentsDialog").new(self.player))
			self.player:sneakToggle()
		end,
		LEVELUP = function()
			self.player:playerLevelup()
		end,
		SHOW_QUESTS = function()
			self:registerDialog(require("engine.dialogs.ShowQuests").new(self.player))
		end,
	}
	-- Test case for debugging
	self.key:addCommands{[{"_d","ctrl"}] = function()
		game.player:move(29, 9)
		game.player:hasQuest("code_green"):lock_outer_ward()
		local button = game.level.map(27, 8, Map.TERRAIN)
		local chat = engine.Chat.new("lockdown", button, game.player)
		chat:invoke("decontamination")
	end}

	-- Easter egg shortcut
	self.key:addCommands{[{"_e","ctrl"}] = function()
		local bazooka = game.zone:makeEntityByName(game.level, "object", "BAZOOKA")
		local basket = game.zone:makeEntityByName(game.level, "object", "EGG_BASKET")
		local lockpicks = game.zone:makeEntityByName(game.level, "object", "LOCKPICKS")
		local id = game.zone:makeEntityByName(game.level, "object", "ID")
		game.player:addObject(game.player.INVEN_INVEN, bazooka)
		game.player:addObject(game.player.INVEN_INVEN, basket)
		game.player:addObject(game.player.INVEN_INVEN, lockpicks)
		game.player:addObject(game.player.INVEN_INVEN, id)
		game.log("Easter came early this year!  (check your inventory)")
	end}

	self.key:setCurrent()
end

function _M:setupMouse(reset)
	if reset then self.mouse:reset() end
	self.mouse:registerZone(Map.display_x, Map.display_y, Map.viewport.width, Map.viewport.height, function(button, mx, my, xrel, yrel)
		-- Handle targeting
		if self:targetMouse(button, mx, my, xrel, yrel) then return end

		-- Handle the mouse movement/scrolling
		self.player:mouseHandleDefault(self.key, self.key == self.normal_key, button, mx, my, xrel, yrel)
	end)
	-- Scroll message log
	self.mouse:registerZone(self.log_display.display_x, self.log_display.display_y, self.w, self.h, function(button)
		if button == "wheelup" then self.log_display:scrollUp(1) end
		if button == "wheeldown" then self.log_display:scrollUp(-1) end
	end, {button=true})
	-- Use hotkeys with mouse
	self.mouse:registerZone(self.hotkeys_display.display_x, self.hotkeys_display.display_y, self.w, self.h, function(button, mx, my, xrel, yrel)
		self.hotkeys_display:onMouse(button, mx, my, not xrel)
	end)
	self.mouse:setCurrent()
end

--- Ask if we realy want to close, if so, save the game first
function _M:onQuit()
	self.player:restStop()

	if not self.quit_dialog then
		self.quit_dialog = QuitDialog.new()
		self:registerDialog(self.quit_dialog)
	end
end

--- Requests the game to save
function _M:saveGame()
	savefile_pipe:push(self.save_name, "game", self)
	self.log("Saving game...")
end

-- A flood-fill
function _M:floodFill(start_x, start_y, check, apply)
	local flood_queue = {}
	flood_queue.queue = {}
	flood_queue.history = {}
	function flood_queue:insert(value)
		if not self.history[value.x] then
			self.history[value.x] = {}
		end
		if self.history[value.x][value.y] then return end
		self.history[value.x][value.y] = true
		table.insert(self.queue, value)
	end
	function flood_queue:remove()
		return table.remove(self.queue)
	end
	flood_queue:insert{x=start_x, y=start_y}
	while #flood_queue.queue > 0 do
		local current_tile = flood_queue:remove()
		-- Check that the tile exists in the map and the user-defined check
		if game.level.map(current_tile.x, current_tile.y) and check(current_tile.x, current_tile.y) then
			apply(current_tile.x, current_tile.y)
			flood_queue:insert({x=current_tile.x-1, y=current_tile.y})
			flood_queue:insert({x=current_tile.x+1, y=current_tile.y})
			flood_queue:insert({x=current_tile.x, y=current_tile.y-1})
			flood_queue:insert({x=current_tile.x, y=current_tile.y+1})
		end
	end
end

--- Create a visual separator
--local _sep_left = core.display.loadImage("/data/gfx/ui/separator-left.png") _sep_left:alpha()
--local _sep_right = core.display.loadImage("/data/gfx/ui/separator-right.png") _sep_right:alpha()
--local _sep_horiz = core.display.loadImage("/data/gfx/ui/separator-hori.png") _sep_horiz:alpha()
--local _sep_top = core.display.loadImage("/data/gfx/ui/separator-top.png") _sep_top:alpha()
--local _sep_bottom = core.display.loadImage("/data/gfx/ui/separator-bottom.png") _sep_bottom:alpha()
--local _sep_vert = core.display.loadImage("/data/gfx/ui/separator-vert.png") _sep_vert:alpha()
function _M:createVisualSeparator(dir, size)
	if dir == "horizontal" then
		local sep = core.display.newSurface(size, 6)
		sep:erase(0, 0, 0)
		sep:merge(_sep_left, 0, 0)
		for i = 7, size - 7, 9 do sep:merge(_sep_horiz, i, 0) end
		sep:merge(_sep_right, size - 6, 0)
		return sep:glTexture()
	else
		local sep = core.display.newSurface(6, size)
		sep:erase(0, 0, 0)
		sep:merge(_sep_top, 0, 0)
		for i = 7, size - 7, 9 do sep:merge(_sep_vert, 0, i) end
		sep:merge(_sep_bottom, 0, size - 6)
		return sep:glTexture()
	end
end
