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


local Talents = require("engine.interface.ActorTalents")

newEntity{
	define_as = "BASE_NPC_HUMAN",
	type = "human", subtype = "humanoid",
	display = "h", color=colors.BLUE,
	desc = [[A fellow human.]],
	body = { INVEN = 1000, MAINHAND = 1, OFFHAND = 1, BODY = 1, HEAD = 1, HANDS = 1, FEET = 1, AMMO = 1 },
	ai = "injured_flee",
	stats = { str=10, agi=10, con=10 },
	vload = 0,
	combat_armor = 0,
	max_life = resolvers.rngavg(60,100),
	combat = {
		dam=1, 
		dammod={
			str=0.7,
		},
	},
	faction = "civilian",
	corpse = { name="Corpse of a human", display="&", color=colors.RED,
		type="corpse", subtype="human",
		encumber=150,
	},
}

newEntity{ base = "BASE_NPC_HUMAN",
	name = "doctor", define_as = "DOCTOR",
	display = "d", color=colors.BLUE,
	desc = [[The white lab coat says it all, this is a doctor.]],
	level_range = {1, 4}, exp_worth = 1,
	rarity = 4,
	ai = "doctor_patient",
	drops = resolvers.drops{nb=2,
		{type="medical", subtype="medicine", autoreq=true},
	},
	corpse = {name = "Corpse of a doctor."}
}

newEntity{ base = "BASE_NPC_HUMAN",
	name = "nurse", define_as = "NURSE",
	display = "n", color=colors.BLUE,
	desc = [[A nurse in scrubs.]],
	level_range = {1, 4}, exp_worth = 1,
	rarity = 2,
	drops = resolvers.drops{nb=2,
		{type="medical", subtype="medicine", autoreq=true},
	},
	corpse = {name = "Corpse of a nurse."}
}

newEntity{ base = "BASE_NPC_HUMAN",
	name = "patient", define_as = "PATIENT",
	display = "p", color=colors.BLUE,
	desc = [[A patient.]],
	level_range = {1, 4}, exp_worth = 1,
	corpse = {name = "Corpse of a patient."}
}

newEntity{ base = "BASE_NPC_HUMAN",
	name = "security", define_as = "SECURITY",
	display = "s", color=colors.BROWN,
	desc = [[Dressed in fatigues and wearing a gun.]],
	level_range = {1, 4}, exp_worth = 1,
	rarity = 6,
	resolvers.equip{
		{type="weapon", subtype="pistol", autoreq=true},
		{type="ammo", subtype="clip", autoreq=true},
	},
	resolvers.drops{nb=1,
		{type="ammo", subtype="clip", autoreq=true},
	},
	ai = "dumb_talented_simple", ai_state = { talent_in=1, },
	resolvers.talents{
		[Talents.T_SHOOT]=2,
	},
	corpse = {name = "Corpse of a security personnel."}
}