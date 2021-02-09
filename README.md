<h1 align="center">Roblox Discord API</h1>

<div align="center">
  An easy way to create and send messages through Discord webhooks on Roblox.
</div>

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
> | Parameter | Type         | Optional | Default | Description                            |
> | :-------: | :----------: | :------: | :-----: | :------------------------------------: |
> | name      | [string][1]  |          |         | The name of the field                  |
> | value     | [string][1]  |          |         | The value of the field                 |
> | inline    | [boolean][3] | ✓        | false   | If this field will be displayed inline |

```lua
Embed.setField("Name", "Value", true);
```

#### .addFields(...fields)

> Adds fields to embed (max 25).
>
> | Parameter | Type          | Description       |
> | :-------: | :-----------: | :---------------: |
> | fields    | ...[array][4] | The fields to add |

```lua
Embed.addFields(
  {"Name", "Value"},
  {"Name", "Value", true}
);
```

#### .setAuthor(name, [iconURL], [url])

> Sets the author of this embed.
>
> | Parameter | Type        | Optional | Default | Description                |
> | :-------: | :---------: | :------: | :-----: | :------------------------: |
> | name      | [string][1] |          |         | The name of the author     |
> | iconURL   | [string][1] | ✓        | nil     | The icon URL of the author |
> | url       | [string][1] | ✓        | nil     | The URL of the author      |

```lua
Embed.setAuthor("Name", "https://i.imgur.com/iXcBOJ5.png", "https://developer.roblox.com/");
```

#### .setColor(color)

> Sets the author of this embed.
>
> | Parameter | Type                                      | Description                |
> | :-------: | :---------------------------------------: | :------------------------: |
> | color     | [string][1] or [number][2] or [Color3][5] | The color of the embed     |

```lua
Embed.setColor("0xffc83c");
```



<!--- Link References -->
[1]: https://www.lua.org/pil/2.4.html <!--- String -->
[2]: https://www.lua.org/pil/2.3.html <!--- Number -->
[3]: https://www.lua.org/pil/2.2.html <!--- Boolean -->
[4]: https://www.lua.org/pil/11.1.html <!--- Array -->
[5]: https://developer.roblox.com/en-us/api-reference/datatype/Color3 <!--- Color3 -->
