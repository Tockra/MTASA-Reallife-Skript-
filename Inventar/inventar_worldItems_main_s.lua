-- DEFENITIONEN --
local definitionen = {
["Geld"]= 1212,
["ECKarte"]= 2710,
["weapons/Schlagring"]= 331,
["weapons/Golfschlaeger"]=333,
["weapons/Schlagstock"]=334,
["weapons/Messer"]=335,
["weapons/Baseballschlaeger"]=336,
["weapons/Schaufel"]=337,
["weapons/Billiard Koe"]=338,
["weapons/Katana"]=339,
["weapons/Kettensaege"]=341,
["weapons/Pistole"]=346,
["weapons/Schalldaempferpistole"]=347,
["weapons/Desert Eagle"]=348,
["weapons/Schrotflinte"]=349,
["weapons/Sawn-Off Schrotflinte"]=350,
["weapons/SPAZ-12 Gefechtsschrotflinte"]=351,
["weapons/Uzi"]=352,
["weapons/MP5"]=353,
["weapons/TEC-9"]=372,
["weapons/AK-47"]=355,
["weapons/M4"]=356,
["weapons/Countryschrotflinte"]=357,
["weapons/Sniper"]=358,
["weapons/Raketenwerfer"]=359,
["weapons/Waermelenkraketenwerfer"]=360,
["weapons/Flammenwerfer"]=361,
["weapons/Granate"]=342,
["weapons/Traenengas"]=343,
["weapons/Molotov Cocktails"]=344,
["weapons/Rucksackbomben"]=363,
["weapons/Spraydose"]=365,
["weapons/Feuerloescher"]=366,
["weapons/Digitalkamera"]=367,
["weapons/Langer purpel Dildo"]=321,
["weapons/Kurzer Dildo"]=322,
["weapons/Vibrator"]=323,
["weapons/Blumen"]=325,
["weapons/Gehstock"]=326,
["weapons/Nachtsichtgeraet"]=368,
["weapons/Infrarotsichtgeraet"]=369,
["weapons/Fallschirm"]=371,
["weapons/Rucksackbombenzuender"]=364
}

local itemObjects = {}


worldItems = {}
local function getMysql(res)
	if(res == getThisResource()) then
		local result = mysql_query(Datenbank, "SELECT * FROM `weltitems`")
		if(mysql_num_rows(result) ~= 0) then
			for result,row in mysql_rows_assoc(result) do
					worldItems[tonumber(row["id"])] = row
					itemObjects[tonumber(row["id"])] = createPickup(row["xPos"],row["yPos"],row["zPos"],3,definitionen[row["Name"]],1)
					setElementData(itemObjects[tonumber(row["id"])],"WorldItem",row["id"],true)
					setElementCollisionsEnabled ( itemObjects[tonumber(row["id"])] , false )
			end 
			mysql_free_result(result)
		else
			mysql_free_result(result)
		end
	end
end
addEventHandler("onResourceStart",getRootElement(),getMysql)

function addItemToWorld(player,tasche,platz,anzahl)
	if(not anzahl) then
		anzahl = 1
	end
	local playername = getPlayerName(player)
	local id = getElementData(player,"Item_"..tasche,platz.."_id")
	
	if(not id) then
		return false
	end
	local id = getElementData(player,"Item_"..tasche,platz.."_id")
	triggerClientEvent(player,"checkPlaceIW",player,tasche,platz,anzahl,id)
	return true
end

function destroyWorldItem(id)
	id = tonumber(id)
	if(worldItems[id]) then
		local delete = mysql_query(Datenbank,"DELETE FROM `weltitems` WHERE `id`='"..MySQL_Save(tostring(id)).."'")
		mysql_free_result(delete)
		setElementData(itemObjects[id],"WorldItem",false,true)
		destroyElement(itemObjects[id])
		triggerClientEvent("kill3DText",getRootElement(),id)
		worldItems[id] = nil
		return true
	else
		return false
	end
end

