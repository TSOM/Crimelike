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
	define_as = "BASE_BACKPACK",
	slot = "BACK",
	type = "container", subtype="backpack",
	display = "]", color=colors.YELLOW,
	encumber = 1,
	rarity = 1,
	volume = 10,
	name = "a generic backpack",
	body = {INVEN = {-1,50}},
	desc = [[A generic backpack.]],
}

newEntity{ base = "BASE_BACKPACK",
	name = "backpack",
	level_range = {1, 10},
	cost = 10,
}

newEntity{
	define_as = "BRIEFCASE",
	type = "container", subtype="briefcase",
	display = "]", color=colors.DARK_SLATE_GRAY,
	level_range = {1, 10},
	rarity = 1,
	encumber = 3,
	volume = 7,
	body = {INVEN = {-1,6}}, --An infinite number of items can be stored, as long as the total volume is 6 or less
	staticVolume = true, --The volume is not affected by the contents
	name = "briefcase",
	desc = [[A briefcase, popular among businesspeople and spies.]],
}
