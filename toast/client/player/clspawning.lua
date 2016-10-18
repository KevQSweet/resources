RegisterNetEvent("spawnWeaponForPlayer")
RegisterNetEvent("teleportSpawning")
RegisterNetEvent("getPosition")


-- Spawn stuff
SpawnPositions = (-1040, -2710, 0)

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

AddEventHandler("teleportSpawning", function()
	Citizen.CreateThread(function()
		Citizen.Wait(500)
		local playerPed = GetPlayerPed(-1)
		local spawnPos = SpawnPositions
		SetEntityCoords(playerPed, -1040, -2710, 20)
	end)
end)

AddEventHandler('spawnWeaponForPlayer', function(weapon)
	Citizen.CreateThread(function()
        Citizen.Wait(50)
        local weaponid = GetHashKey(weapon)
        local playerPed = GetPlayerPed(-1)
        if playerPed and playerPed ~= -1 then
			TriggerEvent('chatMessage', 'SYSTEM', {0, 255, 0}, "🔫 Weapon spawned for: ^2💲400")
			GiveWeaponToPed(playerPed, weaponid, 500, true, true)			
        end
    end)
end)

AddEventHandler("getPosition", function(message)
	local playerPed = GetPlayerPed(-1)
	local teleportPed = GetEntityCoords(playerPed) 
	TriggerEvent('chatMessage', 'SYSTEM', {0, 255, 0}, ":"..teleportPed)
end)