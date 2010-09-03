
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
-- Mikolai Fajer "yufra"
-- mfajer@gmail.com

newTalentType{ type="combat/unarmed", name = "unarmed combat", description = "Unarmed combat techniques" }

newTalent{
	name = "Kick",
	type = {"combat/unarmed", 1},
	points = 5,
    stamina = 5,
	cooldown = 2,
	range = 1,
	action = function(self, t)
		local tg = {type="hit", range=self:getTalentRange(t)}
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end
		if math.floor(core.fov.distance(self.x, self.y, x, y)) > 1 then return nil end

		local dam = self.combat.dam + self:getStr() - target.combat_armor
		DamageType:get(DamageType.PHYSICAL).projector(self, target.x, target.y, DamageType.PHYSICAL, math.max(0, dam/2))
		target:knockback(self.x, self.y, 1 + math.ceil(self:getTalentLevel(t) / 5 * self:getStr(20)))
		return true
	end,
	info = function(self, t)
		return "Kick!"
	end,
}

newTalent{
	name = "Tackle",
	type = {"combat/unarmed", 2},
	points = 5,
    stamina = 15,
	cooldown = 20,
	range = function(self, t) return math.floor(2 + self:getTalentLevel(t)) end,
	action = function(self, t)
		local tg = {type="hit", range=self:getTalentRange(t)}
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end
		if math.floor(core.fov.distance(self.x, self.y, x, y)) > self:getTalentRange(t) then return nil end

		local l = line.new(self.x, self.y, x, y)
		local lx, ly = l()
		local tx, ty = self.x, self.y
		while lx and ly do
			if game.level.map:checkAllEntities(lx, ly, "block_move", self) then break end
			tx, ty = lx, ly
			lx, ly = l()
		end

		game.level.map:particleEmitter(self.x, self.y, nil, "fast_movement", {tx=tx-self.x, ty=ty-self.y})
		self:move(tx, ty, true)

		-- Attack ?
		if math.floor(core.fov.distance(self.x, self.y, x, y)) == 1 then
			local dam = self.combat.dam + self:getStr() - target.combat_armor
			DamageType:get(DamageType.PHYSICAL).projector(self, target.x, target.y, DamageType.PHYSICAL, math.max(0, dam/2))
			target:setEffect(target.EFF_STUNNED, 2 + self:getTalentLevel(t) / 2, {})
			local self_stun_chance = math.max(40 - self:getTalentLevel(t) * 4, 10)
			print("[DEBUG] chance to stun self on tackle: ", self_stun_chance)
			if rng.percent(self_stun_chance) then
				self:setEffect(target.EFF_STUNNED, 2, {})
			end
		end
		return true
	end,
	info = function(self, t)
		return "A flying tackle that stuns the target.  This is a dangerous move, and can stun the attacker as well."
	end,
}