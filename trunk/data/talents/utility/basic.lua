newTalentType{ type="utility/basic", name = "basic", description = "Basic Commands", generic = true }

newTalent{
	name = "Open",
	type = {"utility/basic", 1},
	points = 1,
	mode = "activated",
	activate = function(self, t)
		game.logPlayer(self, "You start sprinting.")
		return {
			tempid = self:addTemporaryValue("movement_speedup", 1.10 + self:getTalentLevel(t) / 25)
		}
	end,
	deactivate = function(self, t, p)
		game.logPlayer(self, "You stop sprinting.")
		self:removeTemporaryValue("movement_speedup", p.tempid)
		return true
	end,
	info = function(self, t)
		return ([[Running is always useful, but an extra bit of speed is always useful when you run out of ammo.  Your movement speed is increased by %d%%, but each step will cost %d stamina (dependent on encumbrance).]]):format(1.10 + self:getTalentLevel(t) / 25 * 100, 1 + 10 * self:getEncumbrance() / self:getMaxEncumbrance())
	end,
}

newTalent{
	name = "Close",
	type = {"utility/basic", 1},
	points = 5,
	range = 1.5,
	message = "Which lock do you want to pick?.",
	action = function(self, t)
		local tg = {type="bolt", nowarning=true, range=self:getTalentRange(t), nolock=true, talent=t}
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end
		
	local target = game.level.map(x, y, Map.TERRAIN)
	if target.openable then
		if target.locked then
		game.logPlayer(self, "It's locked.")
		else
		game.logPlayer(self, "You close the %s.", target.name)
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
	name = "Push",
	type = {"utility/basic", 1},
	points = 1,
	range = 1.5,
	message = "Which lock do you want to pick?.",
	action = function(self, t)
		local tg = {type="bolt", nowarning=true, range=self:getTalentRange(t), nolock=true, talent=t}
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end
		
	local target = game.level.map(x, y, Map.TERRAIN)
	if target.openable then
		if target.locked then
		game.logPlayer(self, "It's locked.")
		else
		game.logPlayer(self, "You close the %s.", target.name)
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
	name = "Pull",
	type = {"utility/basic", 1},
	points = 1,
	range = 1.5,
	message = "Which lock do you want to pick?.",
	action = function(self, t)
		local tg = {type="bolt", nowarning=true, range=self:getTalentRange(t), nolock=true, talent=t}
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end
		
	local target = game.level.map(x, y, Map.TERRAIN)
	if target.openable then
		if target.locked then
		game.logPlayer(self, "It's locked.")
		else
		game.logPlayer(self, "You close the %s.", target.name)
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
	name = "Take hostage",
	type = {"utility/basic", 1},
	points = 5,
	range = 1.5,
	message = "Who do you want to take hostage?.",
	action = function(self, t)
		local tg = {type="bolt", nowarning=true, range=self:getTalentRange(t), nolock=true, talent=t}
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end
		
	local target = game.level.map(x, y, Map.TERRAIN)
	if target.openable then
		if target.locked then
		game.logPlayer(self, "It's locked.")
		else
		game.logPlayer(self, "You close the %s.", target.name)
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

