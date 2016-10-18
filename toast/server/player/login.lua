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

function loginUser(password)
	local username = GetPlayerName(source)
	if hasAccount(source) and not isLoggedIn(source) then
		if(Users[GetPlayerName(source)] == nil)then
			Users[GetPlayerName(source)] = LoadUser(source)
		end
		if(password ~= nil) then
			if(Users[username]['password'] == password) then 
				Users[username]['isLoggedIn'] = 1
				SendPlayerChatMessage(source, "You have successfully logged in as: "..username)
				TriggerClientEvent("AwesomeFreeze", source, false)
				TriggerClientEvent("AwesomeInvisible", source, false)
				TriggerClientEvent("AwesomeGod", source, false)
				TriggerClientEvent("teleportSpawning", source)
				TriggerClientEvent("clientPlayerData", source, Users[GetPlayerName(source)]['money'])
				TriggerClientEvent("createTimer", source)
				TriggerClientEvent("clientPaid", source)
				TriggerServerEvent("debugLogs")
				--print(Users[username].."has logged in.")
			else
				SendPlayerChatMessage(source, username..", you entered an invalid password !")
				TriggerServerEvent("debugLogs")
			end
		end
	end
end