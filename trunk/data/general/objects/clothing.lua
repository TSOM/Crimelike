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
	define_as = "BASE_COAT",
	slot = "BODY",
	type = "clothing", subtype="coat",
	display = "[", color=colors.UMBER,
	encumber = 1,
	rarity = 1,
	volume = 10,
	name = "a generic coat",
	body = {POCKET = {2,10}},
	desc = [[A generic coat.]],
}

newEntity{ base = "BASE_COAT",
	name = "leather coat",
	level_range = {1, 10},
	cost = 10,
}

newEntity{ base = "BASE_COAT",
	name = "raincoat",
	color=colors.BLUE,
	level_range = {1, 10},
	cost = 10,
}

newEntity{
	define_as = "BASE_HAT",
	slot = "HEAD",
	type = "clothing", subtype="hat",
	display = "[", color=colors.RED,
	encumber = 1,
	rarity = 1,
	volume = 5,
	name = "a generic hat",
	desc = [[A generic hat.]],
}

newEntity{ base = "BASE_HAT",
	name = "fedora",
	level_range = {1, 10},
	cost = 10,
}

newEntity{
	define_as = "BASE_BACKPACK",
	slot = "BACK",
	type = "container", subtype="backpack",
	display = "]", color=colors.YELLOW,
	encumber = 1,
	rarity = 1,
	volume = 10,
	name = "a generic backpack",
	body = {INVEN = {5,50}},
	desc = [[A generic backpack.]],
}

newEntity{ base = "BASE_BACKPACK",
	name = "backpack",
	level_range = {1, 10},
	cost = 10,
}
