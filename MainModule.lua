--[[
	This module was made to help make creating and sending messages using Discord webhooks easier.
	
	[Version]: V0.2.0.BETA
	
	[Author]: https://www.roblox.com/users/243014315/profile
	
	[Created]: Monday, February 8th, 2021 @ 2:39 PM (Pacific Standard Time)
	[Updated]: Saturday, February 13th, 2021 @ 9:41 AM (Pacific Standard Time)
	
	[Documentation]: https://github.com/JJBIoxxer/Roblox-Discord-API
	[Tutorial]: https://www.youtube.com/watch?v=9hJuv3kwYQk&ab_channel=Chaos
	
	If you have any questions, suggestions, or bug reports, feel free to send me a message on Roblox and I'll get back to you as soon as possible.
	
	Happy scripting!
--]]

-- Services
local HttpService = game:GetService("HttpService");

-- Variables
local protocol = "^https?://";
local webhookURL = "discordapp.com/api/webhooks/*%d+/*.+";

-- Module
local Discord = {};

-- Functions

-- Utilities
local Utilities = {};
Utilities.Http = {};

function Utilities.toHex(color)
	assert(color, "Parameter 'color' is required.");
	assert(typeof(color) == "Color3", "Parameter 'color' must be a Color3 value.");

	local multiplier = 255;
	local RGB = {(color.R * multiplier), (color.G * multiplier), (color.B * multiplier)};

	local hexidecimal = {};

	for _, integer in next, RGB do
		local base = math.floor(integer / 16);
		local remainder = (integer - (base * 16));

		table.insert(hexidecimal, string.format("%x%x", base, remainder));
	end

	return table.concat(hexidecimal, "");
end

