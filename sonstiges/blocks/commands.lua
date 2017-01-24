local aspam = {}
local function onCommand(command)
	local time = getRealTime()
	if(tonumber(aspam[source])) then
		if(time.timestamp <= aspam[source] ) then
			cancelEvent()
			return 1
		end
		aspam[source] = time.timestamp
	else
		aspam[source] = time.timestamp
	end
	
	if(getElementData(source,"loggedin") ~= true) then
		cancelEvent()
	end
	
	if(getElementData(source,"Friedhof[Tod]") == 1 and string.lower(command) ~= "friedhofzeit") then
		cancelEvent()
		outputChatBox("Diesen Befehl kannst du nicht benutzen, während du tot bist!",source,175,175,175)
	end
	
end
addEventHandler("onPlayerCommand",getRootElement(),onCommand)

local function togMsn(cmd)
   if(cmd == "msg") then
      cancelEvent()
   end
end
addEventHandler("onPlayerCommand",getRootElement(),togMsn)

