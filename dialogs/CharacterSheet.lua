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
local Dialog = require "engine.Dialog"
local DamageType = require "engine.DamageType"
local Talents = require "engine.interface.ActorTalents"

module(..., package.seeall, class.inherit(engine.Dialog))

function _M:init(actor)
	self.actor = actor
	engine.Dialog.init(self, "Character Sheet: "..self.actor.name.." (Press 'd' to save)", 800, 400, nil, nil, nil, core.display.newFont("/data/font/VeraMono.ttf", 12))

	self:keyCommands({
		__TEXTINPUT = function(c)
			if c == 'd' or c == 'D' then
				self:dump()
			end
		end,
	}, {
		ACCEPT = "EXIT",
		EXIT = function()
			game:unregisterDialog(self)
		end,
	})
end

function _M:drawDialog(s)
	local cur_exp, max_exp = game.player.exp, game.player:getExpChart(game.player.level+1)

	local h = 0
	local w = 0
	s:drawStringBlended(self.font, "Sex:   "..game.player.descriptor.sex, w, h, 0, 200, 255) h = h + self.font_h
	s:drawStringBlended(self.font, "Role: "..game.player.descriptor.role, w, h, 0, 200, 255) h = h + self.font_h
	h = h + self.font_h
	s:drawColorStringBlended(self.font, "Level: #00ff00#"..game.player.level, w, h, 255, 255, 255) h = h + self.font_h
	s:drawColorStringBlended(self.font, ("Exp:  #00ff00#%2d%%"):format(100 * cur_exp / max_exp), w, h, 255, 255, 255) h = h + self.font_h
	s:drawColorStringBlended(self.font, ("Money: #00ff00#$%0.2f"):format(game.player.money), w, h, 255, 255, 255) h = h + self.font_h

	h = h + self.font_h

	s:drawColorStringBlended(self.font, ("#c00000#Life:    #00ff00#%d/%d"):format(game.player.life, game.player.max_life), w, h, 255, 255, 255) h = h + self.font_h
	s:drawColorStringBlended(self.font, ("#ffcc80#Stamina: #00ff00#%d/%d"):format(game.player:getStamina(), game.player.max_stamina), w, h, 255, 255, 255) h = h + self.font_h

	h = h + self.font_h
	s:drawColorStringBlended(self.font, ("STR: #00ff00#%3d"):format(game.player:getStr()), w, h, 255, 255, 255) h = h + self.font_h
	s:drawColorStringBlended(self.font, ("AGI: #00ff00#%3d"):format(game.player:getAgi()), w, h, 255, 255, 255) h = h + self.font_h
	s:drawColorStringBlended(self.font, ("CON: #00ff00#%3d"):format(game.player:getCon()), w, h, 255, 255, 255) h = h + self.font_h
	s:drawColorStringBlended(self.font, ("STR: #00ff00#%3d"):format(game.player:getStr()), w, h, 255, 255, 255) h = h + self.font_h
	s:drawColorStringBlended(self.font, ("INT: #00ff00#%3d"):format(game.player:getInt()), w, h, 255, 255, 255) h = h + self.font_h
	s:drawColorStringBlended(self.font, ("WIL: #00ff00#%3d"):format(game.player:getWil()), w, h, 255, 255, 255) h = h + self.font_h
	s:drawColorStringBlended(self.font, ("CHR: #00ff00#%3d"):format(game.player:getChr()), w, h, 255, 255, 255) h = h + self.font_h
	s:drawColorStringBlended(self.font, ("PER: #00ff00#%3d"):format(game.player:getPer()), w, h, 255, 255, 255) h = h + self.font_h
	h = 0
	w = 600
	s:drawColorStringBlended(self.font, "#LIGHT_BLUE#Current effects:", w, h, 255, 255, 255) h = h + self.font_h
	for tid, act in pairs(game.player.sustain_talents) do
		if act then s:drawColorStringBlended(self.font, ("#LIGHT_GREEN#%s"):format(game.player:getTalentFromId(tid).name), w, h, 255, 255, 255) h = h + self.font_h end
	end
	for eff_id, p in pairs(game.player.tmp) do
		local e = game.player.tempeffect_def[eff_id]
		if e.status == "detrimental" then
			s:drawColorStringBlended(self.font, ("#LIGHT_RED#%s"):format(e.desc), w, h, 255, 255, 255) h = h + self.font_h
		else
			s:drawColorStringBlended(self.font, ("#LIGHT_GREEN#%s"):format(e.desc), w, h, 255, 255, 255) h = h + self.font_h
		end
	end

	self.changed = false
end

function _M:dump()
	fs.mkdir("/character-dumps")
	local file = "/character-dumps/"..(game.player.name:gsub("[^a-zA-Z0-9_-.]", "_")).."-"..os.date("%Y%m%d-%H%M%S")..".txt"
	local fff = fs.open(file, "w")
	local nl = function(s) fff:write(s or "") fff:write("\n") end
	local nnl = function(s) fff:write(s or "") end

	nl("Sex:   "..game.player.descriptor.sex)
	nl("Role: "..game.player.descriptor.role)
	nl("Level: "..game.player.level)

	nl()
	local cur_exp, max_exp = game.player.exp, game.player:getExpChart(game.player.level+1)
	nl(("Exp:  %2d%%"):format(100 * cur_exp / max_exp))
	nl(("Money: $%0.2f"):format(game.player.money))

	nl()
	nl(("Life:    %d/%d"):format(game.player.life, game.player.max_life))
	nl(("Stamina: %d/%d"):format(game.player:getStamina(), game.player.max_stamina))


	nl()
	nl(("STR: %3d"):format(game.player:getStr()))
	nl(("AGI: %3d"):format(game.player:getAgi()))
	nl(("CON: %3d"):format(game.player:getCon()))

	nl()
	local most_kill, most_kill_max = "none", 0
	local total_kill = 0
	for name, nb in pairs(game.player.all_kills or {}) do
		if nb > most_kill_max then most_kill_max = nb most_kill = name end
		total_kill = total_kill + nb
	end
	nl(("Number of NPC killed: %s"):format(total_kill))
	nl(("Most killed NPC: %s (%d)"):format(most_kill, most_kill_max))

	fff:close()

	Dialog:simplePopup("Character dump complete", "File: "..fs.getRealPath(file))
end
