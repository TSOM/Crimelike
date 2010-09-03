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


local Stats = require "engine.interface.ActorStats"

newEffect{
	name = "REGENERATION",
	desc = "Regeneration",
	type = "physical",
	status = "beneficial",
	parameters = { power=2 },
	on_gain = function(self, err) return "#Target# is healing faster!", "+First aid" end,
	on_lose = function(self, err) return "#Target# is healing normally.", "-First aid" end,
	activate = function(self, eff)
		eff.tmpid = self:addTemporaryValue("life_regen", eff.power)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("life_regen", eff.tmpid)
	end
}

newEffect{
	name = "STUNNED",
	desc = "Stunned",
	type = "physical",
	status = "detrimental",
	parameters = {},
	on_gain = function(self, err) return "#Target# is stunned!", "+Stunned" end,
	on_lose = function(self, err) return "#Target# is not stunned anymore.", "-Stunned" end,
	activate = function(self, eff)
		eff.tmpid = self:addTemporaryValue("stunned", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("stunned", eff.tmpid)
	end,
}

newEffect{
	name = "MIMIC",
	desc = "Mimic",
	type = "physical",
	status = "beneficial",
	parameters = {},
	on_gain = function(self, err) return "#Target# appears to be infected!", "+Mimic" end,
	on_lose = function(self, err) return "#Target# appears normal again.", "-Mimic" end,
	activate = function(self, eff)
		eff.previous_faction = self.faction
        self.faction = "infected"
	end,
	deactivate = function(self, eff)
		self.faction = eff.previous_faction
	end,
}

newEffect{
	name = "ADRENALINE",
	desc = "Adrenaline",
	type = "physical",
	status = "beneficial",
	parameters = { power=0.1 },
	on_gain = function(self, err) return "#Target# speeds up.", "+Fast" end,
	on_lose = function(self, err) return "#Target# slows down.", "-Fast" end,
	activate = function(self, eff)
		eff.energy_id = self:addTemporaryValue("energy", {mod=eff.power})
		eff.stamina_id = self:addTemporaryValue("stamina_per_step", eff.power * 10)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("energy", eff.energy_id)
		self:removeTemporaryValue("stamina_per_step", eff.stamina_id)
	end,
}