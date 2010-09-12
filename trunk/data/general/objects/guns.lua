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


newEntity{
	define_as = "BASE_GUN",
	slot = "MAINHAND",
	type = "weapon", subtype="pistol",
	display = "}", color=colors.UMBER,
	encumber = 4,
	combat = { damrange = 1.4,},
	ranged = "gun",
	volume = 4,
	body = {AMMO = {1,2}},
	staticVolume = true,
	desc = [[Guns are used to shoot bullets.]],
}

newEntity{ base = "BASE_GUN",
	name = "9mm Beretta", image = "tiles/equipment/9mmberetta.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[A standard pistol that holds 15 rounds.]],
	combat = {
		range = 8,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_GUN",
	name = ".38 revolver", image = "tiles/equipment/38revolver.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[A small, concealable revolver with modest stopping power. It holds five bullets.]],
	combat = {
		range = 8,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_GUN",
	name = "Derringer", image = "tiles/equipment/derringer.png",
	level_range = {1, 10},
	require = { stat = { str=7 }, },
	cost = 5,
	rarity = 6,
	material_level = 1,
	desc = [[What it lacks in power it makes up for in concealability.]],
	combat = {
		range = 3,
		physspeed = 0.7,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_GUN",
	name = ".44 magnum", image = "tiles/equipment/44magnum.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[A large, stainless steel revolver that is somewhat unwieldy, but carries heavy power. ]],
	combat = {
		range = 8,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_GUN",
	define_as = "BAZOOKA",
	name = "Easter Egg Bazooka",
	rarity = false,
	volume = 7,
	desc = [[This classic shoulder-mounted bazooka appears to have been modified.  The bore of the barrel is quite a bit narrower than it should be... about egg-sized in fact.]],
}

------------------ AMMO -------------------

newEntity{
	define_as = "BASE_CLIP",
	slot = "AMMO",
	type = "ammo", subtype="clip",
	add_name = " (#COMBAT#)",
	display = "{", color=colors.UMBER,
	encumber = 0.03,
	rarity = 5,
	combat = { damrange = 1.4},
	ranged_ammo = "gun",
	quantity = 9,
	desc = [[A clip of nine bullets.]],
	volume = 2,
	stacking = false,
	particle = "bullet_impact",
}

newEntity{ base = "BASE_CLIP",
	name = "9mm clip",
	level_range = {1, 10},
	require = { stat = { agi=10 }, },
	cost = 0.05,
	material_level = 1,
	combat = {
		dam = 30,
		apr = 5,
		physcrit = 1,
	},
}

newEntity{ base = "BASE_CLIP",
	define_as = "EGG_BASKET",
	name = "easter egg basket",
	desc = [[A nice wicker easter egg basket with a brightly #RED#c#VIOLET#o#YELLOW#l#GREEN#o#ORANGE#r#PINK#e#BLUE#d #WHITE#eggs inside.]],
	rarity = false,
	combat = {
		dam = 100,
		apr = 5,
		physcrit = 1,
		radius = 2,
	},
	quantity = 24,
	volume = 4,
	particle = "egg_splat",
}
