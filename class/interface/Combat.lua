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

require "engine.class"
local DamageType = require "engine.DamageType"
local Map = require "engine.Map"
local Target = require "engine.Target"
local Talents = require "engine.interface.ActorTalents"

--- Interface to add ToME combat system
module(..., package.seeall, class.make)

--- Checks what to do with the target
-- Talk ? attack ? displace ?
function _M:bumpInto(target)
	local reaction = self:reactionToward(target)
	if reaction < 0 then
		return self:attackTarget(target)
	elseif reaction >= 0 then
		-- Displace
		if self.move_others then
			game.level.map:remove(self.x, self.y, Map.ACTOR)
			game.level.map:remove(target.x, target.y, Map.ACTOR)
			game.level.map(self.x, self.y, Map.ACTOR, target)
			game.level.map(target.x, target.y, Map.ACTOR, self)
			self.x, self.y, target.x, target.y = target.x, target.y, self.x, self.y
		end
	end
end

--- Makes the death happen!
function _M:attackTarget(target, mult)
	if self.combat then
		local dam = self:combatDamage()
		DamageType:get(DamageType.PHYSICAL).projector(self, target.x, target.y, DamageType.PHYSICAL, math.max(0, dam))
	end

	-- We use up our own energy
	self:useEnergy()
	self.did_energy = true
end

--- Check if the actor has a bow or sling and corresponding ammo
function _M:hasGunWeapon()
	if not self:getInven("MAINHAND") then return nil, "no shooter" end
	if not self:getInven("AMMO") then return nil, "no ammo" end
	local weapon = self:getInven("MAINHAND")[1]
	local ammo = self:getInven("AMMO")[1]
	if not weapon or (weapon.ranged ~= "gun") then
		return nil, "not a gun"
	end
	if not ammo or (ammo.ranged_ammo ~= "gun") then
		return nil, "bad or no ammo"
	elseif ammo.quantity == 0 then
		return nil, "clip is empty"
	end
	return weapon, ammo
end

local function firearm_projectile(tx, ty, tg, self)
	local weapon, ammo = tg.firearm.weapon, tg.firearm.ammo

	local target = game.level.map(tx, ty, game.level.map.ACTOR)
	--if not target then return end

	local talent = self:getTalentFromId(tg.talent_id)

	local damtype = ammo.damtype or DamageType.PHYSICAL
	local dam = self:combatDamage(weapon.combat, ammo.combat)
	
    -- Check for a critical hit
    local prob = 10 + (self:knowTalent(Talents.T_HEADSHOT) and self:getTalentLevel(Talents.T_HEADSHOT) * 5 / 3 or 0)
    if rng.percent(prob) then
        game.logSeen(self, "%s scores a direct hit to the head!", self.name)
        local dammult = 2 + (self:knowTalent(Talents.T_HEADSHOT) and self:getTalentLevel(Talents.T_HEADSHOT) / 3 or 0)
        dam = dam * dammult
    end
    
	--if dam > 0 then
		local grids = self:project(tg, tx, ty, function(txx, tyy)
		print('ESPLODE')
			DamageType:get(damtype).projector(self, txx, tyy, damtype, dam)
		end)
	--end
end

function _M:firearmShoot(tg)
	local weapon, ammo = self:hasGunWeapon()
	local sound, sound_miss = nil, nil
	if not weapon then
		game.logPlayer(self, "You must wield a gun (%s)!", ammo)
		return nil
	end
	params = params or {}

	print("[SHOOT WITH]", weapon.name, ammo.name)

	local x, y, target = self:getTarget(tg)
	if not x or not y then return nil end
	-- Add fudge for weapon skill
    if tg.fudge then
        local radius
        if type(tg.fudge) == "function" then
            local dist_to_target = core.fov.distance(x, y, self.x, self.y)
            radius = tg.fudge(self, tg.talent, dist_to_target)
        else
            radius = tg.fudge
        end
        print("[SHOOT FUDGE]", radius)
        local possible_tiles = {}
        for lx=x-math.ceil(radius),x+math.ceil(radius) do
            for ly=y-math.ceil(radius),y+math.ceil(radius) do
                if core.fov.distance(x, y, lx, ly) <= radius then
                    table.insert(possible_tiles, {x=lx, y=ly})
                end
            end
        end
        local picked_tile = rng.table(possible_tiles)
        x, y = picked_tile.x, picked_tile.y
    end
    
	-- Add some variables to the projectile tg
	tg.firearm = {}
	tg.firearm.weapon = weapon
	tg.firearm.ammo = ammo
	if self.combat then
		self:projectile(tg, x, y, firearm_projectile, nil, {type=ammo.particle})
	end

	-- Remove a bullet from the clip and kill the clip if empty
	ammo.quantity = ammo.quantity - 1
	if ammo.quantity == 0 then
		local _, del = self:removeObject(self:getInven("AMMO"), 1)
		game.log("You discard an empty %s.", ammo:getName{no_count=true, do_color=true})
		local sx, sy = game.level.map:getTileToScreen(self.x, self.y)
		game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, 2, "Out of ammo!", {0,0,255}, true)
	end
	return true
end

--- Gets the damage, not guaranteed to be positive
function _M:combatDamage(weapon, ammo)
	weapon = weapon or self.combat

	local totstat = 0
	local dammod = weapon.dammod or {}
	for stat, mod in pairs(dammod) do
		totstat = totstat + self:getStat(stat) * mod
	end

	local base_dam
	if ammo and ammo.dam then
		base_dam = ammo.dam
	else
		base_dam = weapon.dam
	end

	local dam_mean = base_dam + totstat
	local dam_std = dam_mean / 10
		
	return rng.normalFloat(dam_mean, dam_std)
end
