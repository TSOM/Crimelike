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


newEntity{
	define_as = "EMERGENCY_LIGHT",
	name = "Emergency light",
	type = "light", subtype="emergency",
	display = "*", color=colors.WHITE,
	color_on = colors.YELLOW, color_off=colors.WHITE,
	desc = [[An emergency light set high into the wall.]],
	faction = "inanimate",
	ai = "light",
	activate = function(self)
		if not self.active then
			-- Change the actor color
			self.color_r = self.color_on.r
			self.color_g = self.color_on.g
			self.color_b = self.color_on.b
			if self._mo then
				self._mo:invalidate()
				game.level.map:updateMap(self.x, self.y)
			end
			local tg = {type="ball", x=self.x, y=self.y, radius=2}
			local grids = self:project(tg, self.x, self.y, function(tx, ty)
				DamageType:get(DamageType.LITE).projector(self, tx, ty, DamageType.LITE, 1)
			end)
			self.active = true
		end
	end,
	deactivate = function(self)
		-- Turn of the light if on
		if self.active then
			-- Change the actor color
			self.color_r = self.color_off.r
			self.color_g = self.color_off.g
			self.color_b = self.color_off.b
			if self._mo then
				self._mo:invalidate()
				game.level.map:updateMap(self.x, self.y)
			end
			local tg = {type="ball", x=self.x, y=self.y, radius=2}
			local grids = self:project(tg, self.x, self.y, function(tx, ty)
				DamageType:get(DamageType.DARK).projector(self, tx, ty, DamageType.DARK, 1)
			end)
		end
	end,
	on_die = function(self, src)
		self:deactivate()
	end,
}