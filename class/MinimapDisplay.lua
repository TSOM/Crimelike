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

module(..., package.seeall, class.make)

function _M:init(x, y, w, h, bgcolor)
        self.display_x = x
        self.display_y = y
        self.w, self.h = w, h
        self.bgcolor = bgcolor
        self.font = core.display.newFont("/data/font/VeraMono.ttf", 14)
        self.surface = core.display.newSurface(w, h)
        self:resize(x, y, w, h)
end

--- Resize the display area
function _M:resize(x, y, w, h)
        self.display_x, self.display_y = x, y
        self.w, self.h = w, h
        self.font_h = self.font:lineSkip()
        self.font_w = self.font:size(" ")
        self.bars_x = self.font_w * 9
        self.bars_w = self.w - self.bars_x - 5
        self.surface = core.display.newSurface(w, h)
end

function _M:display()
        self.surface:erase(self.bgcolor[1], self.bgcolor[2], self.bgcolor[3])
        return self.surface
end