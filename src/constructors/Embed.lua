local Embed = {}
Embed.__index = Embed
Embed.ClassName = "Embed"

--> Require all the utility functions needed for this module.
local _ScanParam = require(script.Parent.Parent.util.ScanParam)
local _ScanURL = require(script.Parent.Parent.util.ScanURL)
local _ToHex = require(script.Parent.Parent.util.ToHex)
local _TypeOf = require(script.Parent.Parent.util.TypeOf)

--> Create the module's "new" constructor.
function Embed.new(data)
	local self = {}
	self.__index = self
	
	self.rawdata = {}
	
	function self.addField(name, value, inline)
		_ScanParam({"name", name}, {"string"}, true, true, {1, 256})
		_ScanParam({"value", value}, {"string"}, true, true, {1, 1024})
		_ScanParam({"inline", inline}, {"boolean"}, false, true)
		
		if not (self.rawdata.fields) then
			self.rawdata.fields = {}
		end
		
		local field = {}
		
		field.name = name
		field.value = value
		field.inline = inline
		
		table.insert(self.rawdata.fields, field)
		
		return self
	end
	
	function self.addFields(...)
		local fields = {...}
		
		_ScanParam({"fields", fields[1]}, {"array", "table"}, true, true)
		
		if (_TypeOf(fields[1]) == "array") then
			fields = fields[1]
		end
		
		for _, field in next, fields do
			_ScanParam({"field", field}, {"table"}, false, true)
			self.addField(field.name, field.value, field.inline)
		end

		return self
	end
	
	function self.setAuthor(name, icon_url, url)
		_ScanParam({"name", name}, {"string"}, true, true, {1, 256})
		_ScanParam({"icon_url", icon_url}, {"string"}, false, true)
		_ScanParam({"url", url}, {"string"}, false, true)
		
		_ScanURL(icon_url)
		_ScanURL(url)
		
		local author = {}
		
		author.name = name
		author.icon_url = icon_url
		author.url = url
		
		self.rawdata.author = author
		
		return self
	end
	
	function self.setColor(color)
		_ScanParam({"color", color}, {"string", "number", "Color3"})
		
		if (_TypeOf(color) == "Color3") then
			local R, G, B = color.R, color.G, color.B
			color = _ToHex(R * 255, G * 255, B * 255)
		end
		
		if (_TypeOf(color) == "string" and string.sub(color, 1, 1) == "#") then
			color = string.gsub(color, "#", "0x")
		end
		
		self.rawdata.color = tonumber(color)
		
		return self
	end
	
	function self.setDescription(description)
		_ScanParam({"description", description}, {"string"}, true, true, {1, 2048})
		
		self.rawdata.description = description
		
		return self
	end
	
	function self.setFooter(text, icon_url)
		_ScanParam({"text", text}, {"string"}, true, true, {1, 2048})
		_ScanParam({"icon_url", icon_url}, {"string"}, false, true)
		
		_ScanURL(icon_url)
		
		local footer = {}
		
		footer.text = text
		footer.icon_url = icon_url
		
		self.rawdata.footer = footer
		
		return self
	end
	
	function self.setImage(url)
		_ScanParam({"url", url}, {"string"}, true, true)
		
		_ScanURL(url)
		
		self.rawdata.image = { url = url }
		
		return self
	end
	
	function self.setThumbnail(url)
		_ScanParam({"url", url}, {"string"}, true, true)
		
		_ScanURL(url)

		self.rawdata.image = { url = url }

		return self
	end
	
	function self.setTimestamp(timestamp)
		_ScanParam({"timestamp", timestamp}, {"number"}, false, true)
		
		timestamp = timestamp or os.time()
		
		local offset = os.date("%z", timestamp)
		local operator, value = string.match(offset, "(%p)(%d+)")
		
		offset = tonumber(operator .. (value / 100)) * 3600
		timestamp -= offset
		
		self.rawdata.timestamp = os.date("%Y-%m-%dT%H:%M:%SZ", timestamp)
		
		return self
	end
	
	function self.setTitle(title)
		_ScanParam({"title", title}, {"string"}, true, true, {1, 256})
		
		self.rawdata.title = title
		
		return self
	end
	
	function self.setURL(url)
		_ScanParam({"url", url}, {"string"}, true, true)
		
		_ScanURL(url)
		
		self.rawdata.url = url
		
		return self
	end
	
	return setmetatable(self, Embed)
end

Embed.__call = function(t, ...) return Embed.new(...) end

--> Return the module data as a metatable.
return setmetatable(Embed, Embed)
