local chatInputActive = false
local chatInputActivating = false

RegisterNetEvent('chatMessage')

AddEventHandler('chatMessage', function(name, color, message, range)
    SendNUIMessage({
        name = name,
        color = color,
        message = message,
        range = range,
    })
end)

RegisterNUICallback('chatResult', function(data, cb)
    chatInputActive = false

    SetNuiFocus(false)

    if data.message then
        local id = PlayerId()

        --local r, g, b = GetPlayerRgbColour(id, _i, _i, _i)
        local r, g, b = 0, 0x99, 255
        
        local range = Vdist()
        
        local player = GetPlayerPed(-1)
        local playerLoc = GetEntityCoords(player, true)
            Vdist(100, 100, 300, playerLoc['x'], playerLoc['y'], playerLoc['z'])

        TriggerServerEvent('chatMessageEntered', GetPlayerName(id), { r, g, b }, data.message, range)

    cb('ok')
end)

Citizen.CreateThread(function()
    SetTextChatEnabled(false)

    while true do
        Wait(0)

        if not chatInputActive then
            if IsControlPressed(0, 245) --[[ INPUT_MP_TEXT_CHAT_LOCAL ]] then
                chatInputActive = true
                chatInputActivating = true

                SendNUIMessage({
                    meta = 'openChatBox'
                })
            end
        end

        if chatInputActivating then
            if not IsControlPressed(0, 245) then
                SetNuiFocus(true)

                chatInputActivating = false
            end
        end
    end
end)
