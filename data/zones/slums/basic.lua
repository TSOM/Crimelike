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
local Map = require "engine.Map"

newEntity{
	define_as = "UP",
	name = "previous level",
	display = '<', color_r=255, color_g=255, color_b=0, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = 1,
	tooltip = "Stairs leading upwards.",
}

newEntity{
	define_as = "DOWN",
	name = "next level",
	display = '>', color_r=255, color_g=255, color_b=0, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = -1,
	tooltip = "Stairs leading downwards.",
}

newEntity{
	define_as = "FLOOR",
	name = "floor", image = "terrain/marble_floor.png",
	display = ' ', back_color=colors.GREY,
}

newEntity{
	define_as = "WALL",
	name = "wall", image = "terrain/granite_wall1.png",
	display = ' ', color_br=250, color_bg=250, color_bb=250,
	always_remember = true,
	does_block_move = true,
	can_pass = {pass_wall=1},
	block_sight = true,
	air_level = -20,
	dig = "FLOOR",
}

newEntity{
	define_as = "DOOR",
	name = "door", image = "terrain/granite_door1.png",
	display = '+', color_r=238, color_g=33, color_b=12,
	color_br=235, color_bg=126, color_bb=37,
	notice = true,
	door_opened = "DOOR_OPEN",
	door_locked = "DOOR_LOCKED",
	does_block_move = true,
	block_sight = true,
	dig = "DOOR_OPEN",
	tooltip = "A closed door with a window in it.",
}

newEntity{
	define_as = "DOOR_OPEN",
	name = "open door", image = "terrain/granite_door1_open.png",
	display = "'", color_r=238, color_g=33, color_b=12, back_color=colors.DARK_GREY,
	door_closed = "DOOR",
	door_locked = "DOOR_LOCKED",
	tooltip = "An open door.",
	close_countdown = 4,
	energy = { value=0, mod=1 },
	canAct = false,
	on_added = function(self, level, x, y)
		self.x = x
		self.y = y
		level:addEntity(self)
	end,
	act = function(self)
		-- Do basic actor stuff
		if not engine.Actor.act(self) then return end
		
		-- Shut the door?
		if game.level.map(self.x, self.y, Map.ACTOR) or game.level.map(self.x, self.y, Map.OBJECT) then
			self.close_countdown = 4
		else
			self.close_countdown = self.close_countdown - 1
		end
		if self.close_countdown <= 0 then
			game.level:removeEntity(self)
			game.level.map(self.x, self.y, Map.TERRAIN, game.zone.grid_list[self.door_closed])
		end
		
		if not self.energy.used then self:useEnergy() end
		return true
	end,
	on_move = function(self, x, y, who)
		self.close_countdown = 4
	end,
	useEnergy = function(self, val)
		val = val or game.energy_to_act
		self.energy.value = self.energy.value - val
	end,
}

newEntity{
	define_as = "DOOR_LOCKED",
	name = "locked door",
	display = '+', color=colors.VIOLET,
	color_br=235, color_bg=126, color_bb=37,
	notice = true,
	does_block_move = true,
	block_sight = true,
	dig = "DOOR_OPEN",
	door_unlocked = "DOOR",
	tooltip = "A locked door with a window in it.",
}

newEntity{
	base = "DOOR",
	define_as = "ELEVATOR_DOOR",
	tooltip = "A closed elevator door.",
	door_opened = "ELEVATOR_OPEN",
	door_locked = "ELEVATOR_LOCKED",
}

newEntity{
	base = "DOOR_OPEN",
	define_as = "ELEVATOR_OPEN",
	tooltip = "An open elevator door.",
	door_closed = "ELEVATOR_DOOR",
	door_locked = "ELEVATOR_LOCKED",
}

newEntity{
	base = "DOOR_LOCKED",
	define_as = "ELEVATOR_LOCKED",
	tooltip = "An unresponsive elevator door.",
	door_unlocked = "ELEVATOR_DOOR",
}

newEntity{
	base = "DOOR",
	define_as = "WINDOWED_DOOR",
	tooltip = "A closed door with a window in it.",
	display = 'o',
	door_opened = "WINDOWED_DOOR_OPEN",
	door_locked = "WINDOWED_DOOR_LOCKED",
	block_sight = false,
}

newEntity{
	base = "DOOR_OPEN",
	define_as = "WINDOWED_DOOR_OPEN",
	tooltip = "An open door.",
	door_closed = "WINDOWED_DOOR",
	door_locked = "WINDOWED_DOOR_LOCKED",
}

newEntity{
	base = "DOOR_LOCKED",
	define_as = "WINDOWED_DOOR_LOCKED",
	tooltip = "An locked door with a window in it.",
	display = 'o',
	door_closed = "WINDOWED_DOOR",
	block_sight = false,
}

newEntity{
	define_as = "DESK",
	name = "desk",
	display = '=', color_r=238, color_g=154, color_b=77, back_color=colors.GREEN,
	notice = true,
	block_sight = false,
	does_block_move = true,
	dig = "FLOOR",
	tooltip = "A desk.",
}

newEntity{
	define_as = "BED",
	name = "bed",
	display = '#', color_r=31, color_g=136, color_b=145,
	color_br=247, color_bg=239, color_bb=37,
	notice = true,
	block_sight = false,
	does_block_move = true,
	dig = "FLOOR",
	tooltip = "A bed.",
}


newEntity{
	define_as = "WINDOW",
	name = "window",
	display = 'o', color=colors.ANTIQUE_WHITE,
	color_br=250, color_bg=250, color_bb=250,
	notice = true,
	block_sight = false,
	does_block_move = true,
	dig = "FLOOR",
	tooltip = "A window.",
}