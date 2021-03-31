return function(object, advanced)
	local type = typeof(object)
	
	if (type == "table") then
		if (advanced and object.ClassName) then
			return object.ClassName
		end
		
		if (getmetatable(object)) then
			return "metatable"
		end
		
		local index = 1
		
		for void in pairs(object)  do
			if (object[index] ~= nil) then
				index += 1
				continue
			end
			return "table"
		end
		
		if (index ~= 1) then
			return "array"
		end
	end
	
	if (advanced and type == "Instance") then
		return object.ClassName
	end
	
	return type
end