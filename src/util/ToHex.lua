return function(...)
	local hex = "#"
	
	for _, int in next, {...} do
		local base = math.floor(int / 16)
		local remainder = int - (base * 16)
		hex ..= string.format("%X%X", base, remainder)
	end
	
	return hex
end