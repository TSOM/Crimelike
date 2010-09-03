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


local oldNewTalent = newTalent
newTalent = function(t)
	assert(engine.interface.ActorTalents.talents_types_def[t.type[1]], "No talent category "..tostring(t.type[1]).." for talent "..t.name)
	if engine.interface.ActorTalents.talents_types_def[t.type[1]].generic then t.generic = true end

	return oldNewTalent(t)
end

load("/data/talents/combat/firearms.lua")
load("/data/talents/combat/unarmed.lua")
load("/data/talents/science/science.lua")
load("/data/talents/thievery/thievery.lua")