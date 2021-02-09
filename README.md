# Roblox Discord API

An easy way to create and send messages through Discord webhooks on Roblox.

<div>&nbsp;</div>

## Documentation

To start using, copy the AssetID of the official [model](https://www.roblox.com/library/6368393169/MainModule) and require the module.

```lua
local Discord = require(6368393169);
```

<div>&nbsp;</div>

### Embed

Use the embed constructor to create and customize a new Discord embedded message.

```lua
local Embed = Discord.Embed();
```

#### .addField(name, value, [inline])

> Adds a field to the embed (max 25).
> 
> | Parameter | Type                                        | Optional | Default | Description                            |
> | :-------: | :-----------------------------------------: | :------: | :-----: | :------------------------------------: |
> | name      | [string](https://www.lua.org/pil/2.4.html)  |          |         | The name of the field                  |
> | value     | [string](https://www.lua.org/pil/2.4.html)  |          |         | The value of the field                 |
> | inline    | [boolean](https://www.lua.org/pil/2.2.html) | ✓        | false   | If this field will be displayed inline |

```lua
Embed.setField("Name", "Value", true);
```

#### .addFields(...fields)

> Adds fields to embed (max 25).
>
> | Parameter | Type                                          | Description       |
> | :-------: | :-------------------------------------------: | :---------------: |
> | fields    | ...[array](https://www.lua.org/pil/11.1.html) | The fields to add |

```lua
Embed.addFields(
  {"Name", "Value"},
  {"Name", "Value", true}
);
```

#### .setAuthor(name, [iconURL], [url])

> Sets the author of this embed.
>
> | Parameter | Type                                       | Optional | Default | Description                |
> | :-------: | :----------------------------------------: | :------: | :-----: | :------------------------: |
> | name      | [string](https://www.lua.org/pil/2.4.html) |          |         | The name of the author     |
> | iconURL   | [string](https://www.lua.org/pil/2.4.html) | ✓        | nil     | The icon URL of the author |
> | url       | [string](https://www.lua.org/pil/2.4.html) | ✓        | nil     | The URL of the author      |

```lua
Embed.setAuthor("Name", "https://i.imgur.com/iXcBOJ5.png", "https://developer.roblox.com/");
```

#### .setColor(color)

> Sets the author of this embed.
>
> | Parameter | Type                                                                                                                                                                   | Description                |
> | :-------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :------------------------: |
> | color     | [string](https://www.lua.org/pil/2.4.html) or [number](https://www.lua.org/pil/2.3.html) or [Color3](https://developer.roblox.com/en-us/api-reference/datatype/Color3) | The color of the embed     |

```lua
Embed.setColor("0xffc83c");
```

#### .setDescription(description)

> Sets the description of this embed.
>
> | Parameter   | Type                                       | Description     |
> | :---------: | :----------------------------------------: | :-------------: |
> | description | [string](https://www.lua.org/pil/2.4.html) | The description |

```lua
Embed.setDescription("Description");
```

#### .setFooter(text, [iconURL])

> Sets the footer of this embed.
>
> | Parameter   | Type                                       | Optional | Default | Description                |
> | :---------: | :----------------------------------------: | :------: | :-----: | :------------------------: |
> | text        | [string](https://www.lua.org/pil/2.4.html) |          |         | The text of the footer     |
> | iconURL     | [string](https://www.lua.org/pil/2.4.html) | ✓        | nil     | The icon URL of the footer |

```lua
Embed.setFooter("Text", "https://i.imgur.com/iXcBOJ5.png");
```

#### .setImage(url)

> Sets the image of the embed.
>
> | Parameter | Type                                       | Description          |
> | :-------: | :----------------------------------------: | :------------------: |
> | url       | [string](https://www.lua.org/pil/2.4.html) | The URL of the image |

```lua
Embed.setImage("https://i.imgur.com/iXcBOJ5.png");
```

#### .setThumbnail(url)

> Sets the thumbnail of the embed.
>
> | Parameter | Type                                       | Description          |
> | :-------: | :----------------------------------------: | :------------------: |
> | url       | [string](https://www.lua.org/pil/2.4.html) | The URL of the image | 

```lua
Embed.setThumbnail("https://i.imgur.com/iXcBOJ5.png");
```

#### .setTimestamp()

> Sets the timestamp of the embed.

```lua
Embed.setTimestamp();
```

#### .setTitle(title)

> Sets the title of the embed.
>
> | Parameter | Type                                       | Description |
> | :-------: | :----------------------------------------: | :---------: |
> | title     | [string](https://www.lua.org/pil/2.4.html) | The title   |

```lua
Embed.setTitle("Title");
```

#### .setURL(url)

> Sets the title of the embed.
>
> | Parameter | Type                                       | Description |
> | :-------: | :----------------------------------------: | :---------: |
> | url       | [string](https://www.lua.org/pil/2.4.html) | The URL     |

```lua
Embed.setURL("https://developer.roblox.com/");
```

<div>&nbsp;</div>

### Message

Use the message constructor to create and customize a new Discord message.

```lua
local Message = Discord.Message();
```

#### .addEmbed(embed)

> Adds an embed to the message (max 10).
>
> | Parameter | Type            |
> | :-------: | :-------------: |
> | embed     | [Embed](Embed) |
























