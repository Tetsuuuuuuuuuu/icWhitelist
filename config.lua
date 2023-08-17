Config = {}

Config.allowedDistance = 100.0 -- The distance the player can go away from the spawn position
Config.enableInvincibility = false -- If true, the player will be invincible while in whitelist mode
Config.spawn = vector3(-1037.768, -2737.674, 20.16927) -- The position where the player will be teleported to when he activates the whitelist mode
Config.dutySkin = { -- The Skin admins wear when in whitelist mode
	tshirt_1    = 0,
	tshirt_2    = 0,
	torso_1     = 0,
	torso_2     = 0,
	decals_1    = 0,
	decals_2    = 0,
	arms        = 0,
	pants_1     = 0,
	pants_2     = 0,
	shoes_1     = 0,
	shoes_2     = 0,
	mask_1      = 0,
	mask_2      = 0,
	bproof_1    = 0,
	bproof_2    = 0,
	chain_1     = 0,
	chain_2     = 0,
	helmet_1    = 0,
	helmet_2    = 0,
	glasses_1   = 0,
	glasses_2   = 0,
}

Config.requiredGroup = "moderator" -- The group that is required to use the whitelist mode

Config.useDiscordLogging = false -- If true, the script will log the actions to a discord webhook
Config.webhook_url = "" -- Put in Your Discord Webhook URL here
Config.webhook_logo = "" -- Put in a URL to your Logo here

Config.language = "de" -- The language of the script

Config.locales = {
    ["de"] = {
        ["missing_targetid"] = "Du musst eine Spieler ID angeben",
        ["targetplayernotonline"] = "Der Spieler ist nicht Online",
        ["whitelist_succesfull_source"] = "Spieler erfolgreich eingereist!",
        ["whitelist_succesfull_target"] = "Du wurdest eingereist!",
        ["removewhitelist_succesfull_source"] = "Spieler erfolgreich eingereist!",
        ["removewhitelist_succesfull_target"] = "Du wurdest eingereist!",
        ["commandhelp"] = "Einen Spieler einreisen oder ausreisen",
        ["commandhelp2"] = "Einreisemodus aktivieren oder deaktivieren",
    },
    ["en"] = {
        ["missing_targetid"] = "You have to specify a player ID",
        ["targetplayernotonline"] = "The player is not online",
        ["whitelist_succesfull_source"] = "Player successfully whitelisted!",
        ["whitelist_succesfull_target"] = "You got whitelisted!",
        ["removewhitelist_succesfull_source"] = "The players whitelist was removed!",
        ["removewhitelist_succesfull_target"] = "Your whitelist was removed!",
        ["commandhelp"] = "Whitelist or remove the Whitelist of a player",
        ["commandhelp2"] = "Activate or deactivate whitelist admin mode",
    }
}