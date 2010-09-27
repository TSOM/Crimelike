Roadmaps = {

{
[[ | | F-+--]],
[[-+-A-4 |  ]],
[[ |   | |  ]],
[[-+---+-+--]],
[[ |   | |  ]],

[[ |---+-A-T]],
[[-J   |   |]],
[[     E---+]],
[[ f---4   |]],
[[ |   |   |]],
}
}

local VorH = {}
VorH['|'] = 'vert'
VorH['4'] = 'vert'
VorH['q'] = 'vert'
VorH['+'] = 'both'
VorH['E'] = 'both'
VorH['f'] = 'both'
VorH['J'] = 'both'
VorH['T'] = 'both'
VorH['A'] = 'horz'
VorH['-'] = 'horz'
VorH['L'] = 'horz'
--VorH['J'] = nil

local function createBlankMap()
local w = 10
local h = 10
local mapstring = ''
local minbtroads = 1
local maxbtroads = 3
city_map = {}
--Make a big blank map
	for i = 0, self.cols do
		city_map[i] = {}
		for j = 0, self.rows do
			city_map[i][j] = ' '
		end
	end
	
end
	

	for n=1, h do

		if n == 1 then
		vert = true
		else
		above = VorH[city_map[n][i - 1]] or false
			if before == 'vert' then
			vert = true
			end
		end
		

		for i=1, w do
		local notdone = true
		local before
		local gridloc = city_map[n][i]
		local vert = false
		local horz = false
		local belowspaces
			
			
			if i == 1 then
			horz = true
			else
			before = VorH[city_map[n - 1][i]] or 'fail'
				if before == 'horz' then
				horz = true
				end
			end
			
		local aboveOpenSpaces = math.random(0,maxbtroads)
		
			--Checks the ABOVE and to the EAST plot. We use this to see if it is getting to see if it is grown too tall or is too short
			for a = 1, n - 1 do
				local aboveloc = city_map[n-1][i-a] or 'fail'
				
				if aboveloc == ' ' then
				aboveOpenSpaces = a
				else
				aboveOpenSpaces = a - 1
				break
				end
			end
			
			--Checks the number of street tiles to the WEST. This is used to check if a plot is becoming too wide or narrow
			local beforeOpenSpaces = math.random(0,maxbtroads)
			
			for a = 1, n - 1 do
				local beforeloc = city_map[n-a][i] or 'fail'
				if beforeloc ~= ' ' then
				beforeOpenSpaces = a - 1
				break
				else
				beforeOpenSpaces = a
				end
			end
		-- {probability of spawning, creates eastward connection, creates southward connection}
		
		local OnlyV = {}
		OnlyV['|'] = {0, false, true}
		OnlyV['L'] = {0, true, false}
		OnlyV['E'] = {0, true, true}
		local OnlyH = {}
		OnlyH['-'] = {0, true, false}
		OnlyH['q'] = {0, false, true}
		OnlyH['T'] = {0, true, true}
		local VandH = {}
		VandH['4'] = {0, false, true}
		VandH['+'] = {0, true, true}
		VandH['A'] = {0, true, false}
		VandH['J'] = {0, false, false}

		local Any = {}
		Any['|'] = {0, false, true}
		Any['L'] = {0, true, false}
		Any['E'] = {0, true, true}
		
		Any['-'] = {0, true, false}
		Any['q'] = {0, false, true}
		Any['T'] = {0, true, true}

		Any['4'] = {0, false, true}
		Any['+'] = {0, true, true}
		Any['A'] = {0, true, false}
		Any['J'] = {0, false, false}
		
		Any['f'] = {0, true, true}
		
		
		--There's currently nothing to allow for 
		local chosentable = nil
				if horz then
					if vert then
					chosentable = table.Copy(VandH)
					elseif n == 1 then
					chosentable = table.Merge(table.Copy(VandH), table.Copy(OnlyH))
					else
					chosentable = table.Copy(OnlyH)
					end
				else
					if vert then
						if n == 1 then
						chosentable = table.Merge(table.Copy(VandH), table.Copy(OnlyV))
						else
						chosentable = table.Copy(OnlyV)
						end
					else
						if n == 1 or i == 1 then
						chosentable = table.Copy(Any)
						else
						finalChar = ' '
						end
					
					end
				end
				
		local forcesouth = false
		local denysouth = false


		if beforeOpenSpaces >= maxbtstreets then
		forcesouth = true
		elseif beforeOpenSpaces < minbtstreets then
		denysouth = true
		end

		if aboveOpenSpaces >= maxbtstreets then
		forceeast = true
		elseif aboveOpenSpaces < minbtstreets then
		denyeast = true
		end

			while finalChar == nil do
			
				for char,chartbl in pairs (chosentable) do
				local prob = chartbl[1]
				local makeeast = chartbl[2]
				local makesouth = chartbl[3]
				local southok = true
				local eastok = true
					
						if forcesouth then
							if makesouth == false then
							southok = false
							end
						elseif denysouth then
							if makesouth == true then
							southok = false
							end
						end
						
						if forceeast then
							if makeeast == false then
							eastok = false
							end
						elseif denyeast then
							if makeeast == true then
							eastok = false
							end
						end
					--Check if the potential tile has the right east and south connections if force/denies and if not, remove it from the temp table so we don't check again
					if eastok and southok then
						if math.random() <= prob then
						finalChar = char
						break
						end
					else
					chosentable[char] = nil
					end
				end
			end
		gridloc = finalChar
		end
	end
for k,v in ipairs(city_map) do
print('', string.Implode(v))
end
end