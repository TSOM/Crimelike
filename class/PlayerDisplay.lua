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

local function getResColor(attr, max)
local maxcolor = 300
local r,g,b = 0

	g= attr / max * maxcolor
	r = maxcolor - g
print(r .. " " .. g)
return r,g,b
end

-- Displays the stats
function _M:display()
	local player = game.player
	if not player or not player.changed then return self.surface end

	self.surface:erase(self.bgcolor[1], self.bgcolor[2], self.bgcolor[3])

	local cur_exp, max_exp = player.exp, player:getExpChart(player.level+1)

	local h = 0
	self.surface:drawColorStringBlended(self.font, "Level: #00ff00#"..player.level, 0, h, 255, 255, 255) h = h + self.font_h
	self.surface:drawColorStringBlended(self.font, ("Exp:  #00ff00#%2d%%"):format(100 * cur_exp / max_exp), 0, h, 255, 255, 255) h = h + self.font_h

	h = h + self.font_h

	self.surface:erase(colors.VERY_DARK_RED.r, colors.VERY_DARK_RED.g, colors.VERY_DARK_RED.b, 255, self.bars_x, h, self.bars_w, self.font_h)
	self.surface:erase(colors.DARK_RED.r, colors.DARK_RED.g, colors.DARK_RED.b, 255, self.bars_x, h, self.bars_w * player.life / player.max_life, self.font_h)
	self.surface:drawColorStringBlended(self.font, ("#c00000#Life:    #ffffff#%d/%d"):format(player.life, player.max_life), 0, h, 255, 255, 255) h = h + self.font_h

	self.surface:erase(0xff / 6, 0xcc / 6, 0x80 / 6, 255, self.bars_x, h, self.bars_w, self.font_h)
	self.surface:erase(0xff / 3, 0xcc / 3, 0x80 / 3, 255, self.bars_x, h, self.bars_w * player:getStamina() / player:getMaxStamina(), self.font_h)
	self.surface:drawColorStringBlended(self.font, ("#ffcc80#Stamina: #ffffff#%d/%d"):format(player:getStamina(), player:getMaxStamina()), 0, h, 255, 255, 255) h = h + self.font_h

	local headw = self.bars_w * 0.2
	local headh = headw
	local torsow =  headw * 2
	local center = self.w / 2
	local torsox = center - (torsow / 2)
	
	local torsoh = self.font_h * 4
	local limbh = torsoh * 1.25
	local limbw = headw * 0.8
	
	h = h + self.font_h
	--Head
	local r,g,b = getResColor(player:getHead(), player:getMaxHead())
	self.surface:erase(r,g,b, 255, center - (headw / 2), h, headw, headh)
	h = h + headh
	--RightA
	r,g,b = getResColor(player:getRarm(), player:getMaxRarm())
	self.surface:erase(r,g,b, 255, torsox - limbw , h, limbw, limbh)
	--Torso
	r,g,b = getResColor(player:getTorso(), player:getMaxTorso())
	self.surface:erase(r,g,b, 255, torsox, h, torsow, torsoh)
	--LeftA
	r,g,b = getResColor(player:getLarm(), player:getMaxLarm())
	self.surface:erase(r,g,b, 255, torsox + torsow + 2, h, limbw, limbh)
	h = h + torsoh
	--RightL
	r,g,b = getResColor(player:getRleg(), player:getMaxRleg())
	self.surface:erase(r,g,b, 255, torsox, h, limbw, limbh)
	--LeftL
	r,g,b = getResColor(player:getLleg(), player:getMaxLleg())
	self.surface:erase(r,g,b, 255, center + (torsow / 2 - limbw), h,  limbw, limbh)
	--self.surface:drawColorStringBlended(self.font, ("#ffcc80#Stamina: #ffffff#%d/%d"):format(player:getLleg(), player:getMaxLleg()), 0, h, 255, 255, 255) h = h + self.font_h

	
	for eff_id, p in pairs(player.tmp) do
		local e = player.tempeffect_def[eff_id]
		if e.status == "detrimental" then
			self.surface:drawColorStringBlended(self.font, ("#LIGHT_RED#%s"):format(e.desc), 0, h, 255, 255, 255) h = h + self.font_h
		else
			self.surface:drawColorStringBlended(self.font, ("#LIGHT_GREEN#%s"):format(e.desc), 0, h, 255, 255, 255) h = h + self.font_h
		end
	end

	return self.surface
end
