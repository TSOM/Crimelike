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
	name = "improvised handgun", image = "tiles/equipment/improvisedhandgun.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[A homemade handgun, cobbled and welded together.]],
	combat = {
		range = 8,
		physspeed = 0.8,
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
	desc = [[A large, stainless steel revolver that is somewhat unwieldy, but carries heavy power.]],
	combat = {
		range = 8,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_GUN",
	name = "Desert Eagle", image = "tiles/equipment/deserteagle.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[A notably large, well-known gas-operated pistol.]],
	combat = {
		range = 8,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{
	define_as = "BASE_RIFLE",
	slot = "MAINHAND",
	type = "weapon", subtype="rifle",
	display = "}", color=colors.UMBER,
	encumber = 5,
	combat = { damrange = 1.4,},
	ranged = "gun",
	volume = 4,
	body = {AMMO = {1,2}},
	staticVolume = true,
	desc = [[Guns are used to shoot bullets.]],
}

newEntity{
	define_as = "BASE_SHOTGUN",
	slot = "MAINHAND",
	type = "weapon", subtype="shotgun",
	display = "}", color=colors.UMBER,
	encumber = 5,
	combat = { damrange = 1.4,},
	ranged = "gun",
	volume = 4,
	body = {AMMO = {1,2}},
	staticVolume = true,
	desc = [[Guns are used to shoot bullets.]],
}

newEntity{
	define_as = "BASE_SUBMACHINEGUN",
	slot = "MAINHAND",
	type = "weapon", subtype="submachine gun",
	display = "}", color=colors.UMBER,
	encumber = 5,
	combat = { damrange = 1.4,},
	ranged = "gun",
	volume = 4,
	body = {AMMO = {1,2}},
	staticVolume = true,
	desc = [[Submachine guns are semi-auto, lighter weapons.]],
}

newEntity{ base = "BASE_SUBMACHINEGUN",
	name = "UZI", image = "tiles/equipment/uzi.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[A rapid fire machine pistol with fair accuracy and low kickback.]],
	combat = {
		range = 3,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_SUBMACHINEGUN",
	name = "MP5", image = "tiles/equipment/mp5.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[One of the most widely used 9mm submachine guns, produced by H&K.]],
	combat = {
		range = 3,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_SUBMACHINEGUN",
	name = "Thompson submachinegun", image = "tiles/equipment/thompsonsubmachinegun.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[A small, high powered, iconic SMG.]],
	combat = {
		range = 3,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_SHOTGUN",
	name = "Double-barrel shotgun", image = "tiles/equipment/doublebarrelshotgun.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[A long shotgun with two barrels. It is powerful and has a reasonable range, but can only hold two shells.]],
	combat = {
		range = 3,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_SHOTGUN",
	name = "Sawed-off shotgun", image = "tiles/equipment/sawedoffshotgun.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[A double-barrel shotgun with a shorter barrel. It is easier to conceal and has a wider spread, but has a shorter range.]],
	combat = {
		range = 3,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_SHOTGUN",
	name = "SPAS-12", image = "tiles/equipment/spas12.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[A short-range combat shotgun used by combat forces for offensive tactics and door breaching.]],
	combat = {
		range = 3,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_RIFLE",
	name = ".22 hunting rifle", image = "tiles/equipment/.22huntingrifle.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[An accurate rifle used for hunting.]],
	combat = {
		range = 3,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_RIFLE",
	name = "AK-47", image = "tiles/equipment/ak47.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[An old fashioned automatic rifle with a wooden stock, 30 bullet clip.]],
	combat = {
		range = 3,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_RIFLE",
	name = "AK-74", image = "tiles/equipment/ak74.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[A 5.45 x 39 mm rifle that replaced the AKM. Good power.]],
	combat = {
		range = 3,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_RIFLE",
	name = "M16", image = "tiles/equipment/m16.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[A precision, high powered assault rifle. Requires frequent maintenence even under the most ideal conditions.]],
	combat = {
		range = 3,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_RIFLE",
	name = "M4A1", image = "tiles/equipment/m4a1.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[A shorter, lighter version of the M16, designed for urban combat and capable of firing in full auto.]],
	combat = {
		range = 3,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_RIFLE",
	name = "FAMAS", image = "tiles/equipment/famas.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[A bullpup-style assault rifle. Fires at 900 rounds per minute, though its effective range is less than that of other carbines.]],
	combat = {
		range = 3,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_RIFLE",
	name = "CZ 550", image = "tiles/equipment/cz550.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[A very, very high caliber hunting rifle, to be used against very big game.]],
	combat = {
		range = 3,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_RIFLE",
	name = "M1 Garand", image = "tiles/equipment/cz550.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[One of the earliest semiautomatic rifles in use by infantrymen. Eight round clip.]],
	combat = {
		range = 3,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_RIFLE",
	name = "Browning Automatic Rifle", image = "tiles/equipment/browningautomaticrifle.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[A heavy, unwieldy old assault rifle. Devastating.]],
	combat = {
		range = 6,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{
	define_as = "BASE_SNIPER",
	slot = "MAINHAND",
	type = "weapon", subtype="sniper rifle",
	display = "}", color=colors.UMBER,
	encumber = 5,
	combat = { damrange = 1.4,},
	ranged = "gun",
	volume = 4,
	body = {AMMO = {1,2}},
	staticVolume = true,
	desc = [[Sniper rifles are designed for long-range precision combat.]],
}

newEntity{ base = "BASE_SNIPER",
	name = "Dragunov sniper rifle", image = "tiles/equipment/dragunov.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[A gas operated sniper rifle that can hold ten rounds.]],
	combat = {
		range = 9,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_SNIPER",
	name = "Arctic Warfare Magnum", image = "tiles/equipment/arcticwarfaremagnum.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[A large bolt-action sniper rifle, chambered in .338LM. It is loud and accurate, and holds five rounds.]],
	combat = {
		range = 9,
		physspeed = 0.8,
		dammod = {agi=0.7},
	},
}

newEntity{ base = "BASE_SNIPER",
	name = "Marine Scout Sniper Rifle", image = "tiles/equipment/mssr.png",
	level_range = {1, 10},
	require = { stat = { str=10 }, },
	cost = 5,
	rarity = 4,
	material_level = 1,
	desc = [[A sniper rifle that uses 5.56 x 45 mm NATO ammo. Designed for the Phillippine army.]],
	combat = {
		range = 9,
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
