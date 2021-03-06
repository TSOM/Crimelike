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
require "engine.Grid"
local DamageType = require "engine.DamageType"

module(..., package.seeall, class.inherit(engine.Grid))

function _M:init(t, no_default)
	engine.Grid.init(self, t, no_default)
end

function _M:lock_check()



end

function _M:unlock_door()

end

function _M:block_move(x, y, e, act, couldpass)
if act then
--print(self.locked)
end
	-- Open doors
	if self.locked and act then
	game.logPlayer(act, "It's locked.")
	return true
	end
	
	if self.door_opened and act then
		--if self.lock_strength == nil or self:lock_check() then
		local opened = game.zone:makeEntityByName(game.level, 'terrain', self.door_opened)
		game.zone:addEntity(game.level, opened, "terrain", x, y)
		return true
		--end
	elseif self.door_opened and not couldpass then
		return true
	end

	-- Pass walls
	if e and self.can_pass and e.can_pass then
		for what, check in pairs(e.can_pass) do
			if self.can_pass[what] and self.can_pass[what] <= check then return false end
		end
	end

	return self.does_block_move
end

function _M:on_move(x, y, who, forced)
	if forced then return end
	if who.move_project and next(who.move_project) then
		for typ, dam in pairs(who.move_project) do
			DamageType:get(typ).projector(who, x, y, typ, dam)
		end
	end
end

function _M:tooltip()
	if self.show_tooltip then
		local name = ((self.show_tooltip == true) and self.name or self.show_tooltip)
		if self.desc then
			return name.."\n"..self.desc
		else
			return name
		end
	end
end

