local chatRange(100)
command = ("/local", "/loc")
 
AddEventHandler("OnPlayerJoin",GetRootElement(),
function ()
KeyPressed(source,"y","down","chat","Local")
end)
 
AddEventHandler("OnResourceStart",getResourceRootElement(getThisResource()),
function ()
for index, player in pairs(GetElementsByType("player")) do
IsKeyPressed(player,"y","down","chat","Local") or
commandEntered(command)
  end
end)
 
function isPlayerInRangeOfPoint(player,x,y,z,range)
   local px,py,pz=GetElementPosition(player)
   return ((x-px)^2+(y-py)^2+(z-pz)^2)^0.5<=range
end
 
function onChat(player,_,...)
  local px,py,pz=GetElementPosition(player)
  local message = table.concat({...}, " ")
  local name = GetPlayerName(name)
--local r,g,b = getTeamColor(getPlayerTeam(player))
  for _,v in ipairs(GetElementType("player")) do
    if isPlayerInRangeOfPoint(v,px,py,pz,chatRange) then
      print("(Local) "..nick..": "..msg,v,r,g,b,true)
    end
  end
end
