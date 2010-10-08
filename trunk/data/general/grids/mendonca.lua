
local Map = require "engine.Map"

newEntity{
   base = "WALL",
   define_as = "WALL_PLANK_DARK",
   name = "plank wall", image = "terrain/walls/wall_dark_plank.png",
   tooltip = "A shaky wooden plank wall.",
}

newEntity{
   base = "WINDOW",
   define_as = "WINDOW_PLANK_DARK",
   name = "plank window", image = "terrain/walls/window_dark_plank.png",
   tooltip = "A dodgy wooden plank window.",
}

newEntity{
   base = "DOOR",
   define_as = "DOOR_PLANK_DARK",
   name = "plank window", image = "terrain/walls/door_dark_plank.png",
   tooltip = "A poorly constructed wooden plank door.",
}

newEntity{
   base = "DOOR",
   define_as = "DOOR_GARAGE",
   name = "garage door", --image = "terrain/walls/door_garage.png",
   tooltip = "A typical garage door.",
}

newEntity{
   base = "TABLE",
   define_as = "TABLE_WOODEN",
   name = "wooden table", --image = "terrain/furniture/table_wooden1.png",
   tooltip = "A normal wooden table.",
}

newEntity{
   base = "CHAIR",
   define_as = "CHAIR_WOODEN",
   name = "wooden chair", --image = "terrain/furniture/chair_wooden1.png",
   tooltip = "A normal wooden chair.",
}

newEntity{
   base = "BED",
   define_as = "BED_WOODEN_N",
   --image = "terrain/furniture/bed_wood_N.png",
}

newEntity{
   base = "BED",
   define_as = "BED_WOODEN_S",
   --image = "terrain/furniture/bed_wood_S.png",
}

newEntity{
   base = "BED",
   define_as = "BED_WOODEN_E",
   --image = "terrain/furniture/bed_wood_E.png",
}

newEntity{
   base = "BED",
   define_as = "BED_WOODEN_W",
   --image = "terrain/furniture/bed_wood_W.png",
}

newEntity{
   define_as = "SOFA",
   name = "sofa",
   display = 'S', color_r=215, color_g=28, color_b=28,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = "A sofa. Looks comfortable.",
}

newEntity{
   base = "SOFA",
   define_as = "SOFA_DOWN_1",
   image = "terrain/furniture/sofa_down_1.png",
}

newEntity{
   base = "SOFA",
   define_as = "SOFA_DOWN_2",
   image = "terrain/furniture/sofa_down_2.png",
}

newEntity{
   base = "SOFA",
   define_as = "SOFA_UP_1",
   --image = "terrain/furniture/sofa_up_1.png",
}

newEntity{
   base = "SOFA",
   define_as = "SOFA_UP_2",
   --image = "terrain/furniture/sofa_up_2.png",
}

newEntity{
   base = "SOFA",
   define_as = "SOFA_RIGHT_1",
   --image = "terrain/furniture/sofa_right_1.png",
}

newEntity{
   base = "SOFA",
   define_as = "SOFA_RIGHT_2",
   --image = "terrain/furniture/sofa_right_2.png",
}

newEntity{
   base = "SOFA",
   define_as = "SOFA_LEFT_1",
   --image = "terrain/furniture/sofa_left_1.png",
}

newEntity{
   base = "SOFA",
   define_as = "SOFA_LEFT_2",
   --image = "terrain/furniture/sofa_left_2.png",
}


newEntity{
   define_as = "SHELF",
   name = "shelf",
   display = ']', color_r=88, color_g=88, color_b=88,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = "A shelf.",
}

newEntity{
   base = "SHELF",
   define_as = "SHELF_WOOD",
   name = "wooden shelf", --image = "terrain/furniture/shelf_wooden.png",
   tooltip = "A simple wooden shelf.",
}

newEntity{
   base = "SHELF",
   define_as = "SHELF_METAL",
   name = "metal shelf", --image = "terrain/furniture/shelf_metal.png",
   tooltip = "A metal shelf, used for storing tools and paint thinner.",
}

newEntity{
   define_as = "PLANT",
   name = "plant", image = "terrain/furniture/building_plant1.png",
   display = '£', color_r=125, color_g=125, color_b=145,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = true,
   tooltip = "some plant to operate the building.",
}

newEntity{
   base = "PLANT",
   define_as = "PLANT_AHU",
   name = "air handling plant", image = "terrain/furniture/ahu_plant1.png",
   tooltip = "some air handling equipment to ventilate the building.",
}

