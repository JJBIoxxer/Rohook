--[[
	[Name]: Discord API Module
	[Author]: JJBIoxxer
	[Created]: 02/08/2021
	[Last Updated]: 02/09/2021
--]]

-- Services
local HttpService = game:GetService("HttpService");

-- Variables
local Protocol = "^https?://";

-- Module
local Discord = {};

-- Local Functions
local function toHex(color3)
	assert(color3, "The parameter 'color3' is required.");
	assert(type(color3) == "table", "The parameter 'color3' must be a table value.");
	
	local hexidecimal = {};
	
	for _, integer in ipairs(color3) do
		local base = math.floor((integer * 255) / 16);
		local remainder = ((integer * 255) - (base * 16));
		
		table.insert(hexidecimal, string.format("%x%x", base, remainder));
	end
	
	return table.concat(hexidecimal, "");
end

-- Core Functions
function Discord.Webhook(url)
	local Webhook = {};
	
	function Webhook.send(message)
		assert(message, "The parameter 'message' is required.");
		assert(type(message) == "table" and message.Data, "The parameter 'message' must be a Discord Message value.");
		
		local success, response = pcall(HttpService.PostAsync, HttpService, url, HttpService:JSONEncode(message.Data));
		
		assert(success, response);
	end
	
	return Webhook;
end

function Discord.Message()
	local Message = {};
	Message.Data = {};
	
	local Data = Message.Data;
	
	function Message.addEmbed(embed)
		if not (Data.embeds) then
			Data.embeds = {};
		end
		
		assert(embed, "The parameter 'embed' is required.");
		assert(type(embed) == "table" and embed.Data, "The parameter 'embed' must be a Discord Embed value.");
		
		table.insert(Data.embeds, embed.Data);
	end
	
	function Message.addEmbeds(...)
		local Embeds = {...};
		
		assert(#Embeds >= 1, "The parameter 'embeds' is required.");
		assert(#Embeds <= 10, "The parameter 'embeds' cannot exceed 10 objects.");
		
		for _, Embed in next, Embeds do
			Message.addEmbed(Embed);
		end
	end
	
	function Message.setAvatarURL(url)
		assert(url, "The parameter 'url' is required.");
		assert(type(url) == "string", "The parameter 'url' must be a string value.");
		assert(string.match(url, Protocol), "The parameter 'url' must be a valid URL.");

		Data.avatar_url = tostring(url);
	end
	
	function Message.setContent(content)
		assert(content, "The parameter 'content' is required.");
		assert(type(content) == "string", "The parameter 'content' must be a string value.");
		
		Data.content = tostring(content);
	end
	
	function Message.setUsername(username)
		assert(username, "The parameter 'username' is required.");
		assert(type(username) == "string", "The parameter 'username' must be a string value.");

		Data.username = tostring(username);
	end
	
	return Message;
end

function Discord.Embed()
	local Embed = {};
	Embed.Data = {};
	
	local Data = Embed.Data;
	
	function Embed.addField(name, value, inline)
		if not (Data.fields) then
			Data.fields = {};
		end
		
		local Field = {};
		
		assert(name, "The parameter 'name' is required.");
		assert(value, "The parameter 'value' is required.");
		assert(type(name) == "string", "The parameter 'name' must be a string value.");
		assert(type(value) == "string", "The parameter 'value' must be a string value.");
		assert(string.len(name) <= 256, "The parameter 'name' cannot exceed 256 characters.");
		assert(string.len(value) <= 1024, "The parameter 'value' cannot exceed 1024 characters.");
		
		if (inline) then
			assert(type(inline) == "boolean", "The parameter 'inline' must be a boolean value.");
			Field.inline = inline;
		end
		
		Field.name = tostring(name);
		Field.value = tostring(value);
		
		table.insert(Data.fields, Field);
	end
	
	function Embed.addFields(...)
		local Fields = {...};
		
		assert(#Fields >= 1, "The parameter 'fields' is required.");
		assert(#Fields <= 25, "The parameter 'fields' cannot exceed 25 objects.");
		
		for _, Field in next, Fields do
			assert(type(Field) == "table", "The parameter 'field' must be a table value.");
			Embed.addField(unpack(Field));
		end
	end
	
	function Embed.setAuthor(name, iconURL, url)
		local Author = {};
		
		assert(name, "The parameter 'name' is required.");
		assert(type(name) == "string", "The parameter 'name' must be a string value.");
		assert(string.len(name) <= 256, "The parameter 'name' cannot exceed 256 characters.");
		
		if (iconURL) then
			assert(string.match(iconURL, Protocol), "The parameter 'iconURL' must be a valid URL.");
			Author.icon_url = tostring(iconURL);
		end
		
		if (url) then
			assert(string.match(url, Protocol), "The parameter 'url' must be a valid URL.");
			Author.url = tostring(url);
		end
		
		Author.name = tostring(name);
		
		Data.author = Author;
	end
	
	function Embed.setColor(color)
		assert(color, "The parameter 'color' is required.");
		assert(type(color) == "string" or type(color) == "number" or typeof(color) == "Color3", "The parameter 'color' must be a string, number, or Color3 value.");
		
		if (typeof(color) == "Color3") then
			color = ("0x" .. toHex{color.R, color.G, color.B});
		end
		print(color)
		Data.color = tostring(tonumber(color));
	end
	
	function Embed.setDescription(description)
		assert(description, "The parameter 'description' is required.");
		assert(type(description) == "string", "The parameter 'description' must be a string value.");
		assert(string.len(description) <= 2048, "The parameter 'description' cannot exceed 2048 characters.");
		
		Data.description = tostring(description);
	end
	
	function Embed.setFooter(text, iconURL)
		local Footer = {};
		
		assert(text, "The parameter 'text' is required.");
		assert(type(text) == "string", "The parameter 'text' must be a string value.");
		assert(string.len(text) <= 2048, "The parameter 'text' cannot exceed 2048 characters.");
		
		if (iconURL) then
			assert(string.match(iconURL, Protocol), "The parameter 'iconURL' must be a valid URL.");
			Footer.icon_url = tostring(iconURL);
		end
		
		Footer.text = tostring(text);
		
		Data.footer = Footer;
	end
	
	function Embed.setImage(url)
		assert(url, "The parameter 'url' is required.");
		assert(type(url) == "string", "The parameter 'url' must be a string value.");
		assert(string.match(url, Protocol), "The parameter 'url' must be a valid URL.");
		
		Data.image = {
			["url"] = tostring(url);
		};
	end
	
	function Embed.setThumbnail(url)
		assert(url, "The parameter 'url' is required.");
		assert(type(url) == "string", "The parameter 'url' must be a string value.");
		assert(string.match(url, Protocol), "The parameter 'url' must be a valid URL.");

		Data.thumbnail = {
			["url"] = tostring(url);
		};
	end
	
	function Embed.setTimestamp()
		Data.timestamp = os.date("%Y-%m-%dT%H:%M:%SZ", os.time());
	end
	
	function Embed.setTitle(title)
		assert(title, "The parameter 'title' is required.");
		assert(type(title) == "string", "The parameter 'title' must be a string value.");
		assert(string.len(title) <= 256, "The parameter 'title' cannot exceed 256 characters.");
		
		Data.title = tostring(title);
	end
	
	function Embed.setURL(url)
		assert(url, "The parameter 'url' is required.");
		assert(type(url) == "string", "The parameter 'url' must be a string value.");
		assert(string.match(url, Protocol), "The parameter 'url' must be a valid URL.");
		
		Data.url = tostring(url);
	end
	
	return Embed;
end

-- Return
return Discord;
