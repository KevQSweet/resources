RegisterNetEvent("SetVehicleFixed")
AddEventHandler('SetVehicleFixed', function(message)
    Citizen.CreateThread(function() -- Created a new thread
    Citizen.Wait(50) -- A wait function for 50 miliseconds.
    local playerPed = GetPlayerPed(-1) -- Gets the player that ran the command.
        if playerPed and playerPed ~= -1 then -- Checks if the player exists
            local car = GetVehiclePedIsIn(playerPed,false)
            SetVehicleEngineHealth(car, 1000)
            TriggerEvent('chatMessage', 'VehicleRepair:', {0, 255, 0}, "Vehicle fixed.")
        elseif IsPedOnFoot(GetPlayerPed(-1)) then
            TriggerEvent('chatMessage', 'VehicleRepair:', {255, 0, 0}, "You are not in a car!")
            end
        end
    end)
end)
