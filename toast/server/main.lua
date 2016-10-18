-- Server

local firstspawn = true
Users = {}
debugMode = false

--CoreEvents
RegisterServerEvent("onPlayerConnect")
RegisterServerEvent("chatCommandEntered")
RegisterServerEvent("baseevents:onPlayerKilled")
RegisterServerEvent("consoleLog122")

--Gameplay Events
RegisterServerEvent("giveMeWelfare")
RegisterServerEvent("killPedCount")

--Set Welfare Amount
local welfareCheck = 200
local debugMode = true


AddEventHandler('consoleLog122', function()
	print("testing")
end)

AddEventHandler('onPlayerConnect', function()	
	
	
	if(Users[GetPlayerName(source)] == nil)then
	-- loading
		if hasAccount(source) then
			print("User has account: "..GetPlayerName(source))
			Users[GetPlayerName(source)] = LoadUser(source)
			TriggerClientEvent("stateFreeze", source, true)
			TriggerClientEvent("stateInvisible", source, true)
			SendPlayerChatMessage(source, "?? Your account have been found on our database type ^1/login ^7[^2Your Password^7]")
		else
			TriggerClientEvent("stateFreeze", source, true)
			TriggerClientEvent("stateInvisibleInvisible", source, true)
			
			SendPlayerChatMessage(source, "?? Please ^1register^7 with this command ^1/register ^7[^2Your Password^7]")
		end
	end
	TriggerClientEvent("teleportSpawning", source)
end)

AddEventHandler('giveMeWelfare', function()
	if(hasAccount(source)) then
		if(isLoggedIn(source)) then
			Users[GetPlayerName(source)]['money'] = Users[GetPlayerName(source)]['money'] + welfareCheck
			saveMoney(source)
			TriggerClientEvent("clientPaid", source, welfareCheck)
		end
	end
end)
	
AddEventHandler('chatCommandEntered', function(fullcommand)
	command = stringsplit(fullcommand, " ")

	if not isLoggedIn(source) then
		if(command[1] == "/register") then
			if(command[2] ~= nil) then
				registerUser(command[2])
			else
				SendPlayerChatMessage(source, "USAGE: /register password", { 0, 0x99, 255})
			end
		elseif(command[1] == "/t")then
			TriggerClientEvent("getPosition", source)
		elseif(command[1] == "/login") then
			if(command[2] ~= nil) then
				loginUser(command[2])
			else
				SendPlayerChatMessage(source, "USAGE: /login password", { 0, 0x99, 255})
			end
		else
			if(hasAccount(source)) then
				SendPlayerChatMessage(source, "^1Please login first using: /login [password]", { 0, 0x99, 255})
			else
				SendPlayerChatMessage(source, "^1Please register first using: /register [password]", { 0, 0x99, 255})
			end
		end

		return
	else
		if (command[1] == "/pos") then	
			TriggerClientEvent("getPosition", source)
		end
	end
end)

AddEventHandler('baseevents:onPlayerKilled', function(killer, kilerT)
	if(GetPlayerName(killer) ~= nil and GetPlayerName(source) ~= nil)then
		Users[GetPlayerName(killer)]['kills'] = Users[GetPlayerName(killer)]['kills'] + 1
		Users[GetPlayerName(source)]['deaths'] = Users[GetPlayerName(killer)]['deaths'] + 1
		
		saveKD(source)
		saveKD(killer)
	end
end)

--Server Functions
function SendPlayerChatMessage(source, message, color)
	if(color == nil) then
		color = { 0, 0x99, 255}
	end
	TriggerClientEvent("chatMessage", source, '', color, message)
end

function stringsplit(self, delimiter)
  local a = self:Split(delimiter)
  local t = {}

  for i = 0, #a - 1 do
     table.insert(t, a[i])
  end

  return t
end