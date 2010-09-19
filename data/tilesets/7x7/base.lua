
base = {w=7, h=7}
local matchedones = {}
matchedones[' '] = true
matchedones['-'] = true
matchedones['|'] = true
matchedones['='] = true
matchedones[' '] = true

is_opening = function(c)
	return (c == '-' or c == '|') and true or false
end

matcher = function(t1, t2)
	if t1 == false or t2 == false then return true, true end
	if t1 == t2 then return true, true end
	if t1 == '-' and t2 == "|" then return true, true end
	if t2 == '-' and t1 == "|" then return true, true end
	return false, false
end


tiles = {}
