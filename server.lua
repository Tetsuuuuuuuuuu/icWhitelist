----------------------------------------------------------------------------------
--									 IC Whitelist								--
--								  mady by Tetsu#9030							--
--										1.0.0 									--
----------------------------------------------------------------------------------

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function logAction(sourceXPlayer, targetXPlayer, newWLState)
	local sourceName = GetPlayerName(sourceXPlayer.source)
	local targetName = GetPlayerName(targetXPlayer.source)
	local embed

	if newWLState == true then
		if Config.language == "de" then
			embed =
			{
				{
					["color"] = "13777215",
					["thumbnail"] = {
						["url"] = Config.webhook_logo,
					},
					["title"] = "**Player whitelisted**",
					["description"] = targetName .. " got whitelisted by " .. sourceName .. "!",
					["fields"] = {
						{ ["name"] = 'Player ID: ', ["value"] = targetXPlayer.source, ["inline"] = false},
					},
					["footer"] = {
						["text"] = "IC Whitelist by Tetsu#9030",
					},
				}
			}
		else

		end
	else
		if Config.language == "de" then
			embed =
			{
				{
					["color"] = "13777215",
					["thumbnail"] = {
						["url"] = Config.webhook_logo,
					},
					["title"] = "**Spielerwhitelist entfernt**",
					["description"] = sourceName .. " hat die Whitelist von " .. targetName .. " entfernt!",
					["fields"] = {
						{ ["name"] = 'Spieler ID: ', ["value"] = targetXPlayer.source, ["inline"] = false},
					},
					["footer"] = {
						["text"] = "IC Whitelist by Tetsu#9030",
					},
				}
			}
		else
			embed =
			{
				{
					["color"] = "13777215",
					["thumbnail"] = {
						["url"] = Config.webhook_logo,
					},
					["title"] = "**Playerwhitelist removed**",
					["description"] = sourceName .. " has removed the Whitelist of " .. targetName .. "!",
					["fields"] = {
						{ ["name"] = 'Player ID: ', ["value"] = targetXPlayer.source, ["inline"] = false},
					},
					["footer"] = {
						["text"] = "IC Whitelist by Tetsu#9030",
					},
				}
			}
		end
	end

	PerformHttpRequest(Config.webhook_url, function(err, text, headers) end, 'POST', json.encode({username = "Whitelist by Tetsu#9030", embeds = embed}), { ['Content-Type'] = 'application/json' })
end

ESX.RegisterCommand('whitelist', Config.requiredGroup, function(xPlayer, args, showError)
	local target = args[1]
	local sourceXPlayer = ESX.GetPlayerFromId(source)

	if target == nil then
		sourceXPlayer.showNotification(Config.locales[Config.language]["missing_targetid"], false, false, 140)
		return
	else
		target = tonumber(target)
	end

	local targetXPlayer = ESX.GetPlayerFromId(target)

	if targetXPlayer == nil then
		sourceXPlayer.showNotification(Config.locales[Config.language]["targetplayernotonline"], false, false, 140)
		return
	end

	local identifier = targetXPlayer.getIdentifier()

	MySQL.Async.fetchAll('SELECT `neu` FROM users WHERE identifier = @identifier',
	{ ['@identifier'] = identifier },
	function(result)
		local curWLState = false

		if result then
			if result[1] then
				local wlState = result[1][ "neu" ]

				if wlState then
					curWLState = wlState == 1
				end
			end
		end

		curWLState = not curWLState

		MySQL.Async.execute("UPDATE `users` SET `neu` = @newstate WHERE identifier = @steamID", {
			["newstate"] = curWLState,
			["steamID"] = identifier,
	   	})

	   	if curWLState == true then
			sourceXPlayer.showNotification(Config.locales[Config.language]["whitelist_succesfull_source"], false, false, 140)
			targetXPlayer.showNotification(Config.locales[Config.language]["whitelist_succesfull_target"], false, false, 140)
			
	   	else
			sourceXPlayer.showNotification(Config.locales[Config.language]["removewhitelist_succesfull_source"], false, false, 140)
			targetXPlayer.showNotification(Config.locales[Config.language]["removewhitelist_succesfull_target"], false, false, 140)
	   	end

		if Config.useDiscordLogging == true then
			logAction(sourceXPlayer, targetXPlayer, curWLState)
		end

		TriggerClientEvent("icw:resultWLState", targetXPlayer.source, curWLState)
	end)
end, false, {help = Config.locales[Config.language]["commandhelp"]})


ESX.RegisterCommand('whitelistmode', Config.requiredGroup, function(xPlayer, args, showError)
	TriggerClientEvent("icw:toggleEinreiseMode", xPlayer.source)
end, false, {help = Config.locales[Config.language]["commandhelp2"]})

RegisterNetEvent("icw:requestWLState", function ()
	local player = source
	local xPlayer = ESX.GetPlayerFromId(player)

	if xPlayer ~= nil then
		local identifier = xPlayer.getIdentifier()

		MySQL.Async.fetchAll('SELECT `neu` FROM users WHERE identifier = @identifier',
		{ ['@identifier'] = identifier },
		function(result)
			local curWLState = false

			if result then
				if result[1] then
					local wlState = result[1][ "neu" ]

					if wlState then
						curWLState = wlState == 1
					end
				end
			end

			TriggerClientEvent("icw:resultWLState", player, curWLState)
		end)
	end
end)

RegisterNetEvent("icw:outOfValidRange", function ()
	if Config.useDiscordLogging == true then
		local player = source

		if Config.language == "de" then
			local embed =
			{
				{
					["color"] = "13777215",
					["thumbnail"] = {
						["url"] = Config.webhook_logo,
					},
					["title"] = "**Spieler hat sich zu weit vom Spawn entfernt**",
					["description"] = "Der Spieler: " .. GetPlayerName(player) .. " hat sich ohne Whitelist zu weit vom Spawn entfernt" ,
					["fields"] = {
						{ ["name"] = 'Spieler ID: ', ["value"] = player, ["inline"] = false},
					},
					["footer"] = {
						["text"] = "IC Whitelist by Tetsu#9030",
					},
				}
			}

			PerformHttpRequest(Config.webhook_url, function(err, text, headers) end, 'POST', json.encode({username = "Whitelist by Tetsu#9030", embeds = embed}), { ['Content-Type'] = 'application/json' })
		else
			local embed =
			{
				{
					["color"] = "13777215",
					["thumbnail"] = {
						["url"] = Config.webhook_logo,
					},
					["title"] = "**Player was too far from Spawn**",
					["description"] = GetPlayerName(player) .. " has moved too far from the Spawn without being Whitelisted",
					["fields"] = {
						{ ["name"] = 'Player ID: ', ["value"] = player, ["inline"] = false},
					},
					["footer"] = {
						["text"] = "IC Whitelist by Tetsu#9030",
					},
				}
			}

			PerformHttpRequest(Config.webhook_url, function(err, text, headers) end, 'POST', json.encode({username = "Whitelist by Tetsu#9030", embeds = embed}), { ['Content-Type'] = 'application/json' })
		end
	end
end)