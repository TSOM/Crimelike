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
function _M:getDesc(name_param)
	local desc = tstring{}
	name_param = name_param or {}
	name_param.do_color = true
		desc:merge(self:getName(name_param):toTString())
		desc:add({"color", "WHITE"}, true)
		desc:merge(self.desc:toTString())
		desc:add({"color", "WHITE"}, true)
	local reqs = rawget(self, "require")
	if type(reqs) == type('') then
		desc:merge(reqs:toTString())
		desc:add(true)
	end
	if self.quantity then
		desc:merge((("Quantity: %d"):format(self.quantity)):toTString())
		desc:add(true)
	end
	if self.encumber then
		desc:add({"color",0x67,0xAD,0x00}, ("%0.2f Encumbrance."):format(self.encumber), {"color", "LAST"})
		desc:add(true)
	end

	desc:merge((("Type: %s / %s"):format(self.type, self.subtype)):toTString())
	desc:add(true)
	local use_desc = self:getUseDesc()
		if use_desc then
		desc:merge(use_desc:toTString()) 
		end

	return desc:toString()
end
