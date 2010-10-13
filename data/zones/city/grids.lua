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
	name = 'street', image = 'tiles/terrain/floors/road_plain.png',
	display = ' ', back_color=colors.BLACK
}
newEntity{
	define_as = 'STREETLINE',
	name = 'street-1', image = 'tiles/terrain/floors/road_yellowdash.png',
	display = '-', color = colors.YELLOW, back_color=colors.BLACK,
}

newEntity{
	define_as = 'STREETLINEB',
	name = 'street-2', image = 'tiles/terrain/floors/road_yellowdashV.png',
	display = '|', color = colors.YELLOW, back_color=colors.BLACK,
}

newEntity{
	define_as = 'STREETLINEC',
	name = 'street-3', image = 'tiles/terrain/floors/road_yellowdashX.png',
	display = '.', color = colors.YELLOW, back_color=colors.BLACK,
	tooltip = 'street3'
}

newEntity{
	define_as = 'KERBTOP',
	name = 'kerb-top', image = 'tiles/terrain/floors/road_kerb_T.png',
	display = ' ', color = colors.YELLOW, back_color=colors.BLACK,
}

newEntity{
	define_as = 'KERBTOPDRAIN',
	name = 'kerb-top-drain', image = 'tiles/terrain/floors/road_kerb_T_drain.png',
	display = ' ', color = colors.YELLOW, back_color=colors.BLACK,
}

newEntity{
	define_as = 'KERBRIGHT',
	name = 'kerb-right', image = 'tiles/terrain/floors/road_kerb_R.png',
	display = ' ', color = colors.YELLOW, back_color=colors.BLACK,
}

newEntity{
	define_as = 'KERBRIGHTDRAIN',
	name = 'kerb-right-drain', image = 'tiles/terrain/floors/road_kerb_R_drain.png',
	display = ' ', color = colors.YELLOW, back_color=colors.BLACK,
}

newEntity{
	define_as = 'KERBLEFT',
	name = 'kerb-left', image = 'tiles/terrain/floors/road_kerb_L.png',
	display = ' ', color = colors.YELLOW, back_color=colors.BLACK,
}

newEntity{
	define_as = 'KERBLEFTDRAIN',
	name = 'kerb-left-drain', image = 'tiles/terrain/floors/road_kerb_L_drain.png',
	display = ' ', color = colors.YELLOW, back_color=colors.BLACK,
}

newEntity{
	define_as = 'KERBBOTTOM',
	name = 'kerb-bottom', image = 'tiles/terrain/floors/road_kerb_B.png',
	display = ' ', color = colors.YELLOW, back_color=colors.BLACK,
}

newEntity{
	define_as = 'KERBBOTTOMDRAIN',
	name = 'kerb-bottom-drain', image = 'tiles/terrain/floors/road_kerb_B_drain.png',
	display = ' ', color = colors.YELLOW, back_color=colors.BLACK,
}

newEntity{
	define_as = 'KERBTL',
	name = 'kerb-tl', image = 'tiles/terrain/floors/road_kerb_TL_corner.png',
	display = ' ', color = colors.YELLOW, back_color=colors.BLACK,
}

newEntity{
	define_as = 'KERBTR',
	name = 'kerb-tr', image = 'tiles/terrain/floors/road_kerb_TR_corner.png',
	display = ' ', color = colors.YELLOW, back_color=colors.BLACK,
}

newEntity{
	define_as = 'KERBBL',
	name = 'kerb-bl', image = 'tiles/terrain/floors/road_kerb_BL_corner.png',
	display = ' ', color = colors.YELLOW, back_color=colors.BLACK,
}

newEntity{
	define_as = 'KERBBR',
	name = 'kerb-br', image = 'tiles/terrain/floors/road_kerb_BR_corner.png',
	display = ' ', color = colors.YELLOW, back_color=colors.BLACK,
}

newEntity{
	define_as = 'KERBQ',
	name = 'kerb-q', image = 'tiles/terrain/floors/road_kerb_q.png',
	display = ' ', color = colors.YELLOW, back_color=colors.BLACK,
}

newEntity{
	define_as = 'KERBF',
	name = 'kerb-f', image = 'tiles/terrain/floors/road_kerb_f.png',
	display = ' ', color = colors.YELLOW, back_color=colors.BLACK,
}

newEntity{
	define_as = 'KERBJ',
	name = 'kerb-j', image = 'tiles/terrain/floors/road_kerb_j.png',
	display = ' ', color = colors.YELLOW, back_color=colors.BLACK,
}

newEntity{
	define_as = 'KERBK',
	name = 'kerb-k', image = 'tiles/terrain/floors/road_kerb_k.png',
	display = ' ', color = colors.YELLOW, back_color=colors.BLACK,
}

newEntity{
   define_as = 'WINDOW',
   name = 'window', --image = 'tiles/terrain/windows/window1.png',
   display = 'O', color_r=182, color_g=215, color_b=125,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = false,
   tooltip = 'A wooden framed window.'
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
	--tint_r = 1.5, tint_g = 0.5, tint_b = 0.5

}

newEntity{
	--base = 'DOOR',
	define_as = 'CABINET_WOOD',
	display = 'C',
	image = 'tiles/terrain/furniture/cabinet_wooden.png'
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
	display = '.', color_br=250, color_bg=250, color_bb=250
}

newEntity{
	define_as = 'FLOOR_CHECKERBOARD',
	name = 'checkerboard floor', image = 'tiles/terrain/floors/checkfloor.png',
	display = ' ', color_br=250, color_bg=250, color_bb=250
}

newEntity{
	define_as = 'PAVEMENT',
	name = 'pavement',
	display = '.',
	image = 'tiles/terrain/floors/pavement.png'
}