-- Constructors
function Discord.Embed()
	local Embed = {};
	Embed.Data = {};

	local Data = Embed.Data;

	function Embed.addField(name, value, inline)
		assert(name, "The parameter 'name' is required.");
		assert(value, "The parameter 'value' is required.");
		assert(type(name) == "string", "The parameter 'name' must be a string value.");
		assert(type(value) == "string", "The parameter 'value' must be a string value.");
		assert(string.len(name) <= 256, "The field name cannot exceed 256 characters.");
		assert(string.len(value) <= 1024, "The field value cannot exceed 1024 characters.");

		if not (Data.fields) then
			Data.fields = {};
		end

		local Field = {};

		Field.name = tostring(name);
		Field.value = tostring(value);

		if (inline) then
			assert(type(inline) == "boolean", "The parameter 'inline' must be a boolean value.");
			Field.inline = inline;
		end

		assert(#Data.fields < 25, "You cannot add more than 25 fields to an Embed.");

		table.insert(Data.fields, Field);
	end

	function Embed.addFields(...)
		local Fields = {...};

		assert(#Fields >= 1, "You must provide at least 1 field.");

		for _, Field in next, Fields do
			assert(type(Field) == "table", "The parameter 'Field' must be a table value.");
			Embed.addField(unpack(Field));
		end
	end

	function Embed.setAuthor(name, iconURL, url)
		assert(name, "The parameter 'name' is required.");
		assert(type(name) == "string", "The parameter 'name' must be a string value.");
		assert(string.len(name) <= 256, "The author name cannot exceed 256 characters.");

		local Author = {};

		Author.name = tostring(name);

		if (iconURL) then
			assert(string.match(iconURL, protocol), "You must provide a valid URL.");
			Author.icon_url = tostring(iconURL);
		end

		if (url) then
			assert(string.match(url, protocol), "You must provide a valid URL.");
			Author.url = tostring(url);
		end

		Data.author = Author;
	end

	function Embed.setColor(color)
		assert(color, "The parameter 'color' is required.");
		assert(type(color) == "string" or type(color) == "number" or typeof(color) == "Color3", "The parameter 'color' must be a string, number, or Color3 value.");

		if (typeof(color) == "Color3") then
			color = ("0x" .. Utilities.toHex(color));
		end

		Data.color = tostring(tonumber(color));
	end

	function Embed.setDescription(description)
		assert(description, "The parameter 'description' is required.");
		assert(type(description) == "string", "The parameter 'description' must be a string value.");
		assert(string.len(description) <= 2048, "The description cannot exceed 2048 characters.");

		Data.description = tostring(description);
	end

	function Embed.setFooter(text, iconURL)
		assert(text, "The parameter 'text' is required.");
		assert(type(text) == "string", "The parameter 'text' must be a string value.");
		assert(string.len(text) <= 2048, "The footer text cannot exceed 2048 characters.");

		local Footer = {};

		Footer.text = tostring(text);

		if (iconURL) then
			assert(string.match(iconURL, protocol), "You must provide a valid URL.");
			Footer.icon_url = tostring(iconURL);
		end

		Data.footer = Footer;
	end

	function Embed.setImage(url)
		assert(url, "The parameter 'url' is required.");
		assert(type(url) == "string", "The parameter 'url' must be a string value.");
		assert(string.match(url, protocol), "You must provide a valid URL.");

		Data.image = {
			["url"] = tostring(url);	
		};
	end

	function Embed.setThumbnail(url)
		assert(url, "The parameter 'url' is required.");
		assert(type(url) == "string", "The parameter 'url' must be a string value.");
		assert(string.match(url, protocol), "You must provide a valid URL.");

		Data.thumbnail = {
			["url"] = tostring(url);	
		};
	end

	function Embed.setTimestamp(timestamp)
		timestamp = timestamp or os.time();

		assert(type(timestamp) == "number", "The parameter 'timestamp' must be a number value.");

		local offset = os.date("%z", timestamp);
		local operator, value = string.match(offset, "(%p)(%d+)");

		offset = (tonumber(operator .. value / 100) * 3600);
		timestamp = (timestamp - offset);

		Data.timestamp = os.date("%Y-%m-%dT%H:%M:%SZ", timestamp);
	end

	function Embed.setTitle(title)
		assert(title, "The parameter 'title' is required.");
		assert(type(title) == "string", "The parameter 'title' must be a string value.");
		assert(string.len(title) <= 256, "The title cannot exceed 256 characters.");

		Data.title = tostring(title);
	end

	function Embed.setURL(url)
		assert(url, "The parameter 'url' is required.");
		assert(type(url) == "string", "The parameter 'url' must be a string value.");
		assert(string.match(url, protocol), "You must provide a valid URL.");

		Data.url = tostring(url);
	end

	return Embed;
end

function Discord.Message()
	local Message = {};
	Message.Data = {};

	local Data = Message.Data;

	function Message.addEmbed(embed)
		assert(embed, "The parameter 'embed' is required.");
		assert(type(embed) == "table" and embed.Data, "The parameter 'embed' must be an Embed value");

		if not (Data.embeds) then
			Data.embeds = {};
		end

		table.insert(Data.embeds, embed.Data);
	end

	function Message.addEmbeds(...)
		local Embeds = {...};

		assert(#Embeds >= 1, "You must provide at least 1 Embed.");

		for _, Embed in next, Embeds do
			assert(type(Embed) == "table", "The parameter 'Embed' must be a table value.");
			Message.addEmbed(Embed);
		end
	end

	function Message.setAvatar(url)
		assert(url, "The parameter 'url' is required.");
		assert(type(url) == "string", "The parameter 'url' must be a string value.");
		assert(string.match(url, protocol), "You must provide a valid URL.");

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

function Discord.Webhook(url)
	local Webhook = {};

	assert(url, "You must provide a Webhook URL.");
	assert(type(url) == "string", "The parameter 'url' must be a string value.");


	local status, response = pcall(HttpService.GetAsync, HttpService, "https://www.google.com/");

	assert(status, "Http Requests must be enabled in the game settings.");

	local isWebhookURL = string.find(url, protocol .. webhookURL);
	status, response = pcall(HttpService.GetAsync, HttpService, url);

	assert(isWebhookURL and status, "You need to provide a valid Discord Webhook URL.");

	function Webhook.send(message)
		assert(message, "You must provide a Message object.");
		assert(type(message) == "table" and message.Data, "The parameter 'message' must be a Message value.");

		local Data = HttpService:JSONEncode(message.Data);

		local status, response = pcall(HttpService.PostAsync, HttpService, url, Data);

		assert(status, response);
	end

	return Webhook;
end

-- Return
return Discord;
