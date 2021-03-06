-- Viral Resistance - T-Engine 4 Module
-- Copyright (C) 2010 Mikolai Fajer
--
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

potential_colors = {colors.RED, colors.VIOLET, colors.YELLOW, colors.GREEN, colors.ORANGE, colors.PINK, colors.BLUE}
local color = rng.table(potential_colors)

return {
	base = 1000,

	angle = { 0, 360 }, anglev = { 2000, 4000 }, anglea = { 200, 600 },

	life = { 5, 10 },
	size = { 3, 6 }, sizev = {0, 0}, sizea = {0, 0},

	r = {color.r, 0}, rv = {0, 0}, ra = {0, 0},
	g = {color.g, 0}, gv = {0, 0}, ga = {0, 0},
	b = {color.b, 0}, bv = {0, 0}, ba = {0, 0},
	a = {200, 200}, av = {0, 0}, aa = {0, 0},

}, function(self)
	self.nb = (self.nb or 0) + 1
	if self.nb < 4 then
		self.ps:emit(100)
	end
end
