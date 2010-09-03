-- Bay 12
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

print('test')
require "engine.class"
require "engine.Dialog"
local LevelupTalentsDialog = require "mod.dialogs.LevelupTalentsDialog"

module(..., package.seeall, class.inherit(engine.Dialog))

function _M:init(actor, on_finish)
	self.actor = actor
	self.actor_dup = actor:clone()
	self.unused_stats = self.actor.unused_stats
	engine.Dialog.init(self, "Stats Levelup: "..actor.name, 500, 300)

	self.sel = 1

	self:keyCommands(nil, {
		MOVE_UP = function() self.changed = true; self.sel = util.boundWrap(self.sel - 1, 1, 7) end,
		MOVE_DOWN = function() self.changed = true; self.sel = util.boundWrap(self.sel + 1, 1, 7) end,
		MOVE_LEFT = function() self.changed = true; self:incStat(-1) end,
		MOVE_RIGHT = function() self.changed = true; self:incStat(1) end,
		ACCEPT = "EXIT",
		EXIT = function()
			game:unregisterDialog(self)

			self:finish()

			-- if talents to spend, do it now
			if self.actor.unused_generics > 0 or self.actor.unused_talents > 0 or self.actor.unused_talents_types > 0 then
				local dt = LevelupTalentsDialog.new(self.actor, on_finish)
				game:registerDialog(dt)
			end
		end,
	})
	self:mouseZones{
		{ x=2, y=25, w=130, h=self.font_h*6, fct=function(button, x, y, xrel, yrel, tx, ty)
			self.changed = true
			self.sel = 1 + math.floor(ty / self.font_h)
			if button == "left" then self:incStat(1)
			elseif button == "right" then self:incStat(-1)
			end
		end },
	}
end

function _M:finish()
	if self.actor.unused_stats == self.unused_stats then return end
	local reset = {}
	for tid, act in pairs(self.actor.sustain_talents) do
		if act then
			local t = self.actor:getTalentFromId(tid)
			if t.no_sustain_autoreset then
				game.logPlayer(self.actor, "#LIGHT_BLUE#Warning: You have increased some of your statistics, talent %s is actually sustained, if it is dependant on one of the stats you changed you need to re-use it for the changes to take effect.", t.name)
			else
				reset[#reset+1] = tid
			end
		end
	end
	for i, tid in ipairs(reset) do
		local old = self.actor.energy.value
		self.actor:useTalent(tid)
		self.actor.energy.value = old
		self.actor.talents_cd[tid] = nil
		self.actor:useTalent(tid)
		self.actor.energy.value = old
	end
end

function _M:incStat(v)
	if v == 1 then
		if self.actor.unused_stats <= 0 then
			self:simplePopup("Not enough stat points", "You have no stat points left!")
			return
		end
		if self.actor:getStat(self.sel, nil, nil, true) >= self.actor.level * 1.4 + 20 then
			self:simplePopup("Stat is at the maximum for your level", "You can not increase this stat further until next level!")
			return
		end
		if self.actor:isStatMax(self.sel) or self.actor:getStat(self.sel, nil, nil, true) >= 60 then
			self:simplePopup("Stat is at the maximum", "You can not increase this stat further!")
			return
		end
	else
		if self.actor_dup:getStat(self.sel, nil, nil, true) == self.actor:getStat(self.sel, nil, nil, true) then
			self:simplePopup("Impossible", "You cannot take out more points!")
			return
		end
	end

	self.actor:incStat(self.sel, v)
	self.actor.unused_stats = self.actor.unused_stats - v
end

function _M:drawDialog(s)
	-- Description part
	self:drawHBorder(s, self.iw / 2, 2, self.ih - 4)
	local statshelp = ([[Keyboard: #00FF00#up key/down key#FFFFFF# to select a stat; #00FF00#right key#FFFFFF# to increase stat; #00FF00#left key#FFFFFF# to decrease a stat.
Mouse: #00FF00#Left click#FFFFFF# to increase a stat; #00FF00#right click#FFFFFF# to decrease a stat.
]]):splitLines(self.iw / 2 - 10, self.font)
	local lines = self.actor.stats_def[self.sel].description:splitLines(self.iw / 2 - 10, self.font)
	for i = 1, #statshelp do
		s:drawColorStringBlended(self.font, statshelp[i], self.iw / 2 + 5, 2 + (i-1) * self.font:lineSkip())
	end
	for i = 1, #lines do
		s:drawColorStringBlended(self.font, lines[i], self.iw / 2 + 5, 2 + (i + #statshelp + 1) * self.font:lineSkip())
	end

	-- Stats
	s:drawColorStringBlended(self.font, "Stats points left: #00FF00#"..self.actor.unused_stats, 2, 2)
	self:drawWBorder(s, 2, 20, 200)

	self:drawSelectionList(s, 2, 25, self.font_h, {
		"Strength", "Agility", "Constitution","Intelligence", "Willpower", "Perception", "Charisma"
	}, self.sel)
	self:drawSelectionList(s, 100, 25, self.font_h, {
		self.actor:getStr(), self.actor:getAgi(), self.actor:getCon(), self.actor:getInt(), self.actor:getWil(), self.actor:getPer(), self.actor:getChr(),
	}, self.sel)
	self.changed = false
end
