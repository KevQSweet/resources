myPlayer = {}
myPlayer.money = 0

function f(n)
n = n + 0.00001
return n
end

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
	SetEntityCoords()
end

RegisterNetEvent("clientPlayerData")
AddEventHandler("clientPlayerData", function(cash)
	myPlayer.money = cash
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(myPlayer.money ~= nil and myPlayer.money == 0)then
			local x = 0.5
			local y = 0.4
			x = f(x)
			y = f(y)
				
			drawTxt(0.45,0.02,0,0,0.75,"Welcome",255,255,255,255)
			DrawRect(x,y,0.5,0.5,0,200,100,200)
			
			drawTxt(0.42,0.18,0,0,0.40,"To login type /login [password]",255,255,255,255)
			drawTxt(0.32,0.22,0,0,0.40,"If you don't have an account you can type /register [password]",255,255,255,255)
			
			drawTxt(0.45,0.35,0,0,0.65,"Information",255,255,255,255)
			drawTxt(0.37,0.40,0,0,0.40,"You can Collect $200 every 5 minutes",255,255,255,255)
			drawTxt(0.39,0.44,0,0,0.40,"at the Welfare Center.",255,255,255,255)
			drawTxt(0.361,0.48,0,0,0.40,"",255,255,255,255)
			drawTxt(0.26,0.6,0,0,0.40,"",255,255,255,255)
		else
			local x = 0.95
			local y = 0.05
			x = f(x)
			y = f(y)
			
			local balance = myPlayer.money
			DrawRect(x,y,0.0375,0.0075)
			drawTxt(x + 0.005,y,0.2,0.035,0.35, "Balance: "..(balance),255,255,255,255)
		end
	end
end)

RegisterNetEvent("createTimer")
AddEventHandler("createTimer", function()
	Citizen.CreateThread(function()
		local welfareReady = false
		while not (welfareReady) do
			Citizen.wait(300000)
			local x = 0.95
			local y = 0.05
			x = f(x)
			y = f(y)
			DrawRect(x,y + 0.1,0.0375,0.0075)
			drawTxt(x + 0.005,y + 0.105,0.2,0.035,0.35, "Welfare Check is Ready.",255,255,255,255)			
			welfareReady = true
			
		end
	end)
end)