newEntity{
   base = 'WALL',
   define_as = 'WALL_DARK_PLANK',
   name = 'plank wall', image = 'tiles/terrain/walls/wall_dark_plank.png',
   tooltip = 'A shaky wooden plank wall.'
}

newEntity{
   base = 'WINDOW',
   define_as = 'WINDOW_DARK_PLANK',
   name = 'plank window', image = 'tiles/terrain/windows/window_dark_plank.png',
   tooltip = 'A dodgy wooden plank window.'
}

newEntity{
   --base = 'DOOR',
   define_as = 'DOOR_DARK_PLANK',
   name = 'plank door', image = 'tiles/terrain/doors/door_dark_plank.png',
   tooltip = 'A poorly constructed wooden plank door.'
}

newEntity{
   --base = 'DOOR',
   define_as = 'DOOR_GARAGE',
   name = 'garage door', image = 'tiles/terrain/doors/door_garage.png',
   tooltip = 'A typical garage door.'
}

newEntity{
   define_as = 'TABLE',
   name = 'table', image = 'tiles/terrain/furniture/table.png',
   display = 'T', color_r=238, color_g=33, color_b=12,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = false,
   tooltip = 'A simple wooden table.'
}

newEntity{
   define_as = 'CHAIR',
   name = 'chair', image = 'tiles/terrain/furniture/stool.png',
   display = 'c', color_r=238, color_g=33, color_b=12,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = 'A simple wooden chair.'
}

newEntity{
   base = 'TABLE',
   define_as = 'TABLE_WOODEN',
   name = 'wooden table', image = 'tiles/terrain/furniture/wood_table1.png',
   tooltip = 'A normal wooden table.'
}

newEntity{
   base = 'CHAIR',
   define_as = 'CHAIR_WOODEN',
   name = 'wooden chair', image = 'tiles/terrain/furniture/wood_chair1.png',
   tooltip = 'A normal wooden chair.'
}

newEntity{
   define_as = 'BED',
   name = 'bed',
   display = 'B', color_r=28, color_g=28, color_b=215,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = false,
   tooltip = 'A bed. Looks comfortable.'
}

newEntity{
   base = 'BED',
   define_as = 'BED_WOODEN_N',
   image = 'tiles/terrain/furniture/bed_wooden_N.png'
}

newEntity{
   base = 'BED',
   define_as = 'BED_WOODEN_S',
   image = 'tiles/terrain/furniture/bed_wooden_S.png'
}

newEntity{
   base = 'BED',
   define_as = 'BED_WOODEN_E',
   image = 'tiles/terrain/furniture/bed_wooden_E.png'
}

newEntity{
   base = 'BED',
   define_as = 'BED_WOODEN_W',
   image = 'tiles/terrain/furniture/bed_wooden_W.png'
}

newEntity{
   define_as = 'SOFA',
   name = 'sofa',
   display = 'S', color_r=215, color_g=28, color_b=28,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = 'A sofa. Looks comfortable.'
}

newEntity{
   base = 'SOFA',
   define_as = 'SOFA_DOWN_1',
   image = 'tiles/terrain/furniture/sofa_down_1.png'
}

newEntity{
   base = 'SOFA',
   define_as = 'SOFA_DOWN_2',
   image = 'tiles/terrain/furniture/sofa_down_2.png'
}

newEntity{
   base = 'SOFA',
   define_as = 'SOFA_UP_1',
   image = 'tiles/terrain/furniture/sofa_up_1.png'
}

newEntity{
   base = 'SOFA',
   define_as = 'SOFA_UP_2',
   image = 'tiles/terrain/furniture/sofa_up_2.png'
}

newEntity{
   base = 'SOFA',
   define_as = 'SOFA_RIGHT_1',
   image = 'tiles/terrain/furniture/sofa_right_1.png'
}

newEntity{
   base = 'SOFA',
   define_as = 'SOFA_RIGHT_2',
   image = 'tiles/terrain/furniture/sofa_right_2.png'
}

newEntity{
   base = 'SOFA',
   define_as = 'SOFA_LEFT_1',
   image = 'tiles/terrain/furniture/sofa_left_1.png'
}

newEntity{
   base = 'SOFA',
   define_as = 'SOFA_LEFT_2',
   image = 'tiles/terrain/furniture/sofa_left_2.png'
}


newEntity{
   define_as = 'SHELF',
   name = 'shelf',
   display = ']', color_r=88, color_g=88, color_b=88,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = 'A shelf.'
}

newEntity{
   base = 'SHELF',
   define_as = 'SHELF_WOOD',
   name = 'wooden shelf', image = 'tiles/terrain/furniture/shelf_wooden.png',
   tooltip = 'A simple wooden shelf.'
}

newEntity{
   base = 'SHELF',
   define_as = 'SHELF_METAL',
   name = 'metal shelf', image = 'tiles/terrain/furniture/shelf_metal.png',
   tooltip = 'A metal shelf, used for storing tools and paint thinner.'
}

newEntity{
   define_as = 'PLANT',
   name = 'plant', image = 'tiles/terrain/furniture/building_plant1.png',
   display = '£', color_r=125, color_g=125, color_b=145,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = true,
   tooltip = 'some plant to operate the building.'
}

newEntity{
   base = 'PLANT',
   define_as = 'PLANT_AHU',
   name = 'air handling plant', image = 'tiles/terrain/furniture/ahu_plant1.png',
   tooltip = 'some air handling equipment to ventilate the building.'
}

newEntity{
   base = 'PLANT',
   define_as = 'PLANT_MCP',
   name = 'control panel', image = 'tiles/terrain/furniture/mcp_plant1.png',
   tooltip = 'a mechanical control panel to operate the building plant.'
}

newEntity{
   base = 'PLANT',
   define_as = 'PLANT_BOILER',
   name = 'boiler', image = 'tiles/terrain/furniture/boiler_plant1.png',
   tooltip = 'a gas fired boiler, heats the building.'
}

