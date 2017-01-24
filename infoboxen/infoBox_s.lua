
local infoID = {}
local function getInfoboxID(id)
	if(source ~= client) then
		return false
	end
	if(not infoID[source]) then
		infoID[source] = {}
	end
	infoID[source][id] = true
end
addEvent("giveInfoid",true)
addEventHandler("giveInfoid",getRootElement(),getInfoboxID)
local function removeInfoid(id)
	if(source~=client) then
		return false
	end
	if(infoID[source][id]) then
		infoID[source][id] = nil
	end
end
addEvent("removeInfoid",true)
addEventHandler("removeInfoid",getRootElement(),removeInfoid)

function createInfobox(player,name,text,filepath,locked,time)
	if(not infoID[player]) then
		infoID[player] = {}
	end
	local id = getHighestInfobox(player) + 1
	infoID[player][id] = true
	triggerClientEvent(player,"createInfobox",player,name,text,filepath,locked,time)
	return id
end

function destroyInfobox(player,id)
	infoID[player][id] = nil
	triggerClientEvent(player,"destroyInfobox",player,id)
	return true
end

function getCurrentInfobox(player)
	return getElementData(player,"currentID")
end

function testii(player)
	outputChatBox(tostring(getCurrentInfobox(player)))
end
addCommandHandler("add",testii)

function getHighestInfobox(player)
	local highest = 0
	for index,value in pairs(infoID[player]) do
		if(value) then
			highest = index
		end
	end
	return highest
end