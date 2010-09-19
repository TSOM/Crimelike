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

local Map = require 'engine.Map'
newEntity{
	define_as = 'STREETZOR',
	name = 'previous level',
	display = '<', color_r=255, color_g=255, color_b=0, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = 1,
	tooltip = 'Stairs leading upwards.'
}

newEntity{
	define_as = 'TESTZOR',
	name = 'previous level',
	display = '>', color_r=255, color_g=255, color_b=0, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = 1,
	tooltip = 'Stairs leading upwards.'
}

newEntity{
	define_as = 'UP',
	name = 'previous level',
	display = '<', color_r=255, color_g=255, color_b=0, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = 1,
	tooltip = 'Stairs leading upwards.'
}

newEntity{
	define_as = 'DOWN',
	name = 'next level',
	display = '>', color_r=255, color_g=255, color_b=0, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = -1,
	tooltip = 'Stairs leading downwards.'
}

newEntity{
	define_as = 'SIDEWALK',
	name = 'sidewalk', image = 'terrain/marble_floor.png',
	display = ' ', back_color=colors.GREY
}

newEntity{
	define_as = 'STREET',
	name = 'street', image = 'terrain/marble_floor.png',
	display = ' ', back_color=colors.BLACK
}
newEntity{
	define_as = 'STREETLINE',
	name = 'street-1', image = 'terrain/marble_floor.png',
	display = '-', color = colors.YELLOW, back_color=colors.BLACK,
	tooltip = 'street1'
}

newEntity{
	define_as = 'STREETLINEB',
	name = 'street-2', image = 'terrain/marble_floor.png',
	display = '|', color = colors.YELLOW, back_color=colors.BLACK,
	tooltip = 'street2'
}
newEntity{
	define_as = 'STREETLINEC',
	name = 'street-3', image = 'terrain/marble_floor.png',
	display = '.', color = colors.YELLOW, back_color=colors.BLACK,
	tooltip = 'street3'
}

newEntity{
	define_as = 'FLOOR',
	name = 'Floor',
	does_block_move = true,
	display = '*', color=colors.WHITE, back_color=colors.RED,
}

newEntity{
	define_as = 'GRASS_ONE',
	name = 'grass',
	display = '.', color=colors.GREEN, back_color=colors.GREEN,
	image = 'tiles/terrain/nature/grass.png'
}

newEntity{
	define_as = 'GRASS_DRY',
	name = 'grass',
	display = '.', color=colors.GREEN, back_color=colors.GREEN,
	image = 'tiles/terrain/nature/drygrass.png'
}

newEntity{
	define_as = 'GRASS_DARK',
	name = 'grass',
	display = '.', color=colors.GREEN, back_color=colors.GREEN,
	image = 'tiles/terrain/nature/darkgrass.png'
}

newEntity{
	define_as = 'GRASS_LAWN',
	name = 'grass',
	display = '.', color=colors.GREEN, back_color=colors.GREEN,
	image = 'tiles/terrain/nature/lawngrass.png'
}

newEntity{
	define_as = 'WALL',
	name = 'wall',
	always_remember = true,
	does_block_move = true,
	block_sight = true,
	air_level = -20,
	dig = 'FLOOR',
}

newEntity{
	base = 'WALL',
	define_as = 'WALL_BRICK_DARK',
	display = 'n',
	image = 'tiles/terrain/walls/brick_dark.png'

}

newEntity{
	--base = 'DOOR',
	define_as = 'WALL_BRICK_DARK_DOOR_BACK',
	display = 'd',
	image = 'tiles/terrain/walls/brick_dark_door_back.png'

}

newEntity{
	--base = 'DOOR',
	define_as = 'WALL_BRICK_DARK_DOOR',
	display = 'd',
	image = 'tiles/terrain/walls/brick_dark_door_back.png'

}

newEntity{
	--base = 'DOOR',
	define_as = 'DOOR_WOOD_DOUBLE',
	display = 'O',
	image = 'tiles/terrain/doors/wooden_double.png',
	tint_r = 1.5, tint_g = 0.5, tint_b = 0.5

}

newEntity{
	--base = 'DOOR',
	define_as = 'CABINET_WOOD',
	display = 'C',
	image = 'tiles/furniture/cabinet_wooden.png'
}

newEntity{
	--base = 'DOOR',
	define_as = 'COUNTER_WOOD_RED',
	display = 'c',
	image = 'tiles/terrain/furniture/counter_wooden_red.png'
}

--[[newEntity{
	base = 'WALL',
	define_as = 'WALL_BRICK_DARK',
	color=colors.GREEN,
	name = 'brickwall',
	image = 'tiles/terrain/walls/brick.png',
	display = '#', color_br=250, color_bg=250, color_bb=250
}]]

--[[newEntity{
	base = 'WALL',
	define_as = 'DOOR_BRICK_DARK',
	name = 'door', image = 'tiles/terrain/walls/brick.png',
	display = ' ', color_br=250, color_bg=250, color_bb=250
}]]

newEntity{
	define_as = 'FLOOR_WOOD_ONE',
	name = 'wood floor', image = 'tiles/terrain/floors/woodfloor.png',
	display = ' ', color_br=250, color_bg=250, color_bb=250
}

newEntity{
	define_as = 'FLOOR_WOOD_TWO',
	name = 'wood floor', image = 'tiles/terrain/floors/woodfloor2.png',
	display = ' ', color_br=250, color_bg=250, color_bb=250
}

newEntity{
	define_as = 'FLOOR_CHECKERBOARD',
	name = 'wood floor', image = 'tiles/terrain/floors/checkfloor.png',
	display = ' ', color_br=250, color_bg=250, color_bb=250
}

newEntity{
	define_as = 'PAVEMENT',
	name = 'pavement',
	display = '.',
	image = 'tiles/terrain/floors/pavement.png'
}

newEntity{
	define_as = 'PAVEMENT',
	name = 'pavement',
	display = '.',
	image = 'tiles/terrain/floors/pavement.png'
}
