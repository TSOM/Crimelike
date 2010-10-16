local Astar = require"engine.Astar"

-- Fleeing from hostiles when injured
newAI("injured_flee", function(self)
	--if self:runAI(self.ai_state.ai_target or "target_simple_check_hostility") then
		return true
	--end
end)


newAI("pedestrian", function(self)
	if self:runAI(self.ai_state.ai_target or "target_simple_check_hostility") then
		return true
	end
end)

newAI("run_to_report", function(self)

print("I'm a arunnin")
	--if has phone, run then call....
	
	
	
	
	--Check for nearestphone and then run to closest.
	
	--Are we at the phone?
	if game.level.map:checkAllEntities(self.x,self.y, "phone") then
		if self.dialing == nil then 
		game.logSeen(self, self.name .. " starts dialing the phone.")
		self.dialing = 1
		elseif rng.range(1,3) <= self.dialing then
		game.logSeen(self, self.name .. " finishes talking and hangs up the phone.")
		self:sendReports()
		self.dialing = nil
		self.ai = "injured_flee"
		else
		self.dialing = self.dialing + 1
		game.logSeen(self, self.name .. " sounds like their talking to the police.")
		end
	
	
	else
	local nearestphone = {}
	local phones = {}
		for k,gridtbl in pairs(core.fov.circle_grids(self.x, self.y, 12, true)) do
			for x,y in pairs(gridtbl) do
				if game.level.map:checkAllEntities(x,k, "phone") then 
				print('Found a phone at ' .. x .. " " .. k)
				phones[core.fov.distance(self.x, self.y, x, k)] = {x,k}
				end
			end
		end

		--Need to replace this for with an advanced ipairs for it to go to the closest.
		local a = Astar.new(game.level.map, self)
		local path 
		
		for k,v in pairs(phones) do
		path = a:calc(self.x, self.y, v[1], v[2])
			--if tempPath then
			--path = tempPath
			--end
		end
		
		--if not tempPath then
		
		--return self:runAI("injured_flee")
		--end
	
	return self:move(path[1].x, path[1].y)
	end
end)

newAI("move_random", function(self)
	local possibilities = {}
	for x=self.x-1,self.x+1 do for y=self.y-1,self.y+1 do
		if not game.level.map:checkAllEntities(x, y, "block_move", self, true) then
			table.insert(possibilities, {x=x, y=y})
		end
	end end
	if #possibilities == 0 then return end
	local dest = rng.table(possibilities)
	return self:move(dest.x, dest.y)
end)