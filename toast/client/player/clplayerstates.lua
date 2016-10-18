RegisterNetEvent("stateFreeze")
RegisterNetEvent("stateInvisible")
RegisterNetEvent("stateGod")
RegisterNetEvent("stateSetWanted")





AddEventHandler('stateFreeze', function(freeze)
	Citizen.CreateThread(function()
		Citizen.Wait(500)
		local ped = GetPlayerPed(-1)
		
		if not freeze then
			FreezeEntityPosition(ped, false)
			SetPlayerControl(ped, true, true)
		else
			FreezeEntityPosition(ped, true)
			SetPlayerControl(ped, false, false)
			if not IsPedFatallyInjured(ped) then
				ClearPedTasksImmediately(ped)
			end
		end
    end)
end)	

AddEventHandler('stateGod', function(godmode)
    Citizen.CreateThread(function()
		Citizen.Wait(500)
		local ped = GetPlayerPed(-1)

		if not godmode then
			SetEntityInvincible(GetPlayerPed(-1), false)
		else
			SetEntityInvincible(GetPlayerPed(-1), true)
		end
    end)
end)

AddEventHandler('stateInvisible', function(invisible)
    Citizen.CreateThread(function()
		Citizen.Wait(500)
		local ped = GetPlayerPed(-1)

		if not invisible then
			if not IsEntityVisible(ped) then
				SetEntityVisible(ped, true)
			end

			if not IsPedInAnyVehicle(ped) then
				SetEntityCollision(ped, true)
			end
			
			--SetCharNeverTargetted(ped, false)
			SetPlayerInvincible(player, false)
		else
			if IsEntityVisible(ped) then
				SetEntityVisible(ped, false)
			end

			SetEntityCollision(ped, false)
			--SetCharNeverTargetted(ped, true)
			SetPlayerInvincible(player, true)
			--RemovePtfxFromPed(ped)

			if not IsPedFatallyInjured(ped) then
				ClearPedTasksImmediately(ped)
			end
		end
    end)
end)

AddEventHandler('stateSetWanted', function(level)
	SetPlayerWantedLevel(PlayerId(), level, false)
	SetPlayerWantedLevelNow(PlayerId(), false)
end)

local gmPlayerJoined = 0

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

local PlayerSkins = {0x15F8700D,0x028ABF95,0x52580019,0xEDBC7546,0xDE0077FD,0x56C96FC6,0xE497BBEF,0x65793043,0x0D7114C9}

AddEventHandler('playerSpawned', function(spawn)
	Citizen.CreateThread(function()
		Citizen.Wait(500)
		TriggerServerEvent("onPlayerConnect")
	end)
	
	Citizen.CreateThread(function()
		Citizen.Wait(50)
		local modelID = 0x705E61F2
		local torsoSkin = math.random(1, #PlayerSkins)
		if(torsoSkin ~= nil)then
			modelID = PlayerSkins[torsoSkin]
		end
		
		RequestModel(modelID)
		while not HasModelLoaded(modelID) do
			Citizen.Wait(0)
        end
		
		SetPlayerModel(PlayerId(), modelID)
		SetPedDefaultComponentVariation(GetPlayerPed(-1))
	end)

	if gmPlayerJoined == 1 then
		ShowNotification('Welcome to ~r~ FiveReborn Freeroam ~b~' .. GetPlayerName(player) .. '~w~, enjoy your time!')
		gmPlayerJoined = 2
		
	else
		
	
		ShowNotification('~r~You died')
	end
end)

AddEventHandler('onPlayerJoining', function(netId, name)
	if gmPlayerJoined == 0 then
		gmPlayerJoined = 1
	end
end)
