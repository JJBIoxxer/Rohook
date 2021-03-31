local _TypeOf = require(script.Parent.TypeOf)
local _Pluralize = require(script.Parent.Pluralize)

return function(parameter, allowedTypes, required, throwError, characterLimit)
	local valueType = _TypeOf(parameter[2], true)
	
	local passed = false
	local formattedMessage
	
	--> If the value type is "nil" and the value is required then create an error message for the user.
	--> If the value type is "nil" and the value isn't required then return.
	if (valueType == "nil" and required) then
		formattedMessage = string.format("The parameter '%s' is required.", parameter[1])
	 elseif (valueType == "nil" and not required) then return end
	
	--> Loop through all the allowed value types and check them against the given value's type.
	--> If a value type is matched then set "passed" to true and break out of the loop.
	for _, allowedType in ipairs(allowedTypes) do
		if (valueType == allowedType) then
			passed = true
			break
		end
	end
	
	--> If the value didn't pass the value type check then create and throw and error for the user.
	if not (passed) then
		local formattedTypes = allowedTypes[1]
		local typesLength = #allowedTypes
		
		if (typesLength == 2) then
			formattedTypes = table.concat(allowedTypes, " or ")
		elseif (typesLength > 2) then
			allowedTypes[typesLength] = "or " .. allowedTypes[typesLength]
			formattedTypes = table.concat(allowedTypes, ", ")
		end
		
		local formatted = string.format("The parameter '%s' must be a %s value. (got %s)", parameter[1], formattedTypes, valueType)
		
		if not (throwError) then
			warn(formatted)
			return
		end
		
		error(formatted)
	end
	
	--> If "string" is an allowed value type and the parameter's value type is "string" and a character limit is set then check the parameter's length against the min and max.
	--> If the length of the parameter doesn't meet the requirments then create an error message for the user.
	if (table.find(allowedTypes, "string") and valueType == "string" and characterLimit) then
		local stringLength = string.len(parameter[2])
		
		local minimum = characterLimit[1]
		local maximum = characterLimit[2]
		
		if (stringLength < minimum) then
			formattedMessage = string.format("The parameter '%s' must be at least %i %s.", parameter[1], minimum, pluralize("character", minimum))
		elseif (stringLength > maximum) then
			formattedMessage = string.format("The parameter '%s' cannot exceed %i %s.", parameter[1], maximum, pluralize("character", maximum))
		end
	end
	
	--> If an error message for created then output it.
	if (formattedMessage) then
		if not (throwError) then
			warn(formattedMessage)
			return
		end
		error(formattedMessage)
	end
end