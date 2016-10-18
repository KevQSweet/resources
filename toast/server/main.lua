-- Server

local firstspawn = true
Users = {}
RegisterServerEvent("debugLogs")

RegisterServerEvent("chatCommandEntered")
RegisterServerEvent("onPlayerConnect")
RegisterServerEvent("giveMeWelfare")

RegisterServerEvent("baseevents:onPlayerKilled")

RegisterServerEvent("spawnPersonalVehicle")

-- Gun stuff
local spawnAbleWeapons = {"WEAPON_KNIFE", "WEAPON_NIGHTSTICK", "WEAPON_HAMMER", "WEAPON_BAT", "WEAPON_GOLFCLUB", "WEAPON_CROWBAR","WEAPON_PISTOL", "WEAPON_COMBATPISTOL", "WEAPON_APPISTOL", "WEAPON_PISTOL50", "WEAPON_MICROSMG", "WEAPON_SMG", "WEAPON_ASSAULTSMG", "WEAPON_ASSAULTRIFLE", "WEAPON_CARBINERIFLE", "WEAPON_ADVANCEDRIFLE", "WEAPON_MG", "WEAPON_COMBATMG", "WEAPON_PUMPSHOTGUN", "WEAPON_SAWNOFFSHOTGUN", "WEAPON_ASSAULTSHOTGUN", "WEAPON_BULLPUPSHOTGUN","WEAPON_STUNGUN", "WEAPON_SNIPERRIFLE", "WEAPON_SMOKEGRENADE", "WEAPON_BZGAS", "WEAPON_MOLOTOV", "WEAPON_FIREEXTINGUISHER", "WEAPON_PETROLCAN", "WEAPON_SNSPISTOL", "WEAPON_SPECIALCARBINE", "WEAPON_HEAVYPISTOL", "WEAPON_BULLPUPRIFLE", "WEAPON_HOMINGLAUNCHER", "WEAPON_PROXMINE", "WEAPON_SNOWBALL", "WEAPON_VINTAGEPISTOL", "WEAPON_DAGGER", "WEAPON_FIREWORK", "WEAPON_MUSKET", "WEAPON_MARKSMANRIFLE", "WEAPON_HEAVYSHOTGUN", "WEAPON_GUSENBERG", "WEAPON_HATCHET", "WEAPON_COMBATPDW", "WEAPON_KNUCKLE", "WEAPON_MARKSMANPISTOL", "WEAPON_BOTTLE", "WEAPON_FLAREGUN", "WEAPON_FLARE", "WEAPON_REVOLVER", "WEAPON_SWITCHBLADE", "WEAPON_MACHETE", "WEAPON_FLASHLIGHT", "WEAPON_MACHINEPISTOL", "WEAPON_DBSHOTGUN", "WEAPON_COMPACTRIFLE"}
local adminGuns = {"WEAPON_RAILGUN", "WEAPON_HEAVYSNIPER", "WEAPON_GRENADELAUNCHER", "WEAPON_GRENADELAUNCHER_SMOKE", "WEAPON_RPG", "WEAPON_MINIGUN", "WEAPON_GRENADE", "WEAPON_STICKYBOMB"}


AddEventHandler('onPlayerConnect', function()	
	
	
	if(Users[GetPlayerName(source)] == nil)then
	-- loading
		if hasAccount(source) then
			print("User has account: "..GetPlayerName(source))
			Users[GetPlayerName(source)] = LoadUser(source)
			TriggerClientEvent("AwesomeFreeze", source, true)
			TriggerClientEvent("AwesomeInvisible", source, true)

			SendPlayerChatMessage(source, "🔒 Your account have been found on our database type ^1/login ^7[^2Your Password^7]")
		else
			TriggerClientEvent("AwesomeFreeze", source, true)
			TriggerClientEvent("AwesomeInvisible", source, true)
			
			SendPlayerChatMessage(source, "🔒 Please ^1register^7 with this command ^1/register ^7[^2Your Password^7]")
		end
	end
	TriggerClientEvent("teleportSpawning", source)
end)


AddEventHandler('playerDropped', function(reason)
	-- Check if Usersrow is existing -> Deleting Users var at disconnect
	local localname = GetPlayerName(source)
	print("Player " .. GetPlayerName(source) .. " disconnected. Reason: "..reason)
	
	Users[localname] = nil
end)

AddEventHandler('giveMeWelfare', function()
	if(hasAccount(source)) then
		if(isLoggedIn(source)) then
			Users[GetPlayerName(source)]['money'] = Users[GetPlayerName(source)]['money'] + 200
			saveMoney(source)
			TriggerClientEvent("clientPaid")
			Print(GetPlayerName(source).." has collected their welfare.")
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
			TriggerClientEvent("thisPos", source)
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
	end
end)

function stringsplit(self, delimiter)
  local a = self:Split(delimiter)
  local t = {}

  for i = 0, #a - 1 do
     table.insert(t, a[i])
  end

  return t
end

function SendPlayerChatMessage(source, message, color)
	if(color == nil) then
		color = { 0, 0x99, 255}
	end
	TriggerClientEvent("chatMessage", source, '', color, message)
end

AddEventHandler('debugLogs', function(consoleMessageLog)
	if consoleMessageLog == nil then
		print("debug triggered but no message")
	else
		print(consoleMessageLog)
	end
end)


print("[toast - QSweet] Gamemode initialized. V1")