newEntity{
   base = 'PLANT',
   define_as = 'PLANT_ITHUB',
   name = 'i.t. cabinet', image = 'tiles/terrain/furniture/ithub_plant1.png',
   tooltip = 'a glass fronted cabinet containing various I.T. related equipment.'
}

newEntity{
   base = 'PLANT',
   define_as = 'PLANT_COMMS',
   name = 'incoming comms', image = 'tiles/terrain/furniture/comms_plant1.png',
   tooltip = 'the equipment handling the incoming communications link to the building.'
}

newEntity{
   base = 'PLANT',
   define_as = 'PLANT_ELEC',
   name = 'electric supply', image = 'tiles/terrain/furniture/ahu_plant1.png',
   tooltip = 'the switchboard handling the incoming electrical supply for the building.'
}

newEntity{
   define_as = 'SINK',
   name = 'sink', image = 'tiles/terrain/furniture/sink1.png',
   display = '+', color_r=238, color_g=33, color_b=12,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = false,
   tooltip = 'A stainless steel kitchen sink set in to a counter, with some storage underneath.'
}

newEntity{
   define_as = 'WC',
   name = 'toilet', image = 'tiles/terrain/furniture/wc1.png',
   display = 'W', color_r=238, color_g=2383, color_b=238,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = 'A white vitreous enamel toilet pan and cistern.'
}

newEntity{
   define_as = 'WHB',
   name = 'wash hand basin', image = 'tiles/terrain/furniture/basin1.png',
   display = 'N', color_r=238, color_g=238, color_b=238,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = 'A white vitreous enamel basin.'
}

newEntity{
   define_as = 'TELEVISION',
   name = 'television', image = 'tiles/terrain/furniture/tv.png',
   display = 'x', color_r=55, color_g=55, color_b=55,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = false,
   tooltip = 'A television.'
}

newEntity{
   base = 'TELEVISION',
   define_as = 'LARGE_TELEVISION',
   name = 'large television', image = 'tiles/terrain/furniture/tv.png',
   display = 'X', color_r=55, color_g=55, color_b=55,
   tooltip = 'A large television.'
}

newEntity{
   define_as = 'FRIDGE',
   name = 'refrigerator', image = 'tiles/terrain/furniture/fridge.png',
   display = 'F', color_r=200, color_g=190, color_b=190,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = true,
   tooltip = 'An upright refrigerator.'
}

newEntity{
   define_as = 'STAIR_WOODEN_UP',
   name = 'stairs up', --image = 'tiles/terrain/floors/stair_wooden_up.png',
   display = '<', color_r=122, color_g=122, color_b=75,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = 'Wooden stairs leading up.'
}

newEntity{
   base = 'STAIR_WOODEN_UP',
   define_as = 'STAIR_STONE_UP',
   name = 'stone up stairs', --image = 'tiles/terrain/floors/stair_stone_up.png',
   display = '<', color_r=110, color_g=110, color_b=110,
   tooltip = 'Stone stairs leading up.'
}

newEntity{
   define_as = 'STAIR_WOODEN_DOWN',
   name = 'stairs down', --image = 'tiles/terrain/floors/stair_wooden_down.png',
   display = '>', color_r=122, color_g=122, color_b=75,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = 'Wooden stairs leading down.'
}

newEntity{
   base = 'STAIR_WOODEN_DOWN',
   define_as = 'STAIR_STONE_DOWN',
   name = 'stone down stairs', --image = 'tiles/terrain/floors/stair_stone_down.png',
   display = '<', color_r=110, color_g=110, color_b=110,
   tooltip = 'Stone stairs leading down.'
}

newEntity{
   define_as = 'SHOWER',
   name = 'shower', --image = 'tiles/terrain/furniture/shower.png',
   display = 'H', color_r=238, color_g=238, color_b=238,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = 'An electric shower mounted above a white tray.'
}

newEntity{
   define_as = 'BATH',
   name = 'bath', image = 'tiles/terrain/furniture/bath1.png',
   display = 'A', color_r=238, color_g=238, color_b=238,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = 'A white plastic bath.'
}

newEntity{
   base = 'BATH',
   define_as = 'BATH_N',
   image = 'tiles/terrain/furniture/bath_N.png'
}

newEntity{
   base = 'BATH',
   define_as = 'BATH_S',
   image = 'tiles/terrain/furniture/bath_S.png'
}

newEntity{
   base = 'BATH',
   define_as = 'BATH_E',
   image = 'tiles/terrain/furniture/bath_E.png'
}

newEntity{
   base = 'BATH',
   define_as = 'BATH_W',
   image = 'tiles/terrain/furniture/bath_W.png'
}

newEntity{
   define_as = 'DESK_WOODEN',
   name = 'desk', image = 'tiles/terrain/furniture/desk1.png',
   display = 'u', color_r=190, color_g=120, color_b=35,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = 'A cheap but functional desk.'
}

newEntity{
   define_as = 'PLANTPOT_FIXED',
   name = 'plant pot', image = 'tiles/terrain/furniture/plant_pot1.png',
   display = 'v', color_r=222, color_g=222, color_b=200,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = false,
   tooltip = 'A plant in a pot.'
}

newEntity{
   define_as = 'LAMP_STANDARD',
   name = 'standard lamp', image = 'tiles/terrain/furniture/lamp_standard.png',
   display = 't', color_r=222, color_g=222, color_b=200,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = 'A standard lamp.'
}

newEntity{
   define_as = 'OVEN',
   name = 'oven', image = 'tiles/terrain/furniture/oven1.png',
   display = '*', color_r=222, color_g=222, color_b=238,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = false,
   tooltip = 'A catering oven, with four gas rings on top.'
}