newEntity{
   base = "PLANT",
   define_as = "PLANT_MCP",
   name = "control panel", image = "terrain/furniture/mcp_plant1.png",
   tooltip = "a mechanical control panel to operate the building plant.",
}

newEntity{
   base = "PLANT",
   define_as = "PLANT_BOILER",
   name = "boiler", image = "terrain/furniture/boiler_plant1.png",
   tooltip = "a gas fired boiler, heats the building.",
}

newEntity{
   base = "PLANT",
   define_as = "PLANT_ITHUB",
   name = "i.t. cabinet", image = "terrain/furniture/ithub_plant1.png",
   tooltip = "a glass fronted cabinet containing various I.T. related equipment.",
}

newEntity{
   base = "PLANT",
   define_as = "PLANT_COMMS",
   name = "incoming comms", image = "terrain/furniture/comms_plant1.png",
   tooltip = "the equipment handling the incoming communications link to the building.",
}

newEntity{
   base = "PLANT",
   define_as = "PLANT_ELEC",
   name = "electric supply", image = "terrain/furniture/ahu_plant1.png",
   tooltip = "the switchboard handling the incoming electrical supply for the building.",
}


newEntity{
   define_as = "TABLE",
   name = "table", image = "terrain/furniture/table.png",
   display = 'T', color_r=238, color_g=33, color_b=12,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = false,
   tooltip = "A simple wooden table.",
}

newEntity{
   define_as = "CHAIR",
   name = "chair", image = "terrain/chair1.png",
   display = 'C', color_r=238, color_g=33, color_b=12,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = "A simple wooden chair.",
}

newEntity{
   define_as = "SINK",
   name = "sink", image = "terrain/furniture/sink1.png",
   display = '+', color_r=238, color_g=33, color_b=12,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = false,
   tooltip = "A stainless steel kitchen sink set in to a counter, with some storage underneath.",
}

newEntity{
   define_as = "WC",
   name = "toilet", image = "terrain/furniture/wc1.png",
   display = 'W', color_r=238, color_g=2383, color_b=238,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = "A white vitreous enamel toilet pan and cistern.",
}

newEntity{
   define_as = "WHB",
   name = "wash hand basin", image = "terrain/furniture/basin1.png",
   display = 'N', color_r=238, color_g=238, color_b=238,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = "A white vitreous enamel basin.",
}

newEntity{
   define_as = "TELEVISION",
   name = "television", image = "terrain/furniture/tv.png",
   display = 'x', color_r=55, color_g=55, color_b=55,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = false,
   tooltip = "A television.",
}

newEntity{
   base = "TELEVISION",
   define_as = "LARGE_TELEVISION",
   name = "large television", image = "terrain/furniture/tv.png",
   display = 'X', color_r=55, color_g=55, color_b=55,
   tooltip = "A large television.",
}

newEntity{
   define_as = "FRIDGE",
   name = "refrigerator", image = "terrain/furniture/fridge.png",
   display = 'F', color_r=200, color_g=190, color_b=190,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = true,
   tooltip = "An upright refrigerator.",
}

--newEntity{
--   define_as = "WINDOW",
--   name = "window", image = "terrain/window1.png",
--  display = 'O', color_r=182, color_g=215, color_b=125,
--   color_br=235, color_bg=126, color_bb=37,
--   notice = true,
--   does_block_move = true,
--   block_sight = false,
--   tooltip = "A wooden framed window.",
--}

newEntity{
   define_as = "STAIR_WOODEN_UP",
   name = "stairs up", --image = "terrain/floors/stair_wooden_up.png",
   display = '<', color_r=122, color_g=122, color_b=75,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = "Wooden stairs leading up.",
}

newEntity{
   base = "STAIR_WOODEN_UP",
   define_as = "STAIR_STONE_UP",
   name = "stone up stairs", --image = "terrain/floors/stair_stone_up.png",
   display = '<', color_r=110, color_g=110, color_b=110,
   tooltip = "Stone stairs leading up.",
}

newEntity{
   define_as = "STAIR_WOODEN_DOWN",
   name = "stairs down", --image = "terrain/floors/stair_wooden_down.png",
   display = '>', color_r=122, color_g=122, color_b=75,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = "Wooden stairs leading down.",
}

newEntity{
   base = "STAIR_WOODEN_DOWN",
   define_as = "STAIR_STONE_DOWN",
   name = "stone down stairs", --image = "terrain/floors/stair_stone_down.png",
   display = '<', color_r=110, color_g=110, color_b=110,
   tooltip = "Stone stairs leading down.",
}

