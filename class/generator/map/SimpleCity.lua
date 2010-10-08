require "engine.class"
local Map = require "engine.Map"
require "engine.Generator"
module(..., package.seeall, class.inherit(engine.Generator))

function _M:init(zone, map, level, data)
	engine.Generator.init(self, zone, map, level)
	self.grid_list = self.zone.grid_list
	self.subgen = {}
	self.spots = {}
	self.data = data
	if data.adjust_level then
		self.adjust_level = {base=zone.base_level, lev = self.level.level, min=data.adjust_level[1], max=data.adjust_level[2]}
	else
		self.adjust_level = {base=zone.base_level, lev = self.level.level, min=0, max=0}
	end
	self.tiles = {}
self.legend = {}
self.legend['-'] = {
[[     ]],
[[     ]],
[[-----]],
[[     ]],
[[     ]],
}
self.legend['|'] = {
[[  |  ]],
[[  |  ]],
[[  |  ]],
[[  |  ]],
[[  |  ]],
}

self.legend['+'] = {
[[  |  ]],
[[  |  ]],
[[--+--]],
[[  |  ]],
[[  |  ]],
}

self.legend['J'] = {
[[  |  ]],
[[  |  ]],
[[--+  ]],
[[     ]],
[[     ]],
}

self.legend["L"] = {
[[  |  ]],
[[  |  ]],
[[  +--]],
[[     ]],
[[     ]],
}
self.legend['f'] = {
[[     ]],
[[     ]],
[[  +--]],
[[  |  ]],
[[  |  ]],
}
self.legend['q'] = {
[[     ]],
[[     ]],
[[--+  ]],
[[  |  ]],
[[  |  ]],
}
self.legend['A'] = {
[[  |  ]],
[[  |  ]],
[[--+--]],
[[     ]],
[[     ]],
}
self.legend['4'] = {
[[  |  ]],
[[  |  ]],
[[--+  ]],
[[  |  ]],
[[  |  ]],
}
self.legend['E'] = {
[[  |  ]],
[[  |  ]],
[[  +--]],
[[  |  ]],
[[  |  ]],
}
self.legend['T'] = {
[[     ]],
[[     ]],
[[--+--]],
[[  |  ]],
[[  |  ]],
}
	self:createBlankMap()
end
	

function _M:createBlankMap()

--At some stage I broke the functionality for having different maxW and maxH's. Currently, it won't work right unless the sides are the same size.
local maxw = 20
local maxh = 20
local mapstring = ''
local minPlotSize = 3
local maxPlotSize = 6
self.blockScale = 5
local before
local after
city_map = {}
--Make a big blank map
	for i = 1, maxw do
		city_map[i] = {}
		for j = 1, maxh do
			city_map[i][j] = '*'
		end
	end