newEntity{
   define_as = 'LOUVRE',
   name = 'louvre', image = 'tiles/terrain/walls/louvre1.png',
   display = ':', color_r=199, color_g=199, color_b=210,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = true,
   tooltip = 'A building mounted ventilation louvre.'
}

newEntity{
   define_as = 'FENCE',
   name = 'fence', --image = 'tiles/terrain/walls/fence_base.png',
   display = '-', color_r=199, color_g=199, color_b=210,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = false,
   tooltip = 'A fence.'
}

newEntity{
   base = 'FENCE',
   define_as = 'FENCE_WOODEN',
   image = 'tiles/terrain/walls/fence_wood.png',
   tooltip = 'A wooden fence.'
}

newEntity{
   base = 'FENCE',
   define_as = 'FENCE_IRON',
   image = 'tiles/terrain/walls/fence_iron.png',
   tooltip = 'Iron railings.'
}

newEntity{
   --base = 'DOOR',
   define_as = 'GATE_IRON',
   image = 'tiles/terrain/doors/gate_iron.png',
   display = '+', color_r=199, color_g=199, color_b=210,
   block_sight = false,
   tooltip = 'An iron gate.'
}

newEntity{
   define_as = 'POOL_TABLE',
   name = 'pool table', image = 'tiles/terrain/furniture/pooltable.png',
   display = '#', color_r=20, color_g=199, color_b=20,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = false,
   tooltip = 'A pool table.'
}

newEntity{
   base = 'POOL_TABLE',
   define_as = 'POOL_TABLE_E',
   image = 'tiles/terrain/furniture/pooltable_E.png',
   display = '[', color_r=20, color_g=199, color_b=20
}

newEntity{
   base = 'POOL_TABLE',
   define_as = 'POOL_TABLE_W',
   image = 'tiles/terrain/furniture/pooltable_W.png',
   display = ']', color_r=20, color_g=199, color_b=20
}

newEntity{
   base = 'POOL_TABLE',
   define_as = 'POOL_TABLE_N',
   image = 'tiles/terrain/furniture/pooltable_N.png',
   display = '[', color_r=20, color_g=199, color_b=20
}

newEntity{
   base = 'POOL_TABLE',
   define_as = 'POOL_TABLE_S',
   image = 'tiles/terrain/furniture/pooltable_S.png',
   display = ']', color_r=20, color_g=199, color_b=20
}

newEntity{
   define_as = 'HIFI',
   name = 'hi-fi', image = 'tiles/terrain/furniture/hifi.png',
   display = 'M', color_r=25, color_g=25, color_b=40,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = false,
   tooltip = 'A hi-fi system.'
}

newEntity{
	define_as = 'FLOOR_WOOD_THREE',
	name = 'wooden floor 3',
	display = '.',
	image = 'tiles/terrain/floors/woodfloor3.png'
}

newEntity{
	define_as = 'FLOOR_WOOD_THREE_DIRT',
	name = 'dirty wooden floor 3 3',
	display = '.',
	image = 'tiles/terrain/floors/woodfloor3dirty.png'
}

newEntity{
	define_as = 'CARPET_OFF_WHITE',
	name = 'off white carpet',
	display = '.',
	image = 'tiles/terrain/floors/carpetoffwhite.png'
}

newEntity{
	define_as = 'CARPET_ZEBRA',
	name = 'zebra carpet',
	display = '.',
	image = 'tiles/terrain/floors/carpetzebra.png'
}

newEntity{
	define_as = 'CONCRETE_FLOOR',
	name = 'concrete floor',
	display = '.',
	image = 'tiles/terrain/floors/concretefloor1.png'
}

newEntity{
	define_as = 'CONCRETE_CRACK_1',
	name = 'cracked concrete 1',
	display = 'x',
	image = 'tiles/terrain/floors/concfloorcrack1.png'
}

newEntity{
	define_as = 'CONCRETE_CRACK_2',
	name = 'cracked concrete 2',
	display = 'x',
	image = 'tiles/terrain/floors/concfloorcrack2.png'
}

newEntity{
	define_as = 'FLOOR_BIGCHECK_BLUE',
	name = 'checked blue floor',
	display = '+',
	image = 'tiles/terrain/floors/bluetile.png'
}

newEntity{
	define_as = 'FLOOR_BIGCHECK_BLUE_DIRTY',
	name = 'dirty checked blue floor',
	display = '+',
	image = 'tiles/terrain/floors/bluetiledirty.png'
}

newEntity{
	define_as = 'FLOOR_BIGCHECK_BLACK',
	name = 'checked black floor',
	display = '+',
	image = 'tiles/terrain/floors/blacktile.png'
}

newEntity{
	define_as = 'FLOOR_BIGCHECK_BLACK_DIRTY',
	name = 'dirty checked black floor',
	display = '+',
	image = 'tiles/terrain/floors/blacktiledirty.png'
}

newEntity{
	define_as = 'FLOOR_BIGCHECK_GREEN',
	name = 'checked green floor',
	display = '+',
	image = 'tiles/terrain/floors/greentile.png'
}

newEntity{
	define_as = 'FLOOR_BIGCHECK_GREEN_DIRTY',
	name = 'dirty checked green floor',
	display = '+',
	image = 'tiles/terrain/floors/greentiledirty.png'
}

newEntity{
	define_as = 'FLOOR_BIGCHECK_RED',
	name = 'checked red floor',
	display = '+',
	image = 'tiles/terrain/floors/redtile.png'
}

newEntity{
	define_as = 'FLOOR_BIGCHECK_RED_DIRTY',
	name = 'dirty checked red floor',
	display = '+',
	image = 'tiles/terrain/floors/redtiledirty.png'
}

