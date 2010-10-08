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
	display = ' ', back_color=colors.GREY
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
	dig = "FLOOR"
}

newEntity{
	define_as = "DESK",
	name = "desk",
	display = '=', color_r=238, color_g=154, color_b=77, back_color=colors.GREEN,
	notice = true,
	block_sight = false,
	does_block_move = true,
	tooltip = "A desk."
}

newEntity{
	define_as = "BED",
	name = "bed",
	display = '#', color_r=31, color_g=136, color_b=145,
	color_br=247, color_bg=239, color_bb=37,
	notice = true,
	block_sight = false,
	does_block_move = true,
	tooltip = "A bed."
}

newEntity{
	define_as = "TABLE",
	name = "table",
	display = 'T', color_r=31, color_g=136, color_b=145,
	color_br=247, color_bg=239, color_bb=37,
	notice = true,
	block_sight = false,
	does_block_move = true,
	tooltip = "A table"
}

newEntity{
	define_as = "CHAIR",
	name = "chair",
	display = 'c', color_r=31, color_g=136, color_b=145,
	color_br=247, color_bg=239, color_bb=37,
	notice = true,
	block_sight = false,
	does_block_move = true,
	tooltip = "A chair"
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

newEntity{
	define_as = "PHONE",
	name = "phone",
	display = 'p', color=colors.ANTIQUE_WHITE,
	color_br=0, color_bg=0, color_bb=0,
	notice = true,
	block_sight = false,
	does_block_move = false,
	tooltip = "A phone.",
	phone = true,
}