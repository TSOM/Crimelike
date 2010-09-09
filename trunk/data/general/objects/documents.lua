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


--local Talents = require "engine.interface.ActorTalents"

newEntity{
	define_as = "ID_BLANK",
	type = "document", subtype="identification",
	unided_name = "blankid", id_by_type = true,
	name = "blankid",
	display = "i", color=colors.WHITE,
	encumber = 0.2,
	stacking = true,
	illegal = true,
	desc = [[A blank driver's license.]],
}

newEntity{
	base = "ID_BLANK",
	define_as = "ID",
	type = "document", subtype="identification",
	name = "id", id_by_type = true,
	display = "i", color=colors.WHITE,
	encumber = 0.2,
	stacking = false,
	idname = 'John Smith',
	quality = 100,
	idsex = 'M',
	idage = '55',
	desc = [[John Smith's drivers license]]
}