newEntity{
	define_as = 'FLOOR_BRICK_CLAY_ONE',
	name = 'clay brick floor 1',
	display = ':',
	image = 'tiles/terrain/floors/brickfloor.png'
}

newEntity{
	define_as = 'FLOOR_BRICK_CLAY_TWO',
	name = 'clay brick floor 2',
	display = ':',
	image = 'tiles/terrain/floors/brickfloor_2.png'
}

newEntity{
	define_as = 'CARPET_GREY',
	name = 'grey carpet',
	display = ',',
	image = 'tiles/terrain/floors/carpet.png'
}

newEntity{
	define_as = 'FLOOR_TILE_LARGE',
	name = 'large floor tile',
	display = '.',
	image = 'tiles/terrain/floors/floortile2.png'
}

newEntity{
	define_as = 'FLOOR_TILE_OFFICE',
	name = 'office floor tile',
	display = '.',
	image = 'tiles/terrain/floors/office_floor_tiles.png'
}

newEntity{
	define_as = 'FLOOR_TILE_TINY',
	name = 'tiny tiles',
	display = ':',
	image = 'tiles/terrain/floors/small_tiles.png'
}

newEntity{
	define_as = 'FLOOR_TILE_YORKSTONE',
	name = 'yorkstone floor',
	display = '.',
	image = 'tiles/terrain/floors/travertine.png'
}

newEntity{
	define_as = 'FLOOR_BRICK_GENERIC',
	name = 'generic brick floor',
	display = ',',
	image = 'tiles/terrain/floors/brickfloor_3.png'
}

newEntity{
	define_as = 'FLOOR_STONE_NICE',
	name = 'nice stone floor',
	display = '.',
	image = 'tiles/terrain/floors/nicestonefloor.png'
}

newEntity{
	define_as = 'FLOOR_TILE_MARBLE',
	name = 'marble floor tiles',
	display = ':',
	image = 'tiles/terrain/floors/marble_tiles1.png'
}

newEntity{
	define_as = 'FLOOR_COBBLESTONE_ROUGH',
	name = 'rough cobblestone floor',
	display = ':',
	image = 'tiles/terrain/floors/cobble_floor.png'
}

newEntity{
   base = 'WALL',
   define_as = 'WALL_DRY',
   name = 'drywall', image = 'tiles/terrain/walls/plasterwoodwall.png',
   tooltip = 'A plaster wall.'
}

newEntity{
   base = 'WALL',
   define_as = 'WALL_DRY_DIRTY',
   name = 'old drywall', image = 'tiles/terrain/walls/plasteroldwoodwall.png',
   tooltip = 'A dirty plaster wall.'
}

newEntity{
   base = 'WALL',
   define_as = 'WALL_DRY_DIRTY_CRACK',
   name = 'cracked dirty drywall', image = 'tiles/terrain/walls/plasteroldwoodcrackedwa.png',
   tooltip = 'A cracked dirty plaster wall.'
}

newEntity{
   base = 'WALL',
   define_as = 'WALL_DRY_DIRTY_BROKEN',
   name = 'broken dirty drywall', image = 'tiles/terrain/walls/plasteroldbrokenwoodwal.png',
   tooltip = 'A broken dirty plaster wall.'
}

newEntity{
   base = 'WALL',
   define_as = 'WALL_CORRUGATED_SMALL',
   name = 'corrugated wall 1', image = 'tiles/terrain/walls/corrugated1.png',
   tooltip = 'corrugated metal wall.'
}

newEntity{
   base = 'WALL',
   define_as = 'WALL_CORRUGATED_LARGE',
   name = 'corrugated wall 2', image = 'tiles/terrain/walls/corrugated2.png',
   tooltip = 'corrugated metal wall.'
}

newEntity{
   base = 'WALL',
   define_as = 'WALL_SLATTED',
   name = 'slatted wooden wall', image = 'tiles/terrain/walls/wall_slatted.png',
   tooltip = 'A slatted wall.'
}

newEntity{
   base = 'WALL',
   define_as = 'WALL_ROUGH_BRICK',
   name = 'roguh brick wall', image = 'tiles/terrain/walls/wall_rough_brick.png',
   tooltip = 'A rough brick wall.'
}

newEntity{
   base = 'WALL',
   define_as = 'WALL_COLUMN',
   name = 'column wall', image = 'tiles/terrain/walls/column_wall.png',
   tooltip = 'A column.'
}

newEntity{
   base = 'WALL',
   define_as = 'WALL_HALF_BRICK',
   name = 'plaster brick wall', image = 'tiles/terrain/walls/half_brick.png',
   tooltip = 'Brick / plaster wall.'
}

newEntity{
   define_as = 'STATUE',
   image = 'tiles/terrain/misc/statue.png',
   display = '&', color_r=199, color_g=199, color_b=210,
   block_sight = false,
   does_block_move = true,
   tooltip = 'A statue.'
}

newEntity{
   define_as = 'TREE_SMALL',
   image = 'tiles/terrain/nature/objects/tree1.png',
   display = 'T', color_r=19, color_g=199, color_b=21,
   block_sight = false,
   does_block_move = true,
   tooltip = 'A small tree.'
}

newEntity{
   --base = 'DOOR',
   define_as = 'DOOR_DOTS',
   image = 'tiles/terrain/doors/door_dots.png',
   display = '+', color_r=199, color_g=199, color_b=210,
   block_sight = true,
   tooltip = 'A door.'
}

newEntity{
   define_as = 'OVEN',
   image = 'tiles/terrain/furniture/oven1.png',
   display = '*', color_r=199, color_g=199, color_b=210,
   block_sight = false,
   does_block_move = true,
   tooltip = 'An oven with four gas hobs.'
}

newEntity{
   base = 'WINDOW',
   define_as = 'WINDOW_BRICK_DARK',
   name = 'dark brick window', image = 'tiles/terrain/walls/brick_dark_window.png',
}

