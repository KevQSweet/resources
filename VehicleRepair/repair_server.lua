RegisterServerEvent("chatCommandEntered")
AddEventHandler('chatCommandEntered', function(fullcommand)
    command = stringsplit(fullcommand, " ")

    if(command[1] == "/fix") then -- Captures the command
        TriggerClientEvent("SetVehicleFixed", source, command[2])
        end
end)

function stringsplit(self, delimiter) -- A function
  local a = self:Split(delimiter) -- Splits the string.
  local t = {} -- Creates a table

  for i = 0, #a - 1 do -- For loop to loop through all the arguments.
     table.insert(t, a[i]) -- Inserts the arguments into a table
  end

  return t -- Returns the table
end
