
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

newTalentType{ type="combat/firearms-basic", name = "firearms", description = "Basic firearm techniques", generic = true }

newTalent{
	name = "Shoot",
	type = {"combat/firearms-basic", 1},
	points = 5,
	range = function(self, t) return math.floor(10 + self:getTalentLevel(t)*2) end,
	prefunc = function(self,t)
	local weapon, ammo = self:hasGunWeapon()
		if weapon == nil then
		game.logPlayer(self, ammo)
		return false
		end
	return true
	end,
	--message = "@Source@ shoots!",
	message = "NONE",
	action = function(self, t)
        local fudge_func = function(self, t, dist_to_target)
            local frac_dist = dist_to_target / self:getTalentRange(t)
            return math.max(0, 2 * frac_dist)
        end
        local weapon, ammo = self:hasGunWeapon()
        ammo_radius = ammo.combat and ammo.combat.radius or 0
		local tg = {type="ballbolt", range=self:getTalentRange(t), radius=ammo_radius, talent=t, fudge=fudge_func}
		return self:firearmShoot(tg)
	end,
	info = function(self, t)
		return ([[Shoot your gun!  Your training allows you to shoot at a range of %d, but your accuracy falls off as you reach your maximum range.]]):format(self:getTalentRange(t))
	end,
}

newTalent{
    name = "Headshot",
    type = {"combat/firearms-basic", 2},
    points = 5,
    mode = "passive",
    info = function(self, t)
        return ([[Increases the odds of a critical headshot to %.1f, and the damage multiplier to %.1f]]):format(10 + self:getTalentLevel(Talents.T_HEADSHOT) * 5 / 3,
                                                                           1.5 + self:getTalentLevel(Talents.T_HEADSHOT) / 3)
    end,
}