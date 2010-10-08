--A small house
--author: Mendonca
--Size: 15x10 tiles

defineTile('p', 'PAVEMENT')
defineTile('#', 'WALL_BRICK_DARK')
defineTile('=', 'FLOOR_WOOD_TWO', 'COUNTER_WOOD_RED')
defineTile(',', 'FLOOR_WOOD_TWO')
defineTile('c', 'CONCRETE_FLOOR')
defineTile('+', 'FLOOR_WOOD_TWO', 'SINK')
defineTile('D', 'WALL_BRICK_DARK_DOOR')
defineTile('O', 'WINDOW_BRICK_DARK')
defineTile('W', 'FLOOR_WOOD_TWO', 'WC')
defineTile('~', 'GRASS_ONE')
defineTile('N', 'FLOOR_WOOD_TWO', 'WHB')
defineTile('H', 'FLOOR_WOOD_TWO', 'SHOWER')
defineTile('C', 'FLOOR_WOOD_TWO', 'CHAIR_WOODEN')
defineTile('T', 'FLOOR_WOOD_TWO', 'TABLE_WOODEN')
defineTile('B', 'FLOOR_WOOD_TWO', 'BED_WOODEN_E')
defineTile('b', 'FLOOR_WOOD_TWO', 'BED_WOODEN_W')
defineTile('E', 'FLOOR_WOOD_TWO', 'BED_WOODEN_N')
defineTile('e', 'FLOOR_WOOD_TWO', 'BED_WOODEN_S')
defineTile('/', 'FLOOR_WOOD_TWO', 'SHELF_WOOD')
defineTile('x', 'FLOOR_WOOD_TWO', 'TELEVISION')
defineTile('X', 'FLOOR_WOOD_TWO', 'TELEVISION')
defineTile('F', 'FLOOR_WOOD_TWO', 'FRIDGE')
defineTile('S', 'FLOOR_WOOD_TWO', 'SOFA_LEFT_1')
defineTile('s', 'FLOOR_WOOD_TWO', 'SOFA_LEFT_2')
defineTile('<', 'FLOOR_WOOD_TWO', 'STAIR_WOODEN_UP')
defineTile('>', 'FLOOR_WOOD_TWO', 'STAIR_WOODEN_DOWN')
defineTile('A', 'FLOOR_WOOD_TWO', 'BATH_N')
defineTile('a', 'FLOOR_WOOD_TWO', 'BATH_S')

--Level zero:

return{
[[ppppppppppppccc]],
[[p#####O####pccc]],
[[p#WN#=+F,<#pccc]],
[[p#,,#,,,,,Dpppp]],
[[p#D##,CTC,#p~~~]],
[[p#,,,,,,,,#p~~~]],
[[pO,,,,S,,,Op~~~]],
[[p#X,,,s,,,#p~~~]],
[[p##O####O##p~~~]],
[[pppppppppppp~~~]]}

--Level One:
--return{
--[[]],
--[[ #####O####]],
--[[ #WN#,,,,>#]],
--[[ #A,#,#####]],
--[[ #a,D,D,Bb#]],
--[[ ####D#,,,#]],
--[[ OE,,,#,,,O]],
--[[ #e,/,#/,x#]],
--[[ ##O####O##]]}
