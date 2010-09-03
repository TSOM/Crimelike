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
	define_as = "SIDEWALK",
	name = "sidewalk", image = "terrain/marble_floor.png",
	display = ' ', back_color=colors.GREY,
}

newEntity{
	define_as = "STREET",
	name = "street", image = "terrain/marble_floor.png",
	display = ' ', back_color=colors.BLACK,
}
newEntity{
	define_as = "STREETLINE",
	name = "street-1", image = "terrain/marble_floor.png",
	display = '-', color = colors.YELLOW, back_color=colors.BLACK,
	tooltip = "street1",
}

newEntity{
	define_as = "STREETLINE2",
	name = "street-2", image = "terrain/marble_floor.png",
	display = '|', color = colors.YELLOW, back_color=colors.BLACK,
	tooltip = "street2",
}
newEntity{
	define_as = "STREETLINE3",
	name = "street-3", image = "terrain/marble_floor.png",
	display = '.', color = colors.YELLOW, back_color=colors.BLACK,
	tooltip = "street3",
}

newEntity{
	define_as = "FLOOR",
	name = "Floor", image = "terrain/marble_floor.png",
	display = ' ', back_color=colors.BROWN,
}

newEntity{
	define_as = "BRICKWALL",
	name = "wall", image = "terrain/granite_wall1.png",
	display = ' ', color_br=250, color_bg=250, color_bb=250,
	always_remember = true,
	does_block_move = true,
	can_pass = {pass_wall=1},
	block_sight = true,
	air_level = -20,
	dig = "FLOOR",
}
