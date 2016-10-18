-- Loading MySQL Class
require "resources/toast/lib/MySQL"

-- MySQL:open("IP", "databasname", "user", "password")
MySQL:open("127.0.0.1", "new_schema", "QSweet", "Forgetmenot!1992")
local json = require( "json" ) 

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

function topMoney()
	local executed_query = MySQL:executeQuery("SELECT * FROM users ORDER BY money DESC LIMIT 1")
	local result = MySQL:getResults(executed_query, {'username', 'password', 'banned', 'admin', 'money'})
	
	
	if(result[1] ~= nil)then
		return result[1]
	end
end

function saveMoney(source)
	local username = GetPlayerName(source)
	MySQL:executeQuery("UPDATE users SET money='@newMoney' WHERE username = '@username'",
    {['@username'] = username, ['@newMoney'] = Users[username]['money']})
	
	TriggerClientEvent("clientPlayerData", source, Users[username]['money'])
end

function saveKD(source)
	local username = GetPlayerName(source)
	MySQL:executeQuery("UPDATE users SET kills='@newKD' WHERE username = '@username'",
    {['@username'] = username, ['@newKD'] = Users[username]['kills']})
	
	MySQL:executeQuery("UPDATE users SET deaths='@newKD' WHERE username = '@username'",
    {['@username'] = username, ['@newKD'] = Users[username]['deaths']})
end

function savePersonalVehicle(source)
	local username = GetPlayerName(source)
	MySQL:executeQuery("UPDATE users SET personalvehicle='@newPersonalvehicle' WHERE username = '@username'",
    {['@username'] = username, ['@newPersonalvehicle'] = Users[username]['personalvehicle']})
end

function registerUser(password)
	if not hasAccount(source) then
		local username = GetPlayerName(source)
		-- Inserting Default User Account Stats
		MySQL:executeQuery("INSERT INTO users (`username`, `password`, `banned`, `admin`, `money`) VALUES ('@username', '@password', '0', '0', '10')",
		{['@username'] = username, ['@password'] = password})
		
		Users[username] = LoadUser(source)
		
		Users[username]['isLoggedIn'] = 1
		Users[username]['source'] = source
		
		SendPlayerChatMessage(source, "You were succesfully registered!")
		print(Users[username].." has registered.")
	else
		print(Users[username].." is attempting to re-register.")
	end
end