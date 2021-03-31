local _TypeOf = require(script.Parent.TypeOf)

return function(url) 
	if (_TypeOf(url) == "string" and not string.match(url, "https?://")) then
		error("Please provide a valid URL.")
	end
end