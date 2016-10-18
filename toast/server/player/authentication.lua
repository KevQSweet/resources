-- Loading MySQL Class
require "resources/toast/lib/MySQL"

-- MySQL:open("IP", "databasname", "user", "password")
MySQL:open("127.0.0.1", "new_schema", "QSweet", "Forgetmenot!1992")
local json = require( "json" ) 
local scriptName = "authentication"




function LoadUser(source)
	local username = GetPlayerName(source)
	local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE username = '@name'", {['@name'] = username})
	local result = MySQL:getResults(executed_query, {'username', 'password', 'banned', 'admin', 'money', 'kills', 'deaths', 'personalvehicle'}, "username")
	
	result[username]['isLoggedIn'] = 0
	result[username]['source'] = source
	
	print(GetPlayerName(result[username]['source']))
	print(result[username]['money'])
	

	return result[username]
end

function hasAccount(source)
	local username = GetPlayerName(source)
	local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE username = '@name'", {['@name'] = username})
	local result = MySQL:getResults(executed_query, {'username', 'password', 'banned', 'admin', 'money'}, "username")
		
	if(result[username] ~= nil) then
		return true
	end
	return false
end

function isLoggedIn(source)
	if(Users[GetPlayerName(source)] ~= nil)then
	if(Users[GetPlayerName(source)]['isLoggedIn'] == 1) then
		return true
	else
		return false
	end
	else
		return false
	end
end

function registerUser(password)
	if not hasAccount(source) then
		local username = GetPlayerName(source)
		-- Inserting Default User Account Stats
		MySQL:executeQuery("INSERT INTO users (`username`, `password`, `banned`, `admin`, `money`) VALUES ('@username', '@password', '0', '0', '200')",
		{['@username'] = username, ['@password'] = password})
		
		Users[username] = LoadUser(source)
		
		Users[username]['isLoggedIn'] = 1
		Users[username]['source'] = source
		
		SendPlayerChatMessage(source, "You were succesfully registered!")
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {0, 255, 0}, "?? Hold L-Alt for the player list and type /help for a list of commands.")
		TriggerClientEvent("stateFreeze", source, false)
		TriggerClientEvent("stateInvisibleInvisible", source, false)
		TriggerClientEvent("teleportSpawning", source)
		TriggerClientEvent("clientPaid", source)
		TriggerClientEvent("clientPlayerData", source, Users[username]['money'])
		TriggerClientEvent("createTimer", source)
		
	end
end

function loginUser(password)
	local username = GetPlayerName(source)
	if hasAccount(source) and not isLoggedIn(source) then
		if(Users[GetPlayerName(source)] == nil)then
			Users[GetPlayerName(source)] = LoadUser(source)
		end
		if(password ~= nil) then
			if(Users[username]['password'] == password) then 
				Users[username]['isLoggedIn'] = 1
				SendPlayerChatMessage(source, "You've successfully logged in as: "..username)
				TriggerClientEvent("stateFreeze", source, false)
				TriggerClientEvent("stateInvisible", source, false)
				TriggerClientEvent("stateGod", source, false)
				TriggerClientEvent("teleportSpawning", source)
				TriggerClientEvent("clientPlayerData", source, Users[GetPlayerName(source)]['money'])
				TriggerClientEvent("createTimer", source)
				TriggerClientEvent("clientPaid", source)
				
				TriggerServerEvent("consoleLog122")

				
				TriggerClientEvent("lastPosition", source)
			else
				SendPlayerChatMessage(source, "You entered an invalid password for username: "..username)
			end
		end
	end
end	

function savePosition(source)
--	local username = GetPlayerName(source)
--	MySQL:executeQuery("UPDATE users SET money='@newMoney' WHERE username = '@username'",
--  {['@username'] = username, ['@newMoney'] = Users[username]['money']})
end

function saveMoney(source)
	local username = GetPlayerName(source)
	MySQL:executeQuery("UPDATE users SET money='@newMoney' WHERE username = '@username'",
    {['@username'] = username, ['@newMoney'] = Users[username]['money']})
	
	TriggerClientEvent("clientPlayerData", source, Users[username]['money'])
end

function getLastPosition(source)
	return
end

function topMoney()
	local executed_query = MySQL:executeQuery("SELECT * FROM users ORDER BY money DESC LIMIT 1")
	local result = MySQL:getResults(executed_query, {'username', 'password', 'banned', 'admin', 'money'})
	
	
	if(result[1] ~= nil)then
		return result[1]
	end
end