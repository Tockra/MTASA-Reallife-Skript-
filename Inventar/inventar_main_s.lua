-- while schleife in andere if-Abfragen reinpacken...

local tempArray = {}
local function onPlayerRegister(playername)
	  local saved = mysql_query(Datenbank, "INSERT INTO `inventarinfo` (Name) VALUES ('"..MySQL_Save(playername).."')")
	  if(saved) then
			mysql_free_result(saved)
	  end
end
addEvent("onPlayerRegister",true)
addEventHandler("onPlayerRegister",getRootElement(),onPlayerRegister)

local function resourceStart(res)
	if(res ~= getThisResource()) then
		return 0
	end
	local result = mysql_query(Datenbank, "SELECT * FROM `inventardef`")
	if(mysql_num_rows(result) ~= 0) then
		
		for r,row in mysql_rows_assoc(result) do
			tempArray[tostring(row["Objektname"])] = refreshStringManuel(tostring(row["Info"])) --tostring(row["Info"])
			tempArray[tostring(row["Objektname"].."_Item_Max")] = tonumber(row["max_items"])
			setData(getRootElement(),"Item_Max",tostring(row["Objektname"]),tonumber(row["max_items"]))
			setData(getRootElement(),tostring(row["Objektname"]),"STasche",row["STasche"])
		end
		mysql_free_result(result)
	else
		outputDebugString("Die Daten konnten nicht aus der Tabelle 'inventardef' ausgelesen werden!")
		mysql_free_result(result)
	end
end
addEventHandler("onResourceStart",getRootElement(),resourceStart)

local function onPlayerLogin()
	local playername = getPlayerName(source)
	local result = mysql_query(Datenbank, "SELECT * FROM `inventarinfo` WHERE `Name`='"..MySQL_Save(playername).."'")
	if(mysql_num_rows(result) ~= 0) then
		local pInfo = mysql_fetch_assoc(result)
		mysql_free_result(result)
		for index,wert in pairs(pInfo) do
			if(tonumber(wert)) then
				setData(source,"Inventar",tostring(index),tonumber(wert),true)
			else
				setData(source,"Inventar",tostring(index),wert,true)
			end
		end
	else
		outputDebugString("Die Daten des Spielers "..playername.." konnten nicht aus der Tabelle 'inventarinfo' ausgelesen werden!")
		mysql_free_result(result)
	end
	
	local playername = getPlayerName(source)
	local result = mysql_query(Datenbank, "SELECT * FROM `inventarinhalt` WHERE `Name`='"..MySQL_Save(playername).."'")
	if(mysql_num_rows(result) ~= 0) then
		for result,row in mysql_rows_assoc(result) do
				setData(source,"Item",tonumber(row["id"]),tostring(row["Objekt"]),true)
				setData(source,"Item",tonumber(row["id"]).."_Menge",tonumber(row["Menge"]),true)
				setData(source,"Item",tonumber(row["id"]).."_Platz",tonumber(row["Platz"]),true)
				setData(source,"Item_"..tostring(row["Tasche"]),tonumber(row["Platz"]).."_id",tonumber(row["id"]),true)
			
		end
		mysql_free_result(result)
	else
		mysql_free_result(result)
	end
	
	for index,value in pairs(tempArray) do
		setData(source,"Iteminfo",index,value,true)
	end
	
end
addEvent("afterPlayerLogin",true)
addEventHandler("afterPlayerLogin",getRootElement(),onPlayerLogin)

local function onPlayerQuit()
	if(not getElementData(source,"loggedin")) then
		return 0
	end
	updatePlayerTable(source,"Inventar","inventarinfo")
	-- Save in den einzelnen Funktionen in inventar_functions_s.lua
end
addEventHandler("onPlayerQuit",getRootElement(),onPlayerQuit)

local function onStop(rs)
	if(rs ~= getThisResource) then
		return 0
	end
	local players = getElementsByType("player")
	for index, value in ipairs(players) do
		if(getElementData(value,"loggedin")) then
			updatePlayerTable(value,"Inventar","inventarinfo")
		end
	end
	
	-- Save in den einzelnen Funktionen in inventar_functions_s.lua
end
addEventHandler("onResourceStop",root,onStop)


function doIt(player,cn,v)
	--giveItem(player,"Geld",10,"Potte")
	
	outputChatBox(tostring(worldItems[tonumber(v)]["xPos"]))
	

end
addCommandHandler("ro",doIt)

function gii(player)
	--giveItem(player,"Geld",10,"Potte")
	addItemToWorld(player,"Potte",1,10)
		
end
addCommandHandler("gi",gii)
local function changePlaces(player,tasche,oPlace,nPlace)
	if(client ~= player) then
		return false
	end
	
	setItemPlace(player,tasche,oPlace,-1)
	setItemPlace(player,tasche,nPlace,oPlace)
	setItemPlace(player,tasche,-1,nPlace)
end
addEvent("changePlaces",true)
addEventHandler("changePlaces",getRootElement(),changePlaces)