function c_addObjectToWorld(x,y,z,tasche,platz,anzahl)
	if(source ~=client) then
		return false
	end
	local px,py,pz = getElementPosition(source)
	if(getDistanceBetweenPoints3D(x,y,z,px,py,pz) > 10) then
		return false
	end
	local id = getElementData(source,"Item_"..tasche,platz.."_id")
	if(not id) then
		return false
	end
	local menge = getElementData(source,"Item",id.."_Menge")
	local item = getElementData(source,"Item",id)
	local interior = getElementInterior(source)
	local dimension = getElementDimension(source)
	local playername = getPlayerName(source)
	removeItem(source,tasche,platz,anzahl)
	local saved = mysql_query(Datenbank, "INSERT INTO `weltitems` (Name,Menge,Verschmutzer,xPos,yPos,zPos,Interior,Dimension) VALUES ('"..MySQL_Save(item).."','"..MySQL_Save(anzahl).."','"..MySQL_Save(playername).."','"..MySQL_Save(x).."','"..MySQL_Save(y).."','"..MySQL_Save(z).."','"..MySQL_Save(interior).."','"..MySQL_Save(dimension).."')")
	if(saved) then id = mysql_insert_id (Datenbank) end
	mysql_free_result(saved)
	worldItems[tonumber(id)] = {["id"]=tonumber(id),["Name"]=item,["Menge"]=tonumber(anzahl),["Verschmutzer"]=playername,["xPos"]=tonumber(x),["yPos"]=tonumber(y),["zPos"]=tonumber(z),["Interior"]=tonumber(interior),["Dimension"]=tonumber(dimension)}
	itemObjects[tonumber(id)] = createPickup(x,y,z,3,definitionen[tostring(item)],1)
	setElementCollisionsEnabled ( itemObjects[tonumber(id)] , false )
	setElementData(itemObjects[tonumber(id)],"WorldItem",tonumber(id),true)
	
end
addEvent("c_addObjectToWorldIW",true)
addEventHandler("c_addObjectToWorldIW",getRootElement(),c_addObjectToWorld)

local function c_getItemInfos(id)
	if(source ~= client) then
		return 0
	end
	local name = worldItems[tonumber(id)]["Name"]
	local menge = worldItems[tonumber(id)]["Menge"]
	local x,y,z = worldItems[tonumber(id)]["xPos"],worldItems[tonumber(id)]["yPos"],worldItems[tonumber(id)]["zPos"]
	triggerClientEvent(source,"getItemInfos",source,id,name,menge,x,y,z)
end
addEvent("c_getItemInfos",true)
addEventHandler("c_getItemInfos",getRootElement(),c_getItemInfos)

local function givePlayerWorldItem(player,wItemid)
	if(wItemid and worldItems[tonumber(wItemid)]) then
		local item = worldItems[tonumber(wItemid)]["Name"]
		local menge = tonumber(worldItems[tonumber(wItemid)]["Menge"])
		local tasche = getElementData(getRootElement(),tostring(item))["STasche"]
		if(giveItem(player,item,menge,tasche)) then
			destroyWorldItem(wItemid)
			return true
		else
			return false
		end
	else
		return false
	end
end

local function getItem(player)
	local px,py,pz = getElementPosition(player)
	local objects = getElementsByType("pickup")
	local id
	local lowD
	local lowestD = 10
	for index,value in pairs(objects) do
		local x,y,z = getElementPosition(value)
		lowD = getDistanceBetweenPoints3D(px,py,pz,x,y,z)
		if(getElementData(value,"WorldItem") and lowD <=1.5 and lowD < lowestD) then
			id = getElementData(value,"WorldItem")
		end
	end
	givePlayerWorldItem(player,id)
end

--[[local function onClick(mouseButton,state,object)
	if(mouseButton ~= "left" or state ~= "down") then
		return false
	end
	if( not object or (object and isElement(object) and getElementType(object) == "object" and not getElementData(object,"WorldItem"))) then
		outputChatBox(tostring(isElement(object)))
		return false
	end
	local px,py,pz = getElementPosition(source)
	local x,y,z = getElementPosition(object)
	if(getDistanceBetweenPoints3D(px,py,pz,x,y,z) <= 2) then
		local id = getElementData(object,"WorldItem")
		givePlayerWorldItem(source,id)
	else
		outputChatBox("Du bist zu weit entfernt!",source)
	end
end
addEventHandler("onPlayerClick",getRootElement(),onClick)]]

local function onJoin()
	bindKey(source,"e","down",getItem)
end
addEventHandler("onPlayerJoin",getRootElement(),onJoin)

local function layItemInWorld(player,tasche,id)
	if(client ~= player) then
		return false
	end
	local platz = getElementData(player,"Item",id.."_Platz")
	local menge = getElementData(player,"Item",id.."_Menge")
	addItemToWorld(player,tasche,platz,menge)
end
addEvent("layItemInWorld_c",true)
addEventHandler("layItemInWorld_c",getRootElement(),layItemInWorld)
