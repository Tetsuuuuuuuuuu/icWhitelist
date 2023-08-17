----------------------------------------------------------------------------------
--									IC Whitelist								--
--								 mady by Tetsu#9030								--
--									   1.0.0									--
----------------------------------------------------------------------------------

local currentState, drawNames, lastPosition, lastSkin, currentWLState = false, false, nil, nil, nil -- internal, do not touch


local function drawText_(coords, text)
	local isOnScreen, screenX, screenY = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z)
	if isOnScreen then
		SetTextScale(1)
		SetTextFont(0)
		SetTextProportional(true)
		SetTextOutline()
		SetTextColour(255, 255, 255, 255)
		SetTextEntry("STRING")
		SetTextCentre(true)
		AddTextComponentString(text)
		DrawText(screenX,screenY)
	end
end


RegisterNetEvent("icw:toggleEinreiseMode", function ()
	local ped, spawn = PlayerPedId(), Config.spawn

	if currentState == false then
		currentState = true

		TriggerEvent('skinchanger:getSkin', function(skin)
			lastSkin = skin
			lastPosition = GetEntityCoords(ped)

			SetEntityCoords(ped, spawn.x, spawn.y, spawn.z, false, false, false, false)

			Config.dutySkin["sex"] = lastSkin["sex"]
					
			TriggerEvent('skinchanger:loadSkin', Config.dutySkin)

			if Config.enableInvincibility then
				SetEntityInvincible(ped, true)
			end

			drawNames = true
		end)
	else
		currentState = false

		if lastSkin ~= nil then
			TriggerEvent('skinchanger:loadSkin', lastSkin)
		else
			print("ERROR, the last Skin was not saved!")
		end
		lastSkin = nil

		SetEntityCoords(ped, lastPosition.x, lastPosition.y, lastPosition.z, false, false, false, false)

		if Config.enableInvincibility then
			SetEntityInvincible(ped, false)
		end

		drawNames = false
	end
end)

AddEventHandler('esx:playerLoaded',function(xPlayer, isNew, skin)
	local myId, ped = xPlayer.source, PlayerPedId()

	CreateThread(function()
		while true do
			Wait(0)
			
			ped = PlayerPedId()

			if drawNames then
				for _, playerId in ipairs(GetPlayers()) do
					if playerId ~= myId then
						local name = GetPlayerName(playerId)
						local myCoords = GetEntityCoords(ped)
						local targetCoords = GetEntityCoords(GetPlayerPed(playerId))
						local dist = #(myCoords - targetCoords)
						targetCoords.z = targetCoords.z + 1.2

						if dist < 50 then
							drawText_(targetCoords, name)
						end
					end
				end
			else
				Wait(1000)
			end
		end
	end)
end)

RegisterNetEvent("icw:resultWLState", function (wlState)
	currentWLState = wlState
end)

CreateThread(function ()
	local dist, spawn = nil, Config.spawn

	while currentWLState == nil do
		Wait(1000)
	end

	while true do
		if currentWLState == true then
			dist = #(spawn - GetGameplayCamCoord())

			if dist > Config.allowedDistance then
				TriggerServerEvent("icw:outOfValidRange")
				SetEntityCoords(PlayerPedId(), spawn.x, spawn.y, spawn.z, true, false, false, false)
			end

			Wait(5000)
		else
			Wait(5000)
		end

		Wait(0)
	end
end)
