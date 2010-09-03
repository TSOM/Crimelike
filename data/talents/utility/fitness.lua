
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

newTalentType{ type="utility/fitness", name = "fitness", description = "Physical fitness", generic = true }

newTalent{
	name = "Sprint",
	type = {"utility/fitness", 1},
	points = 5,
	mode = "sustained",
	activate = function(self, t)
		game.logPlayer(self, "You start sprinting.")
		return {
			tempid = self:addTemporaryValue("movement_speedup", 1.10 + self:getTalentLevel(t) / 25)
		}
	end,
	deactivate = function(self, t, p)
		game.logPlayer(self, "You stop sprinting.")
		self:removeTemporaryValue("movement_speedup", p.tempid)
		return true
	end,
	info = function(self, t)
		return ([[Running is always useful, but an extra bit of speed is always useful when you run out of ammo.  Your movement speed is increased by %d%%, but each step will cost %d stamina (dependent on encumbrance).]]):format(1.10 + self:getTalentLevel(t) / 25 * 100, 1 + 10 * self:getEncumbrance() / self:getMaxEncumbrance())
	end,
}

newTalent{
	name = "Endurance Training",
	type = {"utility/fitness", 2},
	points = 5,
	mode = "passive",
	require = { stat = { con=function(level) return 10 + level * 2 end }, },
	on_learn = function(self, t)
		self.incMaxStamina(10)
	end,
	on_unlearn = function(self, t)
		self.incMaxStamina(-10)
	end,
	info = function(self)
		return ([[Increases your endurance, gaining 10 stamina points per level.]])
	end,
}