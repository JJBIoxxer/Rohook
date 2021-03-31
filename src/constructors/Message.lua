local Message = {}
Message.__index = Message
Message.ClassName = "Message"

--> Require all the utility functions needed for this module.
local _ScanParam = require(script.Parent.Parent.util.ScanParam)
local _ScanURL = require(script.Parent.Parent.util.ScanURL)
local _TypeOf = require(script.Parent.Parent.util.TypeOf)

--> Create the module's "new" constructor.
function Message.new(data)
	_ScanParam({"data", data}, {"nil", "table"}, false, true)
	
	local self = {}
	self.__index = self
	
	self.rawdata = {}
	
	function self.addEmbed(embed)
		_ScanParam({"embed", embed}, {"table", "Embed"}, true, true)
		
		if not (self.rawdata.embeds) then
			self.rawdata.embeds = {}
		end
		
		assert((#self.rawdata.embeds + 1) <= 10, "You cannot exceed 10 embeds per message.")
		
		local rawData = embed.rawdata or embed
		
		table.insert(self.rawdata.embeds, rawData)
		
		return self
	end
	
	function self.addEmbeds(...)
		local embeds = {...}
		
		_ScanParam({"embeds", embeds[1]}, {"array", "table", "Embed"}, true, true)
		
		if (_TypeOf(embeds[1]) == "array") then
			embeds = embeds[1]
		end
		
		for _, embed in next, embeds do
			_ScanParam({"embed", embed}, {"table", "Embed"}, false, true)
			self.addEmbed(embed)
		end
		
		return self
	end
	
	function self.setAvatarURL(url)
		_ScanParam({"url", url}, {"string"}, true, true)
		
		_ScanURL(url)
		
		self.rawdata.avatar_url = url
		
		return self
	end
	
	function self.setContent(content)
		_ScanParam({"content", content}, {"string"}, true, true, {1, 2000})
		
		self.rawdata.content = content
		
		return self
	end
	
	function self.setUsername(username)
		_ScanParam({"username", username}, {"string"}, true, true, {1, 80})
		
		self.rawdata.username = username
		
		return self
	end
	
	--> Create shorthand and/or support of older verisons.
	self.setAvatar = self.setAvatarURL
	
	--> Return the object data as a metatable.
	return setmetatable(self, Message)
end

Message.__call = function(t, ...) return Message.new(...) end

--> Return the module data as a metatable.
return setmetatable(Message, Message)