newEntity{
   define_as = 'ART',
   image = 'tiles/terrain/misc/urn1.png',
   display = 'u', color_r=19, color_g=185, color_b=25,
   block_sight = false,
   does_block_move = true,
   tooltip = 'Art on display'
}

newEntity{
   base = 'ART',
   define_as = 'URN',
   image = 'tiles/terrain/misc/urn1.png',
   tooltip = 'A valuable urn'
}

newEntity{
   base = 'ART',
   define_as = 'URN_DISPLAY_CASE',
   image = 'tiles/terrain/misc/urn_display_case1.png',
   tooltip = 'A valuable urn in a glass display case'
}

newEntity{
   base = 'ART',
   define_as = 'DISPLAY_CASE_EMPTY',
   image = 'tiles/terrain/misc/display_case_empty.png',
   tooltip = 'An empty glass display case'
}

newEntity{
   base = 'ART',
   define_as = 'DISPLAY_STAND_EMPTY',
   image = 'tiles/terrain/misc/display_stand_empty.png',
   tooltip = 'An empty stand'
}

newEntity{
   --base = 'DOOR',
   define_as = 'DOOR_GLASS',
   image = 'tiles/terrain/doors/glassdoor.png',
   display = '+', color_r=199, color_g=199, color_b=210,
   block_sight = false,
   tooltip = 'A glass door.'
}

newEntity{
   --base = 'DOOR',
   define_as = 'DOOR_FANCY_1',
   image = 'tiles/terrain/doors/wooddoorinterior.png',
   display = '+', color_r=199, color_g=199, color_b=210,
   block_sight = true,
   tooltip = 'A nice door.'
}

newEntity{
   --base = 'DOOR',
   define_as = 'DOOR_FANCY_2',
   image = 'tiles/terrain/doors/wooddoornice.png',
   display = '+', color_r=199, color_g=199, color_b=210,
   block_sight = true,
   tooltip = 'A fancy door.'
}

newEntity{
   --base = 'DOOR',
   define_as = 'DOOR_METAL_RED',
   image = 'tiles/terrain/doors/redmetaldoor.png',
   display = '+', color_r=199, color_g=19, color_b=21,
   block_sight = true,
   tooltip = 'A red metal door.'
}

newEntity{
   --base = 'DOOR',
   define_as = 'DOOR_APART_1',
   image = 'tiles/terrain/doors/apartment_door.png',
   display = '+', color_r=199, color_g=199, color_b=210,
   block_sight = true,
   tooltip = 'A door.'
}

newEntity{
   --base = 'DOOR',
   define_as = 'DOOR_APART_2',
   image = 'tiles/terrain/doors/apartment_door2.png',
   display = '+', color_r=199, color_g=199, color_b=210,
   block_sight = true,
   tooltip = 'A door.'
}

newEntity{
   --base = 'DOOR',
   define_as = 'DOOR_SECURE',
   image = 'tiles/terrain/doors/security_door.png',
   display = '+', color_r=199, color_g=199, color_b=210,
   block_sight = true,
   tooltip = 'A door.'
}

newEntity{
   --base = 'DOOR',
   define_as = 'DOOR_SHACK',
   image = 'tiles/terrain/doors/shack_door.png',
   display = '+', color_r=199, color_g=199, color_b=210,
   block_sight = false,
   tooltip = 'A door.'
}

newEntity{
   define_as = 'MAILBOX',
   image = 'tiles/terrain/misc/mailbox1.png',
   display = '[', color_r=199, color_g=199, color_b=210,
   block_sight = false,
   does_block_move = false,
   tooltip = 'A mailbox.'
}

newEntity{
   define_as = 'LADDER_SEWER_OLD',
   image = 'tiles/terrain/misc/oldsewerladder.png',
   display = '<', color_r=199, color_g=199, color_b=210,
   block_sight = false,
   does_block_move = false,
   tooltip = 'An old ladder.'
}

newEntity{
   define_as = 'RUBBLE_ONE',
   image = 'tiles/terrain/misc/rubblepile1.png',
   display = '&', color_r=199, color_g=199, color_b=210,
   block_sight = false,
   does_block_move = true,
   tooltip = 'Some rubble.'
}

newEntity{
   define_as = 'RUBBLE_TWO',
   image = 'tiles/terrain/misc/rubblepile2.png',
   display = '&', color_r=199, color_g=199, color_b=210,
   block_sight = false,
   does_block_move = true,
   tooltip = 'Some rubble.'
}

newEntity{
   define_as = 'STONE_STAIR',
   image = 'tiles/terrain/misc/oldsewerstair.png',
   display = '&', color_r=199, color_g=199, color_b=210,
   block_sight = false,
   does_block_move = false,
   tooltip = 'Stone steps.'
}

newEntity{
	define_as = 'DIRT_DARK',
	name = 'dark dirt',
	display = '.', color=colors.GREEN, back_color=colors.GREEN,
	image = 'tiles/terrain/nature/darkdirt.png'
}

newEntity{
	define_as = 'DIRT',
	name = 'dirt',
	display = '.', color=colors.GREEN, back_color=colors.GREEN,
	image = 'tiles/terrain/nature/dirt.png'
}

newEntity{
	define_as = 'DIRT_CLAY',
	name = 'clay',
	display = '.', color=colors.GREEN, back_color=colors.GREEN,
	image = 'tiles/terrain/nature/dirtz.png'
}

newEntity{
	define_as = 'SAND',
	name = 'sand',
	display = '.', color=colors.YELLOW, back_color=colors.YELLOW,
	image = 'tiles/terrain/nature/sand.png'
}

newEntity{
	define_as = 'SAND_CORNER',
	name = 'sand corner',
	display = '.', color=colors.GREEN, back_color=colors.YELLOW,
	image = 'tiles/terrain/nature/sandcorner.png'
}

