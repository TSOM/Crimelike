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
require "engine.Object"
require "engine.interface.ObjectActivable"
require "engine.interface.ObjectIdentify"
require "mod.class.interface.ComplexInventory"

module(..., package.seeall, class.inherit(
	engine.Object,
	mod.class.interface.ComplexInventory,
	engine.interface.ObjectActivable,
	engine.interface.ObjectIdentify
))

function _M:init(t, no_default)
	t.encumber = t.encumber or 0
	t.volume = t.volume or 0

	engine.Object.init(self, t, no_default)
	mod.class.interface.ComplexInventory.init(self, t)
	engine.interface.ObjectActivable.init(self, t)
	engine.interface.ObjectIdentify.init(self, t)
end

--- Use the object (quaff, read, ...)
function _M:use(who, typ)
	local types = {}
	if self:canUseObject() then types[#types+1] = "use" end

	if not typ and #types == 1 then typ = types[1] end

	if typ == "use" then
		who:useEnergy()
		if self.use_sound then game:playSoundNear(who, self.use_sound) end
		return self:useObject(who)
	end
end

--- Returns a tooltip for the object
function _M:tooltip()
	return self:getDesc()
end

--- Gets the full name of the object
function _M:getName(t)
	t = t or {}
	local qty = self:getNumber()
	local name = self.name

	-- To extend later
	name = name:gsub("~", ""):gsub("&", "a"):gsub("#([^#]+)#", function(attr)
		return self:descAttribute(attr)
	end)

	if not t.do_color then
		if qty == 1 or t.no_count then return name
		else return qty.." "..name
		end
	else
		local c = "#B4B4B4#"
		if qty == 1 or t.no_count then return c..name.."#LAST#"
		else return c..qty.." "..name.."#LAST#"
		end
	end
end

--- Gets the full desc of the object
function _M:getDesc()
	local c = "#B4B4B4#"
	local desc
	desc = { c..self:getName().."#FFFFFF#", self.desc }

	local reqs = self:getRequirementDesc(game.player)
	if reqs then
		desc[#desc+1] = reqs
	end

	if self.quantity then
		desc[#desc+1] = ("Quantity: %d"):format(self.quantity)
	end
		
	if self.encumber then
		desc[#desc+1] = ("#67AD00#%0.2f Encumbrance."):format(self.encumber)
	end

	desc[#desc+1] = ("Type: %s / %s"):format(self.type, self.subtype)
--[[
	if self.combat then
		local dm = {}
		for stat, i in pairs(self.combat.dammod or {}) do
			dm[#dm+1] = ("+%d%% %s"):format(i * 100, Stats.stats_def[stat].name)
		end
		desc[#desc+1] = ("%d Power [Range %0.2f] (%s), %d Attack, %d Armor Penetration, Crit %d%%"):format(self.combat.dam or 0, self.combat.damrange or 1.1, table.concat(dm, ','), self.combat.atk or 0, self.combat.apr or 0, self.combat.physcrit or 0)
		if self.combat.range then desc[#desc+1] = "Firing range: "..self.combat.range end
		desc[#desc+1] = ""
	end

	local w = self.wielder or {}
	if w.combat_atk or w.combat_dam or w.combat_apr then desc[#desc+1] = ("Attack %d, Armor Penetration %d, Physical Crit %d%%, Physical power %d"):format(w.combat_atk or 0, w.combat_apr or 0, w.combat_physcrit or 0, w.combat_dam or 0) end
	if w.combat_armor or w.combat_def then desc[#desc+1] = ("Armor %d, Defense %d"):format(w.combat_armor or 0, w.combat_def or 0) end
	if w.fatigue then desc[#desc+1] = ("Fatigue %d%%"):format(w.fatigue) end

	if w.melee_project then
		local rs = {}
		for typ, dam in pairs(w.melee_project) do
			rs[#rs+1] = ("%d %s"):format(dam, DamageType.dam_def[typ].name)
		end
		desc[#desc+1] = ("Damage on hit: %s."):format(table.concat(rs, ','))
	end
--]]
	local use_desc = self:getUseDesc()
	if use_desc then desc[#desc+1] = use_desc end

	return table.concat(desc, "\n")
end
