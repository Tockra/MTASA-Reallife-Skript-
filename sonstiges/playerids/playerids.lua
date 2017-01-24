ID = {}

function onJoin()
	for i=0, getPlayerCount() , 1 do
		if(ID[i] == nil) then
			ID[i] = source
			setElementData(source,"ID",i)
			setElementData(getRootElement(),"ID["..i.."]",source)
			break
		end
	end
end
addEventHandler("onPlayerJoin", getRootElement(), onJoin)

function onQuit()
	ID[tonumber(getElementData(source,"ID"))] = nil
end
addEventHandler("onPlayerQuit", getRootElement(), onQuit)

function id(player,cE,value)
	outputChatBox(tostring(ID[tonumber(value)]))
end
addCommandHandler("id",id)

function getPlayerID(playersrc)
	for i=0, getMaxPlayers(), 1 do
		if(source == ID[i]) then
			return i
		end
	end
end

