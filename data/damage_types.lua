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


-- The basic stuff used to damage a grid
setDefaultProjector(function(src, x, y, dam_type, dam)
	local target = game.level.map(x, y, Map.ACTOR)
	print('Target')
	print(target)
	if target then
		local flash = game.flash.NEUTRAL
		if target == game.player then flash = game.flash.BAD end
		if src == game.player then flash = game.flash.GOOD end

		game.logSeen(target, flash, "%s hits %s for %s%0.2f %s damage#LAST#.", src.name:capitalize(), target.name, DamageType:get(dam_type).text_color or "#aaaaaa#", dam, DamageType:get(dam_type).name)
		local sx, sy = game.level.map:getTileToScreen(x, y)
		local killed

			killed = target:takeHit(dam, src)
			text_color = colors.RED
		if killed then
			if src == game.player or target == game.player then
				game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, -3, "Kill!", {255,0,255})
			end
		else
			game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, -3, tostring(-math.ceil(dam)), {text_color.r, text_color.g, text_color.b})
		end
		return dam
	else
	target = game.level.map(x, y, Map.TERRAIN)
	--target:takeHit(dam, src)
		if target.health then
		target.health = target.health - dam
			if target.health <= 0 then
				if target.on_destroyed then
				--Makes the new destroyed tile
				game.level.map(x, y, game.level.map.TERRAIN, game.zone.grid_list[target.on_destroyed])
				end
			game.level:removeEntity(target)
			end
		end
	end
	return 0
end)

newDamageType{
	name = "physical", type = "PHYSICAL",
}

-- Lite up the room
newDamageType{
	name = "lite", type = "LITE", text_color = "#YELLOW#",
	projector = function(src, x, y, type, dam)
		game.level.map.lites(x, y, true)
	end,
}

-- Darken the room
newDamageType{
	name = "dark", type = "DARK", text_color = "#YELLOW#",
	projector = function(src, x, y, type, dam)
		game.level.map.lites(x, y, false)
		game.level.map.remembers(x, y, false)
	end,
}