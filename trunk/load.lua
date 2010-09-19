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


-- This file loads the game module, and loads data
dofile("/mod/util.lua")
local KeyBind = require "engine.KeyBind"
local DamageType = require "engine.DamageType"
local ActorStats = require "engine.interface.ActorStats"
local ActorResource = require "engine.interface.ActorResource"
local ActorTalents = require "engine.interface.ActorTalents"
local ActorAI = require "engine.interface.ActorAI"
local ActorInventory = require "mod.class.interface.ComplexInventory"
local ActorLevel = require "engine.interface.ActorLevel"
local ActorTemporaryEffects = require "engine.interface.ActorTemporaryEffects"
local Birther = require "engine.Birther"
local Faction = require "engine.Faction"
local Quest = require "engine.Quest"
print('Penis')
PrintTable(fs.list("/data/"))
-- Usefull keybinds
KeyBind:load("move,hotkeys,inventory,actions,debug,moreactions")

-- Additional entities resolvers
dofile("/mod/resolvers.lua")

-- Body parts
ActorInventory:defineInventory("MAINHAND", "In main hand", false, "Most weapons are wielded in the main hand.")
ActorInventory:defineInventory("OFFHAND", "In off hand", false, "You can use shields or a second weapon in your off-hand, if you have the talents for it.")
ActorInventory:defineInventory("BODY", "Main armor", true, "Armor protects your from physical attacks. The heavier the armor the more it hinders the use of talents and spells.")
ActorInventory:defineInventory("BACK", "On back", true, "Generally used for backpacks.")
ActorInventory:defineInventory("HEAD", "On head", true, "You can wear helmets or crowns on your head")
ActorInventory:defineInventory("BELT", "Around waist", true, "Belts are worn around your waist.")
ActorInventory:defineInventory("HANDS", "On hands", true, "Various gloves can be worn on your hands.")
ActorInventory:defineInventory("FEET", "On feet", true, "Sandals or boots can be worn on your feet.")
ActorInventory:defineInventory("TOOL", "Tool", true, "This is your readied tool, always available immediately.")
ActorInventory:defineInventory("AMMO", "Ammo", true, "Your readied ammo.")

ActorInventory:defineInventory("POCKET", "Pockets", false, "Your pockets.")

-- Damage types
DamageType:loadDefinition("/data/damage_types.lua")

-- Talents
ActorTalents:loadDefinition("/data/talents.lua")

-- Timed Effects
ActorTemporaryEffects:loadDefinition("/data/timed_effects.lua")

-- Actor resources
ActorResource:defineResource("Air", "air", nil, "air_regen", "Air capacity in your lungs. Entities that need not breath are not affected.")
ActorResource:defineResource("Stamina", "stamina", nil, "stamina_regen", "Stamina represents your physical fatigue. Each physical ability used reduces it.")
ActorResource:defineResource("Left Arm", "larm", nil, "heal_regen", "Injury to either arm can reduce accuracy as well as make weapons impossible to hold.")
ActorResource:defineResource("Right Arm", "rarm", nil, "heal_regen", "Injury to either arm can reduce accuracy as well as make weapons impossible to hold.")
ActorResource:defineResource("Left Leg", "lleg", nil, "heal_regen", "Injury to either leg can reduce mobility.")
ActorResource:defineResource("Right Leg", "rleg", nil, "heal_regen", "Injury to either leg can reduce mobility.")
ActorResource:defineResource("Head", "head", nil, "heal_regen", "Injury to the head can cause blackouts and death.")
ActorResource:defineResource("Torso", "torso", nil, "heal_regen", "Most representative of your total health.")
ActorResource:defineResource("Sleep", "sleep", nil, "sleep_regen", "You long term fatiuge, elevated primarily by sleeping")

-- Actor stats
ActorStats:defineStat("Strength", "str", 10, 1, 100, "Strength defines your character's ability to apply physical force. It increases your melee damage, damage with heavy weapons, your chance to resist physical effects, and carrying capacity.")
ActorStats:defineStat("Agility", "agi", 10, 1, 100, "Agility defines your character's ability to be nimble. It increases your chance to hit, your ability to avoid attacks and your damage with light weapons.")
ActorStats:defineStat("Constitution", "con", 10, 1, 100, "Constitution defines your character's ability to withstand and resist damage. It increases your maximun life and physical resistance.")
ActorStats:defineStat("Intelligence", "int", 10, 1, 100, "Intelligence defines your character's ability to think about stuff and stuff.")
ActorStats:defineStat("Willpower", "wil", 10, 1, 100, "Tough it out.")
ActorStats:defineStat("Perception", "per", 10, 1, 100, "If you perceptive enough you'd know what this does already.")
ActorStats:defineStat("Charisma", "chr", 10, 1, 100, "Charisma defines your character's ability to be super sexy.")

-- Actor AIs
ActorAI:loadDefinition("/engine/ai/")
ActorAI:loadDefinition("/mod/ai/")

-- Birther descriptor
Birther:loadDefinition("/data/birth/descriptors.lua")

-- Factions

Faction:add{ name="Player", reaction={Players=0, Staff=0} }
--For random NPC's who don't have a faction, but become hostile to players.
Faction:add{ name="Enemy", reaction={Players=-100}}
--Similar to the Enemy Faction
Faction:add{ name="Ally", reaction={Players=100}}
--The vast majority of people.
Faction:add{ name="Civilian", reaction={Players=0} }
Faction:add{ name="Cribs", reaction={Players=0} }
Faction:add{ name="Police", reaction={Players=0, Cribs=0} }
Faction:setInitialReaction("players", "Police", 0)

return {require "mod.class.Game" }