local row = 2
local col = 2

	local function findStreetDown(r,c)
	r = r + 1
		while city_map[r][c] ~= '*' do
		r = r + 1

		end

	return r + 1

	end
	
	while row <= maxh - 1 do
	
		if city_map[row][col] == '*' then
		
			--If right is street, and down is street and top left not plot and top right not plot then
			if city_map[row][col + 1] == '*' and city_map[row + 1][col] == '*' and city_map[row - 1][col - 1] ~= 'X' and city_map[row - 1][col + 1] ~= 'X'then
			
			local availh = maxh - row
			local availw = maxw - col
			
				for i = 1, maxPlotSize * 2 do
					--Can probably do this check before this for loop
					if col + i == maxw then
						if i < availw then
						availw = i
						end
					break
					
					end
					
					if city_map[row][col + i + 1] == 'X' or city_map[row - 1][col + i + 1] == 'X' then
						if i < availw then
						availw = i
						end
					break
					end
				end
				
				for i = 1, maxPlotSize * 2 do
				
					if row + i == maxh then
						if i < availh then
						availh = i
						end
					break
					end
					
					if city_map[row + i + 1][col] == 'X' or city_map[row + i + 1][col - 1] == 'X' then
						if i < availh then
						availh = i
						end
					break
					end
				end
				
			local plotw = rng.range(minPlotSize,maxPlotSize)
			local ploth = rng.range(minPlotSize,maxPlotSize)
			
			if availw < (minPlotSize + plotw + 1) then plotw = availw end
			if availh < (minPlotSize + ploth + 1) then ploth = availh end
			if ploth > availh then ploth = availh end
			if plotw > availw then plotw = availw end

				for r = 0, ploth - 1 do
					for c = 0, plotw - 1 do
					city_map[row + r][col + c] = 'X'
					end
				end
			
				col = col + plotw
					print('CITY')
					for k,v in ipairs(city_map) do
					print(string.Implode('',v))
					end
				
			end
		
		end
		col = col + 1
		if col > maxw then
			col = 2
			row = row + 1		
		end
	end
	
	---MAKE THE STREETS
		row = 1
		col = 1
		while row <= maxh do
	
			if city_map[row][col] == '*' then
			
				local east = city_map[row][col + 1] or "X"
				
				local south = 'X'
				local north = 'X'
				if row < maxh then
				south = city_map[row + 1][col] or "X"
				end
				if row > 1 then
				north = city_map[row - 1][col] or "X"
				end
				local west = city_map[row][col - 1] or "X"
				--I could instead compare to a table and cycle through each street, but this should be faster, though messier looking
				if north ~= 'X' then
					if east ~= 'X' then
						if south ~= 'X' then
							 if west ~= 'X' then
							 city_map[row][col] = '+'
							 else
							 city_map[row][col] = 'E'
							 end
						elseif west ~= 'X' then
						city_map[row][col] = 'A'
						else
						city_map[row][col] = 'L'
						end
					elseif west ~= 'X' then
						if south ~= 'X' then
						city_map[row][col] = '4'
						else
						city_map[row][col] = 'A'
						end
					elseif south ~= 'X' then
					city_map[row][col] = '|'
					end
				elseif east ~= 'X' then
					if south ~= 'X' then
						if west ~= 'X' then
						city_map[row][col] = 'T'
						else
						city_map[row][col] = 'f'
						end
					elseif west ~= 'X' then
					city_map[row][col] = '-'
					end
				elseif south ~= 'X' then
					if west ~= 'X' then
					city_map[row][col] = 'q'
					end
				end
			end
		
		col = col + 1
			if col > maxw then
				col = 1
				row = row + 1		
			end
		end
	row = 1
	col = 1

	while row <= maxh do
	local curplotw = 1
	local curploth = 1
	
		if city_map[row][col] == 'X' then
			for i = 1, maxPlotSize * 2 do
			
			--city_map[row][col + i - 1] = 'Y'
			
				if city_map[row][col + i] ~= 'X' then
				curplotw = i
				break

				end
			end
			
			for i = 1, maxPlotSize * 2 do
				--city_map[row + i - 1][col] = 'Y'
				if city_map[row +i][col] ~= 'X' then
				curploth = i
				break
				end
			end
			
			self:chooseTileBlock(row,col,curplotw,curploth)
				for n = 0, curploth - 1 do
					for m = 0, curplotw - 1 do 
					local tdoo = row+n
					local tboo = col+m
					city_map[row+n][col+m] = 'Y'
					end
				end
		elseif city_map[row][col] ~= 'Y' then
		self:placeStreetBlock(row, col)
		
		end

		col = col + curplotw
		if col > maxw then
			col = 1
			row = row + 1		
		end
	end
	
	print('CITY')
	for k,v in ipairs(city_map) do
	print(string.Implode('',v))
	end
end

