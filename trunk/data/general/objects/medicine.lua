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


local Talents = require "engine.interface.ActorTalents"

newEntity{
	define_as = "BASE_MEDICINE",
	type = "medical", subtype="medicine",
	unided_name = "medicine", id_by_type = true,
	display = "!", color=colors.WHITE,
	encumber = 0.2,
	stacking = true,
	desc = [[Generic medicine.]],
}

-------------------------------------------------------
-- Health
-------------------------------------------------------
newEntity{ base = "BASE_MEDICINE",
	name = "first-aid kit",
	color = colors.LIGHT_RED,
	desc = [[A small first-aid kit.]],
	level_range = {1, 10},
	rarity = 3,
	cost = 3,

	use_simple = { name="heal some life", use = function(self, who)
		game.logSeen(who, "%s applies a %s!", who.name:capitalize(), self:getName{no_count=true})
		local tlevel = who:getTalentLevel(Talents.T_FIRST_AID_EXPERTISE)
		who:setEffect(who.EFF_REGENERATION, 4 + tlevel * 2, {power=(4 + tlevel * 2)})
		return "destroy", true
	end}
}
newEntity{ base = "BASE_MEDICINE",
	name = "adhesive bandages",
	color = colors.LIGHT_RED,
	desc = [[A small box of adhesive bandages.]],
	level_range = {1, 10},
	rarity = 14,
	cost = 2,

	use_simple = { name="heal some life", use = function(self, who)
		game.logSeen(who, "%s applies some %s!", who.name:capitalize(), self:getName{no_count=true})
		local tlevel = who:getTalentLevel(Talents.T_FIRST_AID_EXPERTISE)
		who:setEffect(who.EFF_REGENERATION, 1 + tlevel * 2, {power=(1 + tlevel * 2)})
		return "destroy", true
	end}
}
