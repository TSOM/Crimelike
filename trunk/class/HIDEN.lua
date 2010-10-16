--HIDEN System
--This system tracks mainly how law enforcement knows about the player. Factions have their own relations with the player that may borrow from this system, but is not entirely dependent on it.

--Heat:



--[[
Low notoriety, high identity, high evidence, high heat = A new punk about to spend some time in prison.
High notoriety, high identity, low evidence, low heat = The notorious criminal the authorities know about, but can't touch for lack of evidence.
High notoriety, low identity, low evidence, high heat = The professional, anonymous criminal cops lose sleep over at night.
High notoriety, low identity, high evidence, high heat = The accomplished but sloppy criminal who the authorities just need to identify before they've nailed them.
Low everything = either a new criminal or a criminal who has been in hiding so long, virtually everything about them has been forgotten.
High everything = A criminal mastermind that's not going down without a fight.
High notoriety, low everything else = The legendary criminal that can't be touched. KAISER SOZE!!111]]







--These change based on difficulty and other in game factors.
--Multipliers are for adding ONLY.

require "engine.class"

module(..., package.seeall, class.make)

function _M:init()
	-- 1 to 100
self.lastRun = game.turn
self.heatMult = 1
self.heatDecay = 1

self.heatStages = {}
self.heatStages[1] = {0, "Harmless"}
self.heatStages[2] = {20, "Below the radar"}
self.heatStages[3] = {40, "Wanted"}
self.heatStages[4] = {60, "Hunted"}
self.heatStages[5] = {80, "Public Enemy"}
self.heatStages[6] = {100, "Most Wanted"}

self.identityMult = 1
self.identityDecay = 1

self.evidenceDecay = 1
self.evidenceMult = 1


self.noterietyDecay = 1
self.noterietyMult = 1


--Time that must pass since your last crime 
self.incidentInterval = 10

return self
end



function _M:run()
self.lastRun = game.turn
self:processDecay(game.player)
self:checkThresholds(game.player)
end

function _M:processDecay(targetActor)
--Could probably use percentage multipliers here instead of or in addition to subtraction

targetActor.heat = targetActor.heat - self.heatDecay
targetActor.identity = targetActor.identity - self.identityDecay
	for k,v in pairs (targetActor.evidence) do
	v.amount = v.amount - self.evidenceDecay
	end
targetActor.noteriety = targetActor.noteriety - self.noterietyDecay

end


function _M:checkThresholds(targetActor)

	for i = 1, #self.heatStages do
		if targetActor.heat < self.heatStages[i] then
		--Set player heat stage and stuff
		break
		end
	end


end


---------------------------------
--ACTOR VARS
---------------------------------

--self.heat = 0
--self.identity = 0
--self.evidence = {}
--self.evidenceTotal = 0
--self.noteriety = 0

---------------------------------
--ACTOR FUNCTIONS
---------------------------------
