function f(n)
n = n + 0.00001
return n
end

--Text drawing function
local function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)    
end

local openMenu = true
local weaponMenu = false
	local buyWMenu = false
	local buyAMenu = false

local vehicleMenu = false
	local buyVMenu = false

	local sellVMenu = false
	local personalVMenu
		--claim
		--unclaim
local welfareMenu = false
local atmMenu = false
--Deposit
--Withdraw
--Balance
local customizeMenu = false
local mainMenu = True

local function count(input)
  if type(input)~='table' then 
   return nil
  end
  local int=0
  for k,v in pairs(input) do
   int=int+1
  end
  return int
end

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(0)
		if(openMenu)then                                       
			if(isControlJustReleased(1, 57))then
			--	openMenu = false
			--end
			TriggerClientEvent("chatMessage", '', {0,0,0}, "Testing")
			--Get Location
			local player = GetPlayerPed(-1)
			local playerLoc = GetEntityCoords(player, true)
			local message = ""
			message = Vdist(100,100,300, playerLoc['x'], playerLoc['y'], playerLoc['z'])
			TriggerClientEvent("chatMessage", '', {0,0,0}, message.tostring())
			TriggerServerEvent("debugLogs", '', message.tostring())
		
		
		--else
			--if(IsControlJustReleased(1,57))then
			--	openMenu = true
			--end
		end
	end
end)