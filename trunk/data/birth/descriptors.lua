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


newBirthDescriptor{
	type = "base",
	name = "base",
	desc = {
	},
	experience = 1.0,
	body = { MAINHAND = {1, 10}, OFFHAND = {1,10}, BODY = {1,10}, BACK = {1, 10}, HEAD = {1,5}, HANDS = {1,5}, FEET = {1,10}, 
		AIR = {1,100}, FLOOR = {1,10000} },--SLOT = {Max, MaxVolume}
	talents_types = {
		["combat/unarmed"]={true, 0.3},
		["combat/firearms-basic"]={true, 0.0},
		["thievery"]={true, 0.3},
	},
	copy = {
		combat = {
			dam=1, 
			dammod={
				str=0.7,
			},
		},
		lleg = 1,
		head = 50,
		max_level = 10,
		lite = 4,
		money = 10,
		--starting_quest = "",
		--starting_intro = "base",
	},
	
}

-- Sexes
load("/data/birth/sexes.lua")

load("/data/birth/races.lua")
newBirthDescriptor{
	type = "role",
	name = "Policeman",
	desc =
	{
		"I am the law.",
	},
	stats = { str=1, agi=1, },
	talents_types = {
		["combat/unarmed"]={true, 0.2},
		["combat/firearms-basic"]={true, 0.3},
		["science/medicine"]={true, 0.0},
	},
	talents = {
		[ActorTalents.T_SHOOT]=2,
        },
	copy = {
		resolvers.inventory{ id=true,
			{type="weapon", subtype="pistol", autoreq=true},
			{type="ammo", subtype="clip", autoreq=true},
		},
	}
}

newBirthDescriptor{
	type = "role",
	name = "Doctor",
	desc =
	{
		"A trained medical professional.",
	},
	stats = { agi=1, con=1, },
	talents_types = {
		["combat/firearms-basic"]={true, -0.2},
		["science/medicine"]={true, 0.5},
	},
	talents = {
		[ActorTalents.T_SHOOT]=1,
	},
	copy = {
	}
}

newBirthDescriptor{
	type = "location",
	name = "Slums",
	desc = {
		"Slummy'.",
	},
	copy = {
		starting_level = 1,
		starting_zone = "slums",
	},
}

newBirthDescriptor{
	type = "location",
	name = "The City",
	desc = {
		"City Generation Test.",
	},
	copy = {
		unused_talents = 50,
		unused_generics = 50,
		starting_level = 1,
		starting_zone = "city",
		resolvers.equip{ id=true,
			{type="weapon", subtype="pistol", autoreq=true},
			{type="ammo", subtype="clip", autoreq=true},
		},
	}}
	
newBirthDescriptor{
	type = "location",
	name = "Test Land",
	desc = {
		"Secret stuff in here.",
	},
	copy = {
		unused_talents = 50,
		unused_generics = 50,
		starting_level = 0,
		starting_zone = "testland",
		resolvers.equip{ id=true,
			{type="weapon", subtype="pistol", autoreq=true},
			{type="ammo", subtype="clip", autoreq=true},
		},
	}}
	
newBirthDescriptor{
	type = "location",
	name = "Sandbox",
	desc = {
		"A simple sandbox dungeon for those who want to just kill zombies.",
	},
	copy = {
		starting_level = 1,
		starting_zone = "sandbox",
		starting_intro = "sandbox",
		resolvers.equip{ id=true,
			{type="weapon", subtype="pistol", autoreq=true},
			{type="ammo", subtype="clip", autoreq=true},
		},
	}}
