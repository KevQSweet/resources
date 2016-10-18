AddEventHandler('onClientMapStart', function()
	Citizen.Trace("ocms fivem\n")

    exports.spawnmanager:setAutoSpawn(true)
    exports.spawnmanager:forceRespawn()
    SetClockTime(24, 0, 0)
    PauseClock(true)
    Citizen.Trace("ocms fivem end\n")
end)
--[[
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(50)

		local playerPed = GetPlayerPed(-1)

		if playerPed and playerPed ~= -1 then
			if IsControlPressed(2, 10) then
				local playerCoords = GetEntityCoords(playerPed)
				local playerHeading = GetEntityHeading(playerPed)
				TriggerServerEvent('savePos', playerCoords.x .. ', ' .. playerCoords.y .. ', ' .. playerCoords.z .. ', ' .. playerHeading)
				Citizen.Wait(1000)
			end
		end
	end
end)]]