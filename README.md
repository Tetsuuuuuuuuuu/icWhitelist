# icWhitelist
 Simple IC Whitelist for ESX Legacy

Supports:
- German & English
- Teleports Players back when they get too far from Spawn without Whitelist
- Discord Logging
- Admins can enter the whitelist mode, where they will get a configurable Outfit equipped and can see player names, if configured so they also will get invincible


How to use:
- Add Column "neu" to the table users in your database, datatype is a tinyint and default should be '0'
- Configure the config.lua with your values
- To enter the whitelist mode use the command /whitelistmode
- To toggle the Whitelist Status of a player use /whitelist playerid

For Support please open a issues or contact me on Discord (Tetsu#9030)
