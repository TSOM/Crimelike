--A small house
--author: Mendonca
--Size: 15x10 tiles

defineTile('p', 'PAVEMENT')
defineTile('#', 'WALL_BRICK_DARK')
defineTile('=', 'COUNTER_WOOD_RED')
defineTile(',', 'FLOOR_WOOD_TWO')
defineTile('c', 'CONCRETE_FLOOR')
defineTile('+', 'SINK')
defineTile('D', 'WALL_BRICK_DARK_DOOR')
defineTile('O', 'WINDOW_BRICK_DARK')
defineTile('W', 'WC')
defineTile('~', 'GRASS_ONE')
defineTile('N', 'WHB')
defineTile('H', 'SHOWER')
defineTile('C', 'CHAIR_WOODEN')
defineTile('T', 'TABLE_WOODEN')
defineTile('B', 'BED_WOODEN_E')
defineTile('b', 'BED_WOODEN_W')
defineTile('E', 'BED_WOODEN_N')
defineTile('e', 'BED_WOODEN_S')
defineTile('/', 'SHELF_WOOD')
defineTile('x', 'TELEVISION')
defineTile('X', 'TELEVISION')
defineTile('F', 'FRIDGE')
defineTile('S', 'SOFA_LEFT_1')
defineTile('s', 'SOFA_LEFT_2')
defineTile('<', 'STAIR_WOODEN_UP')
defineTile('>', 'STAIR_WOODEN_DOWN')
defineTile('A', 'BATH_N')
defineTile('a', 'BATH_S')

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
