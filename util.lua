
function string.Explode ( seperator, str )

	if ( seperator == "" ) then
		return string.ToTable( str )
	end

	local tble={}	
	local ll=0
	
	while (true) do
	
		l = string.find( str, seperator, ll, true )
		
		if (l ~= nil) then
			table.insert(tble, string.sub(str,ll,l-1)) 
			ll=l+1
		else
			table.insert(tble, string.sub(str,ll))
			break
		end
		
	end
	
	return tble
	
end


function string.Implode(seperator,Table) return 
	table.concat(Table,seperator) 
end

function string.ToTable ( str )

	local tab = {}
	
	for i=1, string.len( str ) do
		table.insert( tab, string.sub( str, i, i ) )
	end
	
	return tab

end

function PrintTable ( t, indent, done, text )

if text ~= nil then
print(text)
end
	--if type(t) ~= table then return false end
	done = done or {}
	indent = indent or 0

	for key, value in pairs (t) do
		print( string.rep ("\t", indent) )
		if type (value) == "table" and not done [value] then

	      	done [value] = true
	      	print(tostring (key) .. ":");
	     	PrintTable (value, indent + 2, done)

	    else
	      	print(tostring (key) .. "\t=\t" .. tostring(value))

	    end

	end
	
end

function table.Copy(t, lookup_table)
	if (t == nil) then return nil end
	
	local copy = {}
	setmetatable(copy, getmetatable(t))
	for i,v in pairs(t) do
		if type(v) ~= "table" then
			copy[i] = v
		else
			lookup_table = lookup_table or {}
			lookup_table[t] = copy
			if lookup_table[v] then
				copy[i] = lookup_table[v] -- we already copied this table. reuse the copy.
			else
				copy[i] = table.Copy(v,lookup_table) -- not yet copied. copy it.
			end
		end
	end
	return copy
end


function table.HasValue(tbl, value)

	for k,v in pairs(tbl) do
		if v == value then
		return true
		end
	end
return false
end


function table.HasKey(tbl, key)

	for k,v in pairs(tbl) do
		if k == key then
		return true
		end
	end
return false
end