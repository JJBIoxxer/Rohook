# Roblox-Discord-API
An easy way to create and send messages through Discord webhooks on Roblox.

Classes
=======
All of the available classes are listed in this section.
### Embed
```lua
local Embed = Discord.Embed();
```
#### .addField(name, value, [inline])
| Parameter | Type    | Optional | Default |
| :-------: | :-----: | :------: | :-----: |
| name      | String  |          |         |
| value     | String  |          |         |
| inline    | Boolean | ✓        | false   |
```lua
Embed.setField("Name", "Value");
Embed.setField("Name", "Value", true);
```

#### .addFields(...fields)
| Parameter | Type    | Optional | Default |
| :-------: | :-----: | :------: | :-----: |
| fields    | Array   |          |         |
