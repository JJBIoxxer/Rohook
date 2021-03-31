local Webhook = {}
Webhook.__index = Webhook
Webhook.ClassName = "Webhook"

--> Get any Roblox services needed for this module.
local http = game:GetService("HttpService")

--> Define the variable "webhook" and assign it a Discord Webhook URL string pattern.
local webhook = "https://discordapp.com/api/webhooks/%d+/.+"

--> Require all the utility functions needed for this module.
local _ScanParam = require(script.Parent.Parent.util.ScanParam)

--> Create the module's "new" constructor.
function Webhook.new(url)
	_ScanParam({"url", url}, {"string"}, true, true)
	
	if not (string.match(url, webhook)) then
		error("Please provide a valid Discord Webhook URL.")
	end
	
	local self = {}
	self.__index = self
	
	self.url = tostring(url)
	
	function self.send(message)
		_ScanParam({"message", message}, {"table", "Message"}, true, true)
		
		local enabled = pcall(function() http:GetAsync("https://www.google.com/") end)
		assert(enabled, "Http requests are disabled for this place. Turn them on via the game settings.")
		
		local rawData = message.rawdata or message
		local encodedData = http:JSONEncode(rawData)
		
		local success, errorMessage = pcall(function()
			http:PostAsync(self.url, encodedData)
		end)
		
		if not (success) then
			warn("PostAsync failed: ", errorMessage)
		end
		
		return self
	end
	
	return setmetatable(self, Webhook)
end

Webhook.__call = function(t, ...) return Webhook.new(...) end

--> Return the module data as a metatable.
return setmetatable(Webhook, Webhook)