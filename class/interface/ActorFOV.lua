-- TE4 - T-Engine 4
-- Copyright (C) 2009, 2010 Nicolas Casalini
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
-- Nicolas Casalini "DarkGod"
-- darkgod@te4.org

require "engine.class"
local Map = require "engine.Map"

--- Handles actors field of view
-- When an actor moves it computes a field of view and stores it in self.fov<br/>
-- When an other actor moves it can update the fov of seen actors
module(..., package.seeall, class.make)

--- Initialises stats with default values if needed
function _M:init(t)
--	self.distance_map = {}
	self.fov = {actors={}, actors_dist={}, seen_by={}}
	self.fov_computed = false
	self.fov_last_x = -1
	self.fov_last_y = -1
	self.fov_last_turn = -1
	self.fov_last_change = -1
end

--- Computes actor's FOV
-- @param radius the FOV radius, defaults to 20
-- @param block the property to look for FOV blocking, defaults to "block_sight"
-- @param apply an apply function that will be called on each seen grids, defaults to nil
-- @param force set to true to force a regeneration even if we did not move
-- @param no_store do not store FOV informations
-- @param cache if true it will use the cache given by the map, for the map actor. It can be used for other actors is they have the same block settings
function _M:computeFOV(radius, block, apply, force, no_store, cache)
	-- If we did not move, do not update
	if not force and self.fov_last_x == self.x and self.fov_last_y == self.y and self.fov_computed then return end
	radius = radius or 20
	block = block or "block_sight"

	-- Simple FOV compute no storage
	if no_store and apply then
		local map = game.level.map
		core.fov.calc_circle(self.x, self.y, radius, function(_, x, y)
			if map:checkAllEntities(x, y, block, self) then return true end
		end, function(_, x, y, dx, dy, sqdist)
			apply(x, y, dx, dy, sqdist)
		end, cache and game.level.map._fovcache[block])

	-- FOV + storage
	elseif not no_store then
		--Need some check here so that actors don't stay in seen_by forever
		local fov = {actors={}, actors_dist={}, seen_by=self.fov.seen_by }
		setmetatable(fov.actors, {__mode='k'})
		setmetatable(fov.actors_dist, {__mode='v'})

		local map = game.level.map
		core.fov.calc_circle(self.x, self.y, radius, function(_, x, y)
			if map:checkAllEntities(x, y, block, self) then return true end
		end, function(_, x, y, dx, dy, sqdist)
			if apply then apply(x, y, dx, dy, sqdist) end

--			if dist_map then self:distanceMap(x, y, math.floor(game.turn + math.sqrt(sqdist))) end

			-- Note actors
			local a = map(x, y, Map.ACTOR)
			if a and a ~= self and not a.dead then
				local t = {x=x,y=y, dx=dx, dy=dy, sqdist=sqdist}
				
					if self:canSee(a) then
						if a:attr("sneak") then
							--Check for sneak skills and lighting shit
							if 0 == 5 then
							
							else
							
							fov.actors[a] = t
							fov.actors_dist[#fov.actors_dist+1] = a
							a:check("onSeen", self, t)
							--a:updateFOV(self, t.sqdist)
							
							a:sneakToggle()
							--Should probably explain who spotted you.
								if a == game.player then
								game.logSeen(a, "You've been spotted")
								self.ai = "run_to_report"
								--self:runAI("run_to_report",self)
								--self:tryToReport()
								end
							end
						else
						fov.actors[a] = t
						fov.actors_dist[#fov.actors_dist+1] = a
						a:check("onSeen", self, t)
						--a:updateFOV(self, t.sqdist)
						end
					end

					
			end
		end, cache and game.level.map._fovcache[block])

		-- Sort actors by distance (squared but we do not care)
		table.sort(fov.actors_dist, function(a, b) return fov.actors[a].sqdist < fov.actors[b].sqdist end)
		for i = 1, #fov.actors_dist do fov.actors_dist[i].i = i end
--		print("Computed FOV for", self.uid, self.name, ":: seen ", #fov.actors_dist, "actors closeby")

		self.fov = fov
		self.fov_last_x = self.x
		self.fov_last_y = self.y
		self.fov_last_turn = game.turn
		self.fov_last_change = game.turn
		self.fov_computed = true
	end
end

--- Update our fov to include the given actor at the given dist
-- @param a the actor to include
-- @param sqdist the squared distance to that actor
function _M:updateFOV(a, sqdist)
	-- If we are from this turn no need to update
	if self.fov_last_turn == game.turn then return end

	local t = {x=a.x, y=a.y, dx=a.x-self.x, dy=a.y-self.y, sqdist=sqdist}

	local fov = self.fov
	if not fov.actors[a] then
		fov.actors_dist[#fov.actors_dist+1] = a
	end
	fov.actors[a] = t
--	print("Updated FOV for", self.uid, self.name, ":: seen ", #fov.actors_dist, "actors closeby; from", a, sqdist)
	table.sort(fov.actors_dist, function(a, b) if a and b then return fov.actors[a].sqdist < fov.actors[b].sqdist elseif a then return 1 else return nil end end)
	self.fov_last_change = game.turn
end

--- Unused
function _M:distanceMap(x, y, v)
	if v == nil then
		return self.distance_map[x + y * game.level.map.w]
	else
		self.distance_map[x + y * game.level.map.w] = v
	end
end
