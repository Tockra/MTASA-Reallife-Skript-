maxpwtrys = 3
local function onPlayerConnect()
	setElementData ( source, "pwtrys", 0,false)
 	setElementData ( source, "PlayerSerial", getPlayerSerial(source),false)
end
addEventHandler ( "onPlayerJoin", getRootElement(), onPlayerConnect)

function wrongPassword(player)
	if(getElementData(player,"pwtrys") >= maxpwtrys) then
		banPlayer(player,true,false,true,getRootElement(),"Falsches Kennwort! Du wurdest 10 Minuten gebannt!",600)
		return 0
	end
	setElementData(player,"pwtrys", getElementData(player,"pwtrys") + 1)
end