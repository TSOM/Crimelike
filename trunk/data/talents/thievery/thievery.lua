newTalentType{ type="thievery", name = "thievery", description = "Thievery"}

newTalent{
	name = "Pickpocketing",
	type = {"thievery", 1},
	points = 5,
	mode = "passive",
	info = function(self)
		return ([[The art of going into other peoples' pants.]])
	end,
}

newTalent{
	name = "Lockpicking",
	type = {"thievery", 1},
	points = 5,
	range = 1.5,
	message = "Which lock do you want to pick?.",
	action = function(self, t)
		local tg = {type="bolt", nowarning=true, range=self:getTalentRange(t), nolock=true, talent=t}
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end
		
	local target = game.level.map(x, y, Map.TERRAIN)
	 if target.locked then
       if target.lock_strength == nil then
	    game.logPlayer(self, "That cannot be picked")
	   else
		--should include a modifier here for lockpicking kit
		print(self:getTalentLevel(t) * math.random(0,20))
		print(target.lock_strength)
		if self:getTalentLevel(t) * math.random(0,20) > target.lock_strength then
		target.locked = false
		game.logPlayer(self, "The lock clicks open")
		else
		game.logPlayer(self, "You fail to unlock the lock")
		end
	   end

	 else
	 game.logPlayer(self, "That isn't locked.")
	 end
	end,
	info = function(self)
		return ([[Breaking and entering.]])
	end,
}

newTalent{
	name = "Sneaking",
	type = {"thievery", 1},
	points = 5,
	mode = "passive",
	info = function(self)
		return ([[Skulking around.]])
	end,
}

newTalent{
	name = "Disguises",
	type = {"thievery", 1},
	points = 5,
	mode = "passive",
	info = function(self)
		return ([[Being someone you're not.]])
	end,
}