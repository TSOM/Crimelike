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

require "engine.class"
local Map = require "engine.Map"
local ShowComplexInv = require "mod.dialogs.ComplexInv"
local ShowPickupFloor = require "engine.dialogs.ShowPickupFloor"

--- Handles actors stats
module(..., package.seeall, class.make)

_M.inven_def = {}

--- Defines stats
-- Static!
function _M:defineInventory(short_name, name, is_worn, desc)
	assert(name, "no inventory slot name")
	assert(short_name, "no inventory slot short_name")
	assert(desc, "no inventory slot desc")
	table.insert(self.inven_def, {
		name = name,
		short_name = short_name,
		description = desc,
		is_worn = is_worn,
	})
	self.inven_def[#self.inven_def].id = #self.inven_def
	self.inven_def[short_name] = self.inven_def[#self.inven_def]
	self["INVEN_"..short_name:upper()] = #self.inven_def
	print("[INVENTORY] define slot", #self.inven_def, self.inven_def[#self.inven_def].name)
end

-- Auto define the inventory
_M:defineInventory("AIR", "In air", false, "In the air")
_M:defineInventory("INVEN", "In inventory", false, "")
_M:defineInventory("FLOOR", "On floor", false, "On the floor")

--- Initialises inventories with default values if needed
function _M:init(t)
	self.inven = t.inven or {}
	self.invenPriorities = {} --Stores inven or object and itemInven 
	self:initBody()
end

function _M:initBody()
	if self.body then
		for inven, max in pairs(self.body) do
			self.inven[self["INVEN_"..inven]] = {max=max[1], maxVolume = max[2], worn=self.inven_def[self["INVEN_"..inven]].is_worn}
		end
		self.body = nil
	end
end

--- Returns the content of an inventory as a table
function _M:getInven(id)
	if type(id) == "number" then
		return self.inven[id]
	elseif type(id) == "string" then
		return self.inven[self["INVEN_"..id]]
	else
		return id
	end
end

function _M:addObjectToAnyInven(o, drop_object) --If dropObject is true, the object is placed on the map at self.x, self.y if adding it fails
	local objectAdded = false
	for priority, data in pairs(self.invenPriorities) do
		if data.inven then
			objectAdded = self:addObject(data.inven, o)
		elseif data.object then
			for inven_id, inven in pairs(self.inven) do
				for items, object in pairs(inven) do
					if object == data.object then
						objectAdded = object:addObject(data.itemInven, o)
					end
				end
			end
		end
		if objectAdded then
			break
		end
	end
	if not objectAdded then -- Checking all inventory slots
		for inven_id, inven in pairs(self.inven) do
			if inven_id ~= self.INVEN_AIR and inven_id ~= self.INVEN_FLOOR then
				if not self.inven_def[inven_id].is_worn then
					for item, object in ipairs(inven) do
						for object_inven_id, object_inven in pairs(object.inven) do
							if not object.inven_def[object_inven_id].is_worn then
								objectAdded = object:addObject(object_inven, o)
								if objectAdded then break end
							end
						end
						if objectAdded then break end
					end
					if not objectAdded then
						objectAdded = self:addObject(inven, o)
					end
				end
				if objectAdded then break end
			end
		end
	end
			
	if not objectAdded then -- No space remaining. Dropping object.
		if drop_object then
			game.level.map:addObject(self.x, self.y, o)
		end
		return false
	end
	return true
end

--- Adds an object to an inventory
-- @return false if the object could not be added
function _M:addObject(inven_id, o)
	local inven
	if type(inven_id) == "number" then
		inven = self.inven[inven_id]
	else
		inven = inven_id
	end
	
	-- No room ?
	local totalVolume = o:getVolume()
	for i, item in ipairs(inven) do
		totalVolume = totalVolume + item:getVolume()
	end
	
	if totalVolume > inven.maxVolume then return false end
	
	if #inven >= inven.max and inven.max ~= -1 then return false end

	if o:check("on_preaddobject", self, inven) then return false end

	-- Ok add it
	table.insert(inven, o)

	-- Do whatever is needed when wearing this object
	if inven.worn then
		o:check("on_wear", self)
		self:onWear(o)
	end

	self:onAddObject(o)

	return true
end

--- Rerturns the position of an item in the given inventory, or nil
function _M:itemPosition(inven, o)
	inven = self:getInven(inven)
	for i, p in ipairs(inven) do
		local found = nil
		o:forAllStack(function(so)
			if p.name == so.name then found = i return true end
		end)
		if found then return found end
	end
	return nil
end

--- Picks an object from the floor
-- Inven controls which slot the item is put into, and container controls which object the item is put into (this can be nil)
-- If both inven and container are nil, all slots are tried until the item is successfully added
function _M:pickupFloor(i, vocal, no_sort, inven, container) 
	local o = game.level.map:getObject(self.x, self.y, i)
	local success = false
	if o then
		local prepickup = o:check("on_prepickup", self, i)
		if inven == nil and container == nil then
			success = self:addObjectToAnyInven(o)
		else
			container = container or self
			success = container:addObject(inven or container.INVEN_INVEN, o)
		end
		if not prepickup and success then
			game.level.map:removeObject(self.x, self.y, i)
			if not no_sort then self:sortInven(self.INVEN_INVEN) end

			o:check("on_pickup", self)
			self:check("on_pickup_object", o)

			if vocal then game.logSeen(self, "%s picks up: %s.", self.name:capitalize(), o:getName{do_color=true}) end
		elseif not prepickup then
			if vocal then game.logSeen(self, "%s has no room for: %s.", self.name:capitalize(), o:getName{do_color=true}) end
		end
	else
		if vocal then game.logSeen(self, "There is nothing to pickup there.") end
	end
	return success
end

--- Removes an object from inventory
-- @param inven the inventory to drop from
-- @param item the item id to drop
-- @param no_unstack if the item was a stack takes off the whole stack if true
-- @return the object removed or nil if no item existed and a boolean saying if there is no more objects
function _M:removeObject(inven, item, no_unstack)
	if type(inven) == "number" then inven = self.inven[inven] end

	if not inven[item] then return false, true end

	local o, finish = inven[item], true

	if o:check("on_preremoveobject", self, inven) then return false, true end

	if not no_unstack then
		o, finish = o:unstack()
	end
	if finish then
		table.remove(inven, item)
	end

	-- Do whatever is needed when takingoff this object
	if inven.worn then
		o:check("on_takeoff", self)
		self:onTakeoff(o)
	end

	self:onRemoveObject(o)

	return o, finish
end

--- Called upon adding an object
function _M:onAddObject(o)
	if self.__allow_carrier then
		-- Apply carrier properties
		o.carried = {}
		if o.carrier then
			for k, e in pairs(o.carrier) do
				o.carried[k] = self:addTemporaryValue(k, e)
			end
		end
	end
end
--- Called upon removing an object
function _M:onRemoveObject(o)
	if o.carried then
		for k, id in pairs(o.carried) do
			self:removeTemporaryValue(k, id)
		end
	end
	o.carried = nil
end

--- Drop an object on the floor
-- @param inven the inventory to drop from
-- @param item the item id to drop
-- @return the object removed or nil if no item existed
function _M:dropFloor(inven, item, vocal, all)
	local o = self:getInven(inven)[item]
	if not o then
		if vocal then game.logSeen(self, "There is nothing to drop.") end
		return
	end
	if o:check("on_drop", self) then return false end
	o = self:removeObject(inven, item, all)
	game.level.map:addObject(self.x, self.y, o)
	if vocal then game.logSeen(self, "%s drops on the floor: %s.", self.name:capitalize(), o:getName{do_color=true}) end
	return true
end

--- Show combined equipment/inventory dialog
-- @param inven the inventory (from self:getInven())
-- @param filter nil or a function that filters the objects to list
-- @param action a function called when an object is selected
function _M:showComplexInv(title, filter, action, allow_keybind)
	local d = ShowComplexInv.new(title, self, filter, action, allow_keybind and self)
	game:registerDialog(d)
	return d
end

--- Show floor pickup dialog
-- @param filter nil or a function that filters the objects to list
-- @param action a function called when an object is selected
function _M:showPickupFloor(title, filter, action)
	local d = ShowPickupFloor.new(title, self.x, self.y, filter, action)
	game:registerDialog(d)
	return d
end

--- Can we wear this item?
function _M:canWearObject(o, try_slot, is_item)
	local req = rawget(o, "require")

	-- Check prerequisites
	if not is_item then
		if req then
			-- Obviously this requires the ActorStats interface
			if req.stat then
				for s, v in pairs(req.stat) do
					if self:getStat(s) < v then return nil, "not enough stat" end
				end
			end
			if req.level and self.level < req.level then
				return nil, "not enough levels"
			end
			if req.talent then
				for _, tid in ipairs(req.talent) do
					if not self:knowTalent(tid) then return nil, "missing dependency" end
				end
			end
		end
	end
	
	-- Check item slot
	if self:getInven(o.slot) ~= self:getInven(try_slot) then
		return nil, "cannot wear in this slot"
	end

	-- Check forbidden slot
	if o.slot_forbid then
		local inven = self:getInven(o.slot_forbid)
		-- If the object cant coexist with that inventory slot and it exists and is not empty, refuse wearing
		if inven and #inven > 0 then
			return nil, "cannot use currently due to an other worn object"
		end
	end

	-- Check that we are not the forbidden slot of any other worn objects
	for id, inven in pairs(self.inven) do
		if self.inven_def[id].is_worn then
			for i, wo in ipairs(inven) do
				print("fight: ", o.name, wo.name, "::", wo.slot_forbid, try_slot or o.slot)
				if wo.slot_forbid and wo.slot_forbid == (try_slot or o.slot) then
					return nil, "cannot use currently due to an other worn object"
				end
			end
		end
	end

	return true
end

--- Wear/wield an item
function _M:wearObject(o, replace, vocal, inven)
	local inven = inven or o:wornInven()
	if not inven then
		if vocal then game.logSeen(self, "%s is not wearable.", o:getName{do_color=true}) end
		return false
	end
	print("wear slot", inven)
	local ok, err = self:canWearObject(o, inven)
	if not ok then
		if vocal then game.logSeen(self, "%s can not wear: %s (%s).", self.name:capitalize(), o:getName{do_color=true}, err) end
		return false
	end
	if o:check("on_canwear", self, inven) then return false end

	if self:addObject(inven, o) then
		if vocal then game.logSeen(self, "%s wears: %s.", self.name:capitalize(), o:getName{do_color=true}) end
		return true
	elseif o.offslot and self:getInven(o.offslot) and #(self:getInven(o.offslot)) < self:getInven(o.offslot).max and self:canWearObject(o, o.offslot) then
		if vocal then game.logSeen(self, "%s wears(offslot): %s.", self.name:capitalize(), o:getName{do_color=true}) end
		-- Warning: assume there is now space
		self:addObject(self:getInven(o.offslot), o)
		return true
	elseif replace then
		local ro = self:removeObject(inven, 1, true)

		if vocal then game.logSeen(self, "%s wears: %s.", self.name:capitalize(), o:getName{do_color=true}) end

		-- Can we stack the old and new one ?
		if o:stack(ro) then ro = true end

		-- Warning: assume there is now space
		self:addObject(inven, o)
		return ro
	else
		if vocal then game.logSeen(self, "%s can not wear: %s.", self.name:capitalize(), o:getName{do_color=true}) end
		return false
	end
end

--- Takeoff item
function _M:takeoffObject(inven, item)
	local o = self:getInven(inven)[item]
	if o:check("on_cantakeoff", self, inven) then return false end

	o = self:removeObject(inven, item, true)
	return o
end

--- Call when an object is worn
function _M:onWear(o)
	-- Apply wielder properties
	o.wielded = {}
	if o.wielder then
		for k, e in pairs(o.wielder) do
			o.wielded[k] = self:addTemporaryValue(k, e)
		end
	end
end

--- Call when an object is taken off
function _M:onTakeoff(o)
	if o.wielded then
		for k, id in pairs(o.wielded) do
			self:removeTemporaryValue(k, id)
		end
	end
	o.wielded = nil
end

--- Re-order inventory, sorting and stacking it
function _M:sortInven(inven)
	if not inven then
		for inven_id, nextInven in pairs(self.inven) do
			self:sortInven(nextInven)
		end
		return
	end
	inven = self:getInven(inven)

	-- Stack objects first, from bottom
	for i = #inven, 1, -1 do
		-- If it is stackable, look for obejcts before it that it could stack into
		if inven[i]:stackable() then
			for j = i - 1, 1, -1 do
				if inven[j]:stack(inven[i]) then
					table.remove(inven, i)
					break
				end
			end
		end
	end

	-- Sort them
	table.sort(inven, function(a, b)
		local ta, tb = a:getTypeOrder(), b:getTypeOrder()
		local sa, sb = a:getSubtypeOrder(), b:getSubtypeOrder()
		if ta == tb then
			if sa == sb then
				return a.name < b.name
			else
				return sa < sb
			end
		else
			return ta < tb
		end
	end)
end

--- Finds an object by name in an inventory
-- @param inven the inventory to look into
-- @param name the name to look for
-- @param getname the parameters to pass to getName(), if nil the default is {no_count=true, force_id=true}
function _M:findInInventory(inven, name, getname)
	getname = getname or {no_count=true, force_id=true}
	for item, o in ipairs(inven) do
		if o:getName(getname) == name then return o, item end
	end
end

--- Finds an object by name in all the actor's inventories
-- @param name the name to look for
-- @param getname the parameters to pass to getName(), if nil the default is {no_count=true, force_id=true}
function _M:findInAllInventories(name, getname)
	for inven_id, inven in pairs(self.inven) do
		local o, item = self:findInInventory(inven, name, getname)
		if o and item then return o, item, inven_id end
	end
end

function _M:getEncumbrance()
	-- Compute encumbrance
	local enc = 0
	for inven_id, inven in pairs(self.inven) do
		for item, o in ipairs(inven) do
			o:forAllStack(function(so) enc = enc + so:getEncumbrance() end)
		end
	end
	enc = enc + (self.encumber or 0)
--	print("Total encumbrance", enc)
	return enc
end

function _M:getVolume()
	-- Compute volume
	local vol = 0
	if not self.staticVolume then
		for inven_id, inven in pairs(self.inven) do
			for item, o in ipairs(inven) do
				o:forAllStack(function(so) vol = vol + so:getVolume() end)
			end
		end
	end
	vol = vol + (self.volume or 0)
	return vol
end
