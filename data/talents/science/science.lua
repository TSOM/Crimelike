
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
-- Mikolai Fajer "yufra"
-- mfajer@gmail.com

newTalentType{ type="science", name = "science", description = "Basic Sciences" }

newTalent{
	name = "Medicine",
	type = {"science", 1},
	points = 5,
	mode = "passive",
	info = function(self)
		return ([[Increases the effects of first-aid.]])
	end,
}

newTalent{
	name = "Chemistry",
	type = {"science", 1},
	points = 5,
	mode = "passive",
	info = function(self)
		return ([[Test-tubes and stuff.]])
	end,
}

newTalent{
	name = "Electronics",
	type = {"science", 1},
	points = 5,
	mode = "passive",
	info = function(self)
		return ([[Anything that uses electricity.]])
	end,
}

newTalent{
	name = "Computers",
	type = {"science", 1},
	points = 5,
	mode = "passive",
	info = function(self)
		return ([[l33t h4x0r.]])
	end,
}