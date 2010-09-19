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


return {
	name = "City",
	level_range = {1, 20},
	max_level = 1,
	decay = {300, 800},
	width = 100, height = 100,
	all_lited = true,
	persistant = "zone",
	all_remembered = true,
	generator =  {
		map = {
			class = "mod.class.generator.map.SimpleCity",
			--class = "engine.generator.map.T",
		},
	},
}
