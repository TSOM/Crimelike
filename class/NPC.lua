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


require "engine.class"
local ActorAI = require "engine.interface.ActorAI"
local Faction = require "engine.Faction"
require "mod.class.Actor"

module(..., package.seeall, class.inherit(mod.class.Actor, engine.interface.ActorAI))

function _M:init(t, no_default)
	mod.class.Actor.init(self, t, no_default)
	ActorAI.init(self, t)
end

function _M:act()
	-- Do basic actor stuff
	if not mod.class.Actor.act(self) then return end
	
	-- Compute FOV, if needed. Currently, I've forced it to every single turn.
	self:computeFOV(self.sight or 20, nil,nil,true)

	-- Let the AI think .... beware of Shub !
	-- If AI did nothing, use energy anyway
	self:doAI()
	if not self.energy.used then self:useEnergy() end
end

--- Called by ActorLife interface
-- We use it to pass aggression values to the AIs
function _M:onTakeHit(value, src, dam_type)
	if not self.ai_target.actor and src.targetable then
		self.ai_target.actor = src
	end
local fearlevel = self.fearlevel or 0

	if self.fearlevel > 50 or self.coward then
	self:runAI("injured_flee")
	end
	return mod.class.Actor.onTakeHit(self, value, src)
end

function _M:witnessCrime(targetCriminal)
	if self.criminal then
		--maybe a check here to see if the criminal should check if their friends are getting crimed all over
	
	else
	
	self:tryToReport()
	
	end

end

function _M:sendReports()
print(self.name .. " reports the following crimes")
	for k,v in pairs(self.reports) do
	
	
	PrintTable(v)
	end


end

--Checks if the NPC has a phone or can find one to run to so they can go report.
function _M:tryToReport()
--Check inventory for cell phone in future.
--game.logSeen(self, self.name .. " starts dialing their cell phone.")




end

function _M:tooltip()
	local str = mod.class.Actor.tooltip(self)
	return str..([[

Target: %s
UID: %d]]):format(
	self.ai_target.actor and self.ai_target.actor.name or "none",
	self.uid)
end
