
--Base Door
newEntity{
	define_as = "DOOR",
	name = "door", image = "terrain/granite_door1.png",
	display = '+', color_r=238, color_g=33, color_b=12,
	color_br=235, color_bg=126, color_bb=37,
	notice = true,
	door_opened = "DOOR_OPEN",
	door_locked = "DOOR_LOCKED",
	does_block_move = true,
	block_sight = true,
	tooltip = "A closed door with a window in it.",
	health = 50,
	on_destroyed = "FLOOR",
	locked = true,
	lock_strength = 10,
}

--Base Opened Door (Automatic Closing)
newEntity{
	define_as = "DOOR_OPEN",
	name = "open door", image = "terrain/granite_door1_open.png",
	display = "'", color_r=238, color_g=33, color_b=12, back_color=colors.DARK_GREY,
	door_closed = "DOOR",
	door_locked = "DOOR_LOCKED",
	tooltip = "An open door.",
	close_countdown = 4,
	energy = { value=0, mod=1 },
	canAct = false,
	on_added = function(self, level, x, y)
		self.x = x
		self.y = y
		level:addEntity(self)
	end,
	act = function(self)
		-- Do basic actor stuff
		if not engine.Actor.act(self) then return end
		
		-- Shut the door?
		if game.level.map(self.x, self.y, game.level.map.ACTOR) or game.level.map(self.x, self.y, game.level.map.OBJECT) then
			self.close_countdown = 4
		else
			self.close_countdown = self.close_countdown - 1
		end
		if self.close_countdown <= 0 then
			game.level:removeEntity(self)
			game.level.map(self.x, self.y, game.level.map.TERRAIN, game.zone.grid_list[self.door_closed])
		end
		
		if not self.energy.used then self:useEnergy() end
		return true
	end,
	on_move = function(self, x, y, who)
		self.close_countdown = 4
	end,
	useEnergy = function(self, val)
		val = val or game.energy_to_act
		self.energy.value = self.energy.value - val
	end,
}
--Base Locked Door
newEntity{
	define_as = "DOOR_LOCKED",
	name = "locked door",
	display = '+', color=colors.VIOLET,
	color_br=235, color_bg=126, color_bb=37,
	notice = true,
	does_block_move = true,
	block_sight = true,
	--dig = "DOOR_OPEN",
	door_unlocked = "DOOR",
	locked = true,
	lock_strength = 10,
	tooltip = "A locked door with a window in it.",
}

--Elevator Door
newEntity{
	base = "DOOR",
	define_as = "ELEVATOR_DOOR",
	tooltip = "A closed elevator door.",
	door_opened = "ELEVATOR_OPEN",
	door_locked = "ELEVATOR_LOCKED",
}

--Opened Elevator Door
newEntity{
	base = "DOOR_OPEN",
	define_as = "ELEVATOR_OPEN",
	tooltip = "An open elevator door.",
	door_closed = "ELEVATOR_DOOR",
	door_locked = "ELEVATOR_LOCKED",
}
--Locked Elevator Door
newEntity{
	base = "DOOR_LOCKED",
	define_as = "ELEVATOR_LOCKED",
	tooltip = "An unresponsive elevator door.",
	door_unlocked = "ELEVATOR_DOOR",
}

newEntity{
	base = "DOOR",
	define_as = "WINDOWED_DOOR",
	tooltip = "A closed door with a window in it.",
	display = 'o',
	door_opened = "WINDOWED_DOOR_OPEN",
	door_locked = "WINDOWED_DOOR_LOCKED",
	block_sight = false,
}

newEntity{
	base = "DOOR_OPEN",
	define_as = "WINDOWED_DOOR_OPEN",
	tooltip = "An open door.",
	door_closed = "WINDOWED_DOOR",
	door_locked = "WINDOWED_DOOR_LOCKED",
}

newEntity{
	base = "DOOR_LOCKED",
	define_as = "WINDOWED_DOOR_LOCKED",
	tooltip = "An locked door with a window in it.",
	display = 'o',
	door_closed = "WINDOWED_DOOR",
	block_sight = false,
}