newEntity{
	define_as = 'SAND_SIDE',
	name = 'sand side',
	display = '.', color=colors.GREEN, back_color=colors.YELLOW,
	image = 'tiles/terrain/nature/sandside.png'
}

newEntity{
	define_as = 'BOULDER',
	name = 'boulder',
	display = '.', color=colors.GREEN, back_color=colors.GREEN,
	image = 'tiles/terrain/nature/objects/boulder1.png'
}

newEntity{
   define_as = 'SHIRT_RACK',
   image = 'tiles/terrain/furniture/shirt_rack.png',
   display = '%', color_r=19, color_g=185, color_b=25,
   block_sight = false,
   does_block_move = true,
   tooltip = 'Some shirts on a rack'
}

newEntity{
   define_as = 'PANTS_RACK',
   image = 'tiles/terrain/furniture/pants_rack.png',
   display = '%', color_r=19, color_g=185, color_b=25,
   block_sight = false,
   does_block_move = true,
   tooltip = 'Some pants on a rack'
}

newEntity{
   define_as = 'ORGAN',
   image = 'tiles/terrain/furniture/organ.png',
   display = '[', color_r=19, color_g=185, color_b=25,
   block_sight = false,
   does_block_move = true,
   tooltip = 'A church organ'
}

newEntity{
   define_as = 'ORGAN_PIPES',
   image = 'tiles/terrain/furniture/organ_pipes.png',
   display = ']', color_r=19, color_g=185, color_b=25,
   block_sight = false,
   does_block_move = true,
   tooltip = 'The pipes for the organ'
}

newEntity{
   define_as = 'CASH_REGISTER',
   image = 'tiles/terrain/furniture/register.png',
   display = '$', color_r=19, color_g=185, color_b=25,
   block_sight = false,
   does_block_move = true,
   tooltip = 'cash register. Contains money.'
}

newEntity{
   base = 'WINDOW',
   define_as = 'WINDOW_STORE',
   name = 'store window', image = 'tiles/terrain/windows/store_window.png',
}

newEntity{
   base = 'WALL',
   define_as = 'WALL_COBBLESTONE_GREY',
   name = 'cobblestone wall', image = 'tiles/terrain/walls/cobblestone_wall.png',
   tooltip = 'Brick / plaster wall.'
}

newEntity{
   base = 'WINDOW',
   define_as = 'WINDOW_STAINED_GLASS',
   name = 'stained glass window', image = 'tiles/terrain/windows/window_stainedglass.png',
}

newEntity{
   --base = 'DOOR',
   define_as = 'OLD_DOOR',
   image = 'tiles/terrain/doors/church_door.png',
   display = '+', color_r=199, color_g=199, color_b=210,
   block_sight = true,
   tooltip = 'An old sturdy door.'
}

newEntity{
   define_as = 'ALTAR',
   image = 'tiles/terrain/furniture/altar.png',
   display = '+', color_r=19, color_g=185, color_b=25,
   block_sight = false,
   does_block_move = true,
   tooltip = 'Praise the lord. An altar.'
}

newEntity{
   define_as = 'WATER',
   image = 'tiles/terrain/nature/water.png',
   display = '~', color_r=19, color_g=25, color_b=215,
   block_sight = false,
   does_block_move = true
}

newEntity{
   base = 'WINDOW',
   define_as = 'WINDOW_GRAND',
   name = 'grand window', image = 'tiles/terrain/windows/window_grand.png'
}

newEntity{
   base = 'WINDOW',
   define_as = 'WINDOW_HOUSE',
   name = 'house window', image = 'tiles/terrain/windows/window_house.png'
}

newEntity{
   base = 'WINDOW',
   define_as = 'WINDOW_HOUSE_DIRTY',
   name = 'dirty house window', image = 'tiles/terrain/windows/window_house_dirty.png'
}

newEntity{
   base = 'WINDOW',
   define_as = 'WINDOW_FLOWERS',
   name = 'window and flower box', image = 'tiles/terrain/windows/window_flowers.png'
}

newEntity{
   base = 'WINDOW',
   define_as = 'WINDOW_HOUSE_FANCY',
   name = 'fancy house window', image = 'tiles/terrain/windows/window_house_fancy.png'
}

newEntity{
   base = 'DOWN',
   define_as = 'MANHOLE_DOWN',
   name = 'manhole down', image = 'tiles/terrain/misc/manhole.png',
   tooltip = 'A manhole leading down'
}

newEntity{
   --base = 'DOOR',
   define_as = 'DOOR_OPEN',
   image = 'tiles/terrain/doors/door_open.png',
   display = '+', color_r=199, color_g=199, color_b=210,
   block_sight = false,
   tooltip = 'An open door.'
}

newEntity{
	base = 'WALL',
	define_as = 'WALL_STONE_LARGE',
	display = '=',
	image = 'tiles/terrain/walls/largestonewall.png'
}

newEntity{
	base = 'WALL',
	define_as = 'WALL_STONE_MEDIUM',
	display = '=',
	image = 'tiles/terrain/walls/mediumstonewall.png'
}

newEntity{
	define_as = 'ROAD_CROSSWALK',
	name = 'crosswalk', image = 'tiles/terrain/floors/road_crosswalk.png',
	display = ' ', color_br=80, color_bg=80, color_bb=80
}

newEntity{
	define_as = 'ROAD_PLAIN',
	name = 'plain road', image = 'tiles/terrain/floors/road_plain.png',
	display = ' ', color_br=20, color_bg=20, color_bb=20
}

newEntity{
	define_as = 'ROAD_HYELLOWDASH',
	name = 'road lines horizontal', image = 'tiles/terrain/floors/road_yellowdash.png',
	display = ' ', color_br=40, color_bg=40, color_bb=40
}

