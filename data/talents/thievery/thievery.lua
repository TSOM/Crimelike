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
	mode = "passive",
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