newEntity{
   define_as = "SHOWER",
   name = "shower", --image = "terrain/furniture/shower.png",
   display = 'H', color_r=238, color_g=238, color_b=238,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = "An electric shower mounted above a white tray.",
}

newEntity{
   define_as = "BATH",
   name = "bath", image = "terrain/furniture/bath1.png",
   display = 'A', color_r=238, color_g=238, color_b=238,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = "A white plastic bath.",
}

newEntity{
   base = "BATH",
   define_as = "BATH_N",
   --image = "terrain/furniture/bath_N.png",
}

newEntity{
   base = "BATH",
   define_as = "BATH_N",
   --image = "terrain/furniture/bath_S.png",
}

newEntity{
   base = "BATH",
   define_as = "BATH_N",
   --image = "terrain/furniture/bath_E.png",
}

newEntity{
   base = "BATH",
   define_as = "BATH_N",
   --image = "terrain/furniture/bath_W.png",
}

newEntity{
   base = "DOOR",
   define_as = "GARAGE_DOOR",
   name = "garage door", --image = "terrain/garage_door1.png",
   display = 'G', color_r=165, color_g=82, color_b=95,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = true,
   tooltip = "A typical garage door.",
}

newEntity{
   base = "DESK",
   define_as = "DESK_WOODEN",
   name = "desk", image = "terrain/furnituredesk1.png",
   display = 'u', color_r=190, color_g=120, color_b=35,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = "A cheap but functional desk.",
}

newEntity{
   define_as = "PLANTPOT_FIXED",
   name = "standrad lamp", image = "terrain/furniture/plant_pot1.png",
   display = 't', color_r=222, color_g=222, color_b=200,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = "A standard lamp.",
}

newEntity{
   define_as = "LAMP_STANDARD",
   name = "standrad lamp", --image = "terrain/furniture/lamp_standard.png",
   display = 't', color_r=222, color_g=222, color_b=200,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = false,
   block_sight = false,
   tooltip = "A standard lamp.",
}

newEntity{
   define_as = "OVEN",
   name = "oven", --image = "terrain/furniture/oven1.png",
   display = '*', color_r=222, color_g=222, color_b=238,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = false,
   tooltip = "A catering oven, with four gas rings on top.",
}

newEntity{
   define_as = "LOUVRE",
   name = "louvre", image = "terrain/furniture/louvre1.png",
   display = ':', color_r=199, color_g=199, color_b=210,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = true,
   tooltip = "A building mounted ventilation louvre.",
}

newEntity{
   define_as = "FENCE",
   name = "fence", --image = "terrain/walls/fence_base.png",
   display = '-', color_r=199, color_g=199, color_b=210,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = false,
   tooltip = "A fence.",
}

newEntity{
   base = "FENCE",
   define_as = "FENCE_WOODEN",
   --image = "terrain/walls/fence_wooden.png",
   tooltip = "A wooden fence.",
}

newEntity{
   base = "FENCE",
   define_as = "FENCE_IRON",
   --image = "terrain/walls/fence_iron.png",
   tooltip = "Iron railings.",
}

newEntity{
   base = "DOOR",
   define_as = "GATE_IRON",
   --image = "terrain/doors/gate_iron.png",
   display = '+', color_r=199, color_g=199, color_b=210,
   block_sight = false,
   tooltip = "An iron gate.",
}

newEntity{
   define_as = "POOL_TABLE",
   name = "pool table", image = "terrain/furniture/pooltable.png",
   display = '#', color_r=20, color_g=199, color_b=20,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = false,
   tooltip = "A pool table.",
}

newEntity{
   base = "POOL_TABLE",
   define_as = "POOL_TABLE_E",
   --image = "terrain/furniture/pooltable_E.png",
   display = '[', color_r=20, color_g=199, color_b=20,
}

newEntity{
   base = "POOL_TABLE",
   define_as = "POOL_TABLE_W",
   --image = "terrain/furniture/pooltable_W.png",
   display = ']', color_r=20, color_g=199, color_b=20,
}

newEntity{
   define_as = "HIFI",
   name = "hi-fi", --image = "terrain/furniture/pooltable.png",
   display = 'M', color_r=25, color_g=25, color_b=40,
   color_br=235, color_bg=126, color_bb=37,
   notice = true,
   does_block_move = true,
   block_sight = false,
   tooltip = "A hi-fi system.",
}