newEntity{
	define_as = 'ROAD_VYELLOWDASH',
	name = 'road lines vertical', image = 'tiles/terrain/floors/road_yellowdashv.png',
	display = ' ', color_br=40, color_bg=40, color_bb=40
}

newEntity{
   define_as = 'TREE_DEAD',
   image = 'tiles/terrain/nature/objects/tree_dead.png',
   display = 'T', color_r=19, color_g=19, color_b=21,
   block_sight = false,
   does_block_move = true,
   tooltip = 'A dead tree.'
}

newEntity{
   define_as = 'BUSH_LARGE',
   image = 'tiles/terrain/nature/objects/bush_large.png',
   display = '8', color_r=19, color_g=199, color_b=21,
   block_sight = false,
   does_block_move = true,
   tooltip = 'A large bush.'
}

newEntity{
   define_as = 'HEDGE_TALL',
   display = 'H', color_r=19, color_g=199, color_b=21,
   block_sight = true,
   does_block_move = true,
   tooltip = 'A tall hedge.'
}

newEntity{
   base = 'HEDGE_TALL',
   define_as = 'HEDGE_TALL_LEFT',
   image = 'tiles/terrain/nature/objects/hedge_tall_ledge.png'
}

newEntity{
   base = 'HEDGE_TALL',
   define_as = 'HEDGE_TALL_CENTER',
   image = 'tiles/terrain/nature/objects/hedge_tall_center.png'
}

newEntity{
   base = 'HEDGE_TALL',
   define_as = 'HEDGE_TALL_RIGHT',
   image = 'tiles/terrain/nature/objects/hedge_tall_redge.png'
}

newEntity{
   base = 'HEDGE_TALL',
   define_as = 'HEDGE_TALL_UD_TOP',
   image = 'tiles/terrain/nature/objects/hedge_tall_ud_top.png'
}

newEntity{
   base = 'HEDGE_TALL',
   define_as = 'HEDGE_TALL_UD_CENTER',
   image = 'tiles/terrain/nature/objects/hedge_tall_ud_center.png'
}

newEntity{
   base = 'HEDGE_TALL',
   define_as = 'HEDGE_TALL_UD_BOTTOM',
   image = 'tiles/terrain/nature/objects/hedge_tall_ud_bottom.png'
}

newEntity{
   define_as = 'CHAIN_LINK_FENCE',
   display = 'X', color_r=90, color_g=90, color_b=90,
   block_sight = false,
   does_block_move = true,
   tooltip = 'A chain-link fence.'
}

newEntity{
   base = 'CHAIN_LINK_FENCE',
   define_as = 'WALL_CHAIN_FENCE_EW_CENTER',
   image = 'tiles/terrain/walls/chainfencecenterEW.png'
}

newEntity{
   base = 'CHAIN_LINK_FENCE',
   define_as = 'WALL_CHAIN_FENCE_EW_LCORNER',
   image = 'tiles/terrain/walls/chainfencecornerEW.png'
}

newEntity{
   base = 'CHAIN_LINK_FENCE',
   define_as = 'WALL_CHAIN_FENCE_EW_RCORNER',
   image = 'tiles/terrain/walls/chainfencecornerEW2.png'
}

newEntity{
   base = 'CHAIN_LINK_FENCE',
   define_as = 'WALL_CHAIN_FENCE_EW_BLCORNER',
   image = 'tiles/terrain/walls/chainfencebottomcornerEW.png'
}

newEntity{
   base = 'CHAIN_LINK_FENCE',
   define_as = 'WALL_CHAIN_FENCE_EW_BRCORNER',
   image = 'tiles/terrain/walls/chainfencebottomcornerEW2.png'
}

newEntity{
   base = 'CHAIN_LINK_FENCE',
   define_as = 'WALL_CHAIN_FENCE_NS_LEFT',
   image = 'tiles/terrain/walls/chainfenceNS.png'
}

newEntity{
   base = 'CHAIN_LINK_FENCE',
   define_as = 'WALL_CHAIN_FENCE_NS_RIGHT',
   image = 'tiles/terrain/walls/chainfenceNS2.png'
}

newEntity{
    base = 'SIDEWALK',
	define_as = 'SW_NORTHSOUTH',
	name = 'sidewalk NS', image = 'tiles/terrain/floors/sidewalk_NS.png'
}

newEntity{
    base = 'SIDEWALK',
	define_as = 'SW_EASTWEST',
	name = 'sidewalk EW', image = 'tiles/terrain/floors/sidewalk_EW.png'
}

newEntity{
    base = 'SIDEWALK',
	define_as = 'SW_CRACK_NS',
	name = 'sidewalk cracked NS', image = 'tiles/terrain/floors/sidewalk_crack_NS.png'
}

newEntity{
    base = 'SIDEWALK',
	define_as = 'SW_CRACK_EW',
	name = 'sidewalk cracked EW', image = 'tiles/terrain/floors/sidewalk_crack_EW.png'
}

newEntity{
   define_as = 'TOMBSTONE',
   display = '+', color_r=19, color_g=54, color_b=35,
   block_sight = false,
   does_block_move = true,
   tooltip = 'Somebody died.'
}

newEntity{
    base = 'TOMBSTONE',
	define_as = 'TOMBSTONE_1',
	name = 'tombstone 1', image = 'tiles/terrain/misc/tombstone1.png'
}

newEntity{
    base = 'TOMBSTONE',
	define_as = 'TOMBSTONE_2',
	name = 'tombstone 2', image = 'tiles/terrain/misc/tombstone2.png'
}

newEntity{
    base = 'TOMBSTONE',
	define_as = 'TOMBSTONE_3',
	name = 'tombstone 3', image = 'tiles/terrain/misc/tombstone3.png'
}