function _M:determineRotation(fullpath, curplotw,curploth)

	local t = {}


	--print("Static generator using file", "/data/maps/"..file..".lua")
	local f, err = loadfile("/data/plots/".. fullpath)
	if not f and err then error(err) end
	local g = {
		Map = require("engine.Map"),
		subGenerator = function(g)
			self.subgen[#self.subgen+1] = g
		end,
		defineTile = function(char, grid, obj, actor, trap, status)
			t[char] = {grid=grid, object=obj, actor=actor, trap=trap, status=status}
		end,
		quickEntity = function(char, e, status)
			if type(e) == "table" then
				local e = self.zone.grid_class.new(e)
				t[char] = {grid=e, status=status}
			else
				t[char] = t[e]
			end
		end,
		prepareEntitiesList = function(type, class, file)
			local list = require(class):loadList(file)
			self.level:setEntitiesList(type, list)
		end,
		addData = function(t)
			table.merge(self.level.data, t, true)
		end,
		getMap = function(t)
			return self.map
		end,
		checkConnectivity = function(dst, src, type, subtype)
			self.spots[#self.spots+1] = {x=dst[1], y=dst[2], check_connectivity=src, type=type or "static", subtype=subtype or "static"}
		end,
		addSpot = function(dst, type, subtype)
			self.spots[#self.spots+1] = {x=dst[1], y=dst[2], type=type or "static", subtype=subtype or "static"}
		end,
	}
	setfenv(f, setmetatable(g, {__index=_G}))
	local ts, err = f()
	if not ts and err then error(err) end
	
	self.tiles = t


for k,v in pairs (ts) do
ts[k] = string.Explode("",v)

end
	
local rotationnum = 1
if curplotw == curploth then 
rotationum = rng.range(1,4)
elseif curplotw > curploth then
	if rng.percent(50) then
	rotationnum = 2
	else
	rotationnum = 4
	end
else
	if rng.percent(50)then
	rotationnum = 1
	else
	rotationnum = 3
	end
end



--[[for n = 1, #ts do
ts[n] = string.Explode("",ts[n])

end]]

t = table.Copy(ts)

--All rotations are negative
		--90 degrees
		
		if rotationnum == 1 then
			
			local mx, my = #ts[1], #ts
			for j = 1, my do
				for ri = 1, mx do
				local i = mx - ri + 1
				t[i] = t[i] or {}
				t[i][j] = ts[j][ri]
				end 
			end

		-- 180degree rotation
		elseif rotationnum == 2 then
			local mx, my = #ts, #ts[1]
			for rj = 1, my do for ri = 1, mx do
				local i = mx - ri + 1
				local j = my - rj + 1
				t[i] = t[i] or {}
				t[i][j] = ts[ri][rj]
			end end

		-- 270degree rotation
		elseif rotationnum == 3 then
			local mx, my = #ts[1], #ts
			for rj = 1, my do for i = 1, mx do
				local j = my - rj + 1
				t[i] = t[i] or {}
				t[i][j] = ts[rj][i]
			end end
		end

		--X Symetric
		if rng.percent(50) then
		ts = nil
		ts = table.Copy(t)
			local mx, my = #ts, #ts[1]
			for j = 1, my do for ri = 1, mx do
				local i = mx - ri + 1
				t[i] = t[i] or {}
				t[i][j] = ts[ri][j]
			end end

		-- Y symetric tile definition
		elseif rng.percent(50) then
		ts = nil
		ts = table.Copy(t)
			local mx, my = #ts, #ts[1]
			for rj = 1, my do for i = 1, mx do
				local j = my - rj + 1
				t[i] = t[i] or {}
				t[i][j] = ts[i][rj]
			end end
		end
--[[for k,v in ipairs (t) do
print(string.Implode("",v))
end]]
return t
end

local streetclasses = {}
streetclasses[' '] = 'STREET'
streetclasses['-'] = 'STREETLINE'
streetclasses['|'] = 'STREETLINEB'
streetclasses['+'] = 'STREETLINEC'

function _M:placeStreetBlock(row,col)
local char = city_map[row][col]


local strtbl = self.legend[char]
	for k,v in ipairs(strtbl) do
		for i = 1, v:len() do
		--game.level.map(row+k - 1,col + i - 1, Map.TERRAIN, game.zone.grid_list[string.sub(v,i,i)])
		self.map((row - 1) * self.blockScale - 1 + k,(col - 1) * self.blockScale - 1 + i, Map.TERRAIN, self.grid_list[streetclasses[string.sub(v,i,i)]])
		--self.gen_map[row+k - 1][col + i - 1] = self.grid_list[string.sub(v,i,i)]
		--self.gen_map[row+k - 1][col + i - 1] = "+"
		end
	end

	
end



local plotTypes = fs.list("/mod/data/plots/")

function _M:chooseTileBlock(row, col, curplotw, curploth)

local dirName

	if curploth > curplotw then
	dirName = curploth .. 'x' .. curplotw
	else
	dirName = curplotw .. 'x' .. curploth
	end
local chosenplot = nil
	--while chosenplot == nil do
		if table.HasValue(fs.list("/mod/data/plots/"),dirName) then
		local availplots = fs.list("/mod/data/plots/" .. dirName)
			
			if availplots[1] == ".svn" then 
			table.remove(availplots, 1)
			end
			
			while chosenplot == nil do
				for k,v in pairs (availplots) do
					if rng.range(1,#availplots) == 1 then
					chosenplot = v
					print(chosenplot)
					self:createTile(self:determineRotation(dirName .. "/" .. chosenplot, curplotw,curploth),row,col)
					break
					end
				end
			end

		else
		print("No plots with dimension " .. curplotw .. "x" .. curploth)
			for j = 1, curploth * self.blockScale do
				for i = 1, curplotw * self.blockScale do
				self.map((row - 1)*self.blockScale - 1 + j,(col - 1)*self.blockScale - 1 + i, Map.TERRAIN, self.grid_list['FLOOR'])
				end
				
			end
		end
	--end

end


function _M:createTile(tileblock,row,col)



	
	for rownum, tilerow in ipairs(tileblock) do
		for colnum, tile in ipairs(tilerow) do
		--self.room_map[row+rownum-1][col + colnum-1] = tile
		--self.map(row+rownum-1, col + colnum-1, Map.TERRAIN, self:resolve(game.zone.grid_list[self.tiles[tile]]))
		self.map((row - 1)*self.blockScale+rownum - 1,(col - 1)*self.blockScale + colnum - 1, Map.TERRAIN, self.grid_list[self.tiles[tile]['grid']])
		end
	end
	
end

function _M:generate(lev, old_lev)

		if status then
			if status.lite then self.level.map.lites(i-1, j-1, true) status.lite = nil end
			if status.remember then self.level.map.remembers(i-1, j-1, true) status.remember = nil end
			if pairs(status) then for k, v in pairs(status) do self.level.map.attrs(i-1, j-1, k, v) end end
		end

	return 1,1,1,2
end
