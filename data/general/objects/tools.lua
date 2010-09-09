
local Talents = require "engine.interface.ActorTalents"

newEntity{
	define_as = "LOCKPICKS",
	type = "tool", subtype="lockpicking",
	display = "l", color=colors.WHITE,
	encumber = 0.2,
	stacking = true,
	name = "lockpicks",
	desc = [[Standard set of lockpicks.]],
	use_simple = { name="pick a lock", use = function(self, who)
		game.logSeen(who, "%s applies a %s!", who.name:capitalize(), self:getName{no_count=true})
		local tlevel = who:getTalentLevel(Talents.T_LOCKPICKING)
		return "destroy", true
	end}
}
