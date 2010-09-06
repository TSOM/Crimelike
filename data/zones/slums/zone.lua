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
	name = "Slums",
	level_range = {1, 20},
	max_level = 10,
	decay = {300, 800},
	width = 70, height = 70,
	all_lited = true,
	persistant = "zone",
	all_remembered = true,
	generator =  {
		map = {
			class = "mod.class.generator.map.TileSetFull",
			tileset = {"7x7/base", "7x7/slum",},
			[' '] = "STREET",
			['#'] = "BRICKWALL",
			['-'] = "STREETLINE",
			['|'] = "STREETLINE2",
			['+'] = "STREETLINE3",
			['='] = "SIDEWALK",
			['_'] = "FLOOR",
			up = "UP",
			down = "DOWN",
		},
		actor = {
			class = "engine.generator.actor.Random",
			nb_npc = {10, 20},
		},
		object = {
			class = "engine.generator.object.Random",
			nb_object = {10, 20},
		},
	},
}
