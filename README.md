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

Adds a field to the embed (max 25).

| Parameter | Type    | Optional | Default |
| :-------: | :-----: | :------: | :-----: |
| name      | String  |          |         |
| value     | String  |          |         |
| inline    | Boolean | ✓        | false   |

```lua
Embed.setField("Name", "Value", true);
```
