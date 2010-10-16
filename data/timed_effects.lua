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
	name = "LIMP",
	desc = "Limping",
	type = "physical",
	status = "detrimental",
	parameters = {},
	on_gain = function(self, err) return "#Target# starts to limp", "+limp" end,
	on_lose = function(self, err) return "#Target# stops limping.", "-limp" end,
	activate = function(self, eff)
		eff.tmpid = self:addTemporaryValue("limp", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("limp", eff.tmpid)
	end,
}

newEffect{
	name = "CRIPPLE",
	desc = "Crippled",
	type = "physical",
	status = "detrimental",
	parameters = {},
	on_gain = function(self, err) return "#Target#'s legs give out from under them", "+cripple" end,
	on_lose = function(self, err) return "#Target# rises to their feet.", "-cripple" end,
	activate = function(self, eff)
		eff.tmpid = self:addTemporaryValue("cripple", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("cripple", eff.tmpid)
	end,
}

newEffect{
	name = "UNCONSIOUS",
	desc = "Unconsious",
	type = "physical",
	status = "detrimental",
	parameters = {},
	on_gain = function(self, err) return "#Target# falls unconsious", "+unconsious" end,
	on_lose = function(self, err) return "#Target# regains consiousness.", "-unconsious" end,
	activate = function(self, eff)
		eff.tmpid = self:addTemporaryValue("unconsious", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("unconsious", eff.tmpid)
	end,
}


newEffect{
	name = "CONFUSED",
	desc = "Confused",
	type = "physical",
	status = "detrimental",
	parameters = {},
	on_gain = function(self, err) return "#Target# looks confused", "+confused" end,
	on_lose = function(self, err) return "#Target# pulls themseleves together.", "-confused" end,
	activate = function(self, eff)
		eff.tmpid = self:addTemporaryValue("confused", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("confused", eff.tmpid)
	end,
}


newEffect{
	name = "ENRAGED",
	desc = "Enraged",
	type = "physical",
	status = "detrimental",
	parameters = {},
	on_gain = function(self, err) return "#Target# is enraged", "+enraged" end,
	on_lose = function(self, err) return "#Target# calms down.", "-enraged" end,
	activate = function(self, eff)
		eff.tmpid = self:addTemporaryValue("enraged", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("enraged", eff.tmpid)
	end,
}

newEffect{
	name = "NASUEA",
	desc = "Nauseous",
	type = "physical",
	status = "detrimental",
	parameters = {},
	on_gain = function(self, err) return "#Target# is nauseous", "+nauseous" end,
	on_lose = function(self, err) return "#Target# feels better.", "-nauseous" end,
	activate = function(self, eff)
		eff.tmpid = self:addTemporaryValue("nauseous", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("nauseous", eff.tmpid)
	end,
}


newEffect{
	name = "BLEEDING",
	desc = "Bleeding",
	type = "physical",
	status = "detrimental",
	parameters = {},
	on_gain = function(self, err) return "#Target# starts bleeding", "+bleeding" end,
	on_lose = function(self, err) return "#Target# stops bleeding.", "-bleeding" end,
	activate = function(self, eff)
		eff.tmpid = self:addTemporaryValue("bleeding", 1)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("bleeding", eff.tmpid)
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