timer = {}
local warningB = {}
local warning = {}
DPed = {}
deathPlayer = {}
deathPlayerBlip = {}
function setOldFriedhofData(player) -- Nach dem einloggen werden mit dieser Tabelle die MYSQL Werte in die ElementData gepackt
	local result = mysql_query(Datenbank, "SELECT * FROM `friedhof` WHERE `Name`='"..MySQL_Save(getPlayerName(player)).."'")
	if(mysql_num_rows(result) ~= 0) then
		local pInfo = mysql_fetch_assoc(result)
		mysql_free_result(result)
		for index,wert in pairs(pInfo) do
			if(tonumber(wert)) then
				setElementData(player,"Friedhof["..tostring(index).."]",tonumber(wert))
			else
				setElementData(player,"Friedhof["..tostring(index).."]",wert)
			end
		end
	else
		mysql_free_result(result)
	end
	
	if(tonumber(getElementData(player,"Friedhof[Tod]")) == 1) then
		createPickupSetTime(player)
	end
end

local function onWasted(ammo, killerE) -- Wird ausgeführt wenn ein Spieler stirbt (Friedhof script wird ausgelöst!
	local killer
	removePedFromVehicle(source)
	if(getElementData(getRootElement(),"Settings","FriedhofEnabled") == 1) then
		if(killerE) then
			if(getElementType ( killerE ) == "Player") then
				killer = getPlayerName(killerE)
			elseif(getElementType (killerE) == "Vehicle") then
				if(getVehicleOccupant ( killerE )) then
					killer = getPlayerName(getVehicleOccupant ( killerE ))
				else
					killer = "-"
				end
			else 
				killer = "-"
			end
		else
			killer = "-"
		end
		local x,y,z = getElementPosition(source)
		local dim = getElementDimension(source)
		local int = getElementInterior(source)
		
		setData(source,"UnL","X",3095.7819824219)
		setData(source,"UnL","Y",-2320.9838867188)
		setData(source,"UnL","Z",6098.5073242188)
		setData(source,"UnL","Rotation",270)
		setElementData(source,"Dienst",false,false)
		setFriedhofData(source,x,y,z,dim,int,killer)
		fadeCamera ( source, false, 5, 255, 255, 255 )
		warningB[source] = setTimer(vFriedhof,5000,1,source)
		warning[source] = true
		
		createPickupSetTime(source)
	else
		setTimer(
		function(player)
			local x,y,z = getPlayerSpawn(player)
			spawnPlayer(player,x,y,z,0,getSkin(player))
			setCameraTarget(player,player)
		end,5000,1,source)
	end
end
addEventHandler("onPlayerWasted",getRootElement(),onWasted)

local function quitPlayer() -- Friedhofszeit wird beim Dis gespeichert und Timer und Pickup werden gelöscht
	if(getElementData(source,"Friedhof[Tod]") == 1) then
		local time = getRealTime()
		if(getElementData(source,"Friedhof[Transport]") ~=1) then
			destroyDeathMarker(source)
			destroyElement(deathPlayerBlip[source])
			removeEventHandler("onElementStartSync",DPed[source],syncDPed)
			destroyElement(DPed[source])
			deathPlayerBlip[source] = nil
			DPed[source] = nil
		end
		if(warning[source]) then
			killTimer(warningB[source])
		end
		killTimer(timer[source])
		
		local saved = mysql_query(Datenbank,"UPDATE `friedhof` SET `Zeit`='"..MySQL_Save ( tostring(getElementData(source,"Friedhof[Zeit]") + (tonumber(time.timestamp) - getElementData(source,"Friedhof[TimeStart]"))) ).."', `Transport`='"..MySQL_Save(getElementData(source,"Friedhof[Transport]")).."', `Called`='"..MySQL_Save(getElementData(source,"Friedhof[Called]")).."' WHERE `Name`='"..MySQL_Save ( getPlayerName(source) ).."'")
		mysql_free_result ( saved )
	end

end
addEventHandler("onPlayerQuit",getRootElement(),quitPlayer)

local function resstop()
	local players = getElementsByType("player")
	local time = getRealTime()
	for index, player in ipairs(players) do
		if(getElementData(player,"Friedhof[Tod]") == 1) then
			local saved = mysql_query(Datenbank,"UPDATE `friedhof` SET `Zeit`='"..MySQL_Save ( tostring(getElementData(player,"Friedhof[Zeit]") + (tonumber(time.timestamp) - getElementData(player,"Friedhof[TimeStart]"))) ).."', `Transport`='"..MySQL_Save(getElementData(source,"Friedhof[Transport]")).."' WHERE `Name`='"..MySQL_Save ( getPlayerName(player) ).."'")
			mysql_free_result ( saved )
		end
	end
end
addEventHandler("onResourceStop",getRootElement(),resstop)

function vFriedhof(player) -- Spieler wird zu dem Friedhof geportet.

	if(getElementData(player,"loggedin") == true) then
		local time = getRealTime()
		setData(player,"UnL","X",3095.7819824219)
		setData(player,"UnL","Y",-2320.9838867188)
		setData(player,"UnL","Z",6098.5073242188)
		setData(player,"UnL","Rotation",270)
		setElementData(player,"Dienst",false,false)
		warning[player] = false
		spawnPlayer(player, getElementData(player,"UnL","X"),getElementData(player,"UnL","Y"),getElementData(player,"UnL","Z"), getElementData(player,"UnL","Rotation"), getElementData(player,"UnL","Skin"))
		fadeCamera ( player, false, 0 , 255,255,255)
		fadeCamera ( player, true, 5, 255, 255, 255 )
		setElementDimension(player,5)
		setElementAlpha(player,100)
		outputChatBox("Benutze /friedhofzeit um herauszufinden, wie lange du noch hier bleiben musst !",player,110,110,110)
		triggerClientEvent(player,"setClientTime",player,0, getElementData(player,"Friedhof[TimeTo]") - (tonumber(time.timestamp) - getElementData(player,"Friedhof[TimeStart]") + getElementData(player,"Friedhof[Zeit]")), getElementData(player,"Friedhof[TimeTo]"))
		if(getElementData(player,"Friedhof[Called]") == 0) then
			triggerClientEvent(player,"showFriedhofPanel",player)
		end
	end
end
--16

function setFriedhofData(player,xPos,yPos,zPos,dim,int,killer) -- Nach dem Tod wird ein Tabelleneintrag mit den ganzen Friedhofwerten gespeichert
	if(getElementData(player,"Friedhof[Tod]") ~=1) then
		local result = mysql_query(Datenbank, "SELECT * FROM `friedhof` WHERE `Name`='"..MySQL_Save(getPlayerName(player)).."'")
		if(mysql_num_rows(result) == 0) then
			local saved = mysql_query(Datenbank, "INSERT INTO `friedhof` (Name,Tod,xTod,yTod,zTod,Dimension,Interior,Killer) VALUES ('"..MySQL_Save(getPlayerName(player)).."','"..MySQL_Save(1).."','"..MySQL_Save(xPos).."','"..MySQL_Save(yPos).."','"..MySQL_Save(zPos).."','"..MySQL_Save(dim).."','"..MySQL_Save(int).."','"..MySQL_Save(killer).."')")
			print("INSERT INTO `friedhof` (Name,Tod,xTod,yTod,zTod,Dimension,Interior,Killer) VALUES ('"..MySQL_Save(getPlayerName(player)).."','"..MySQL_Save(1).."','"..MySQL_Save(xPos).."','"..MySQL_Save(yPos).."','"..MySQL_Save(zPos).."','"..MySQL_Save(dim).."','"..MySQL_Save(int).."','"..MySQL_Save(killer).."')")
			mysql_free_result(saved)
		end
		mysql_free_result(result)
		pClearElementData(player,xPos,yPos,zPos,dim,int,killer)
	end
end

function setFriedhofDataNil(player) -- Alle Friedhof ElementDatas werden auf nil gesetzt
	setElementData(player,"Friedhof[Name]",nil)
	setElementData(player,"Friedhof[Tod]", nil)
	setElementData(player,"Friedhof[Zeit]",nil)
	setElementData(player,"Friedhof[xTod]",nil)
	setElementData(player,"Friedhof[yTod]",nil)
	setElementData(player,"Friedhof[zTod]",nil)
	setElementData(player,"Friedhof[Dimension]",nil)
	setElementData(player,"Friedhof[Interior]",nil)
	setElementData(player,"Friedhof[Killer]",nil)
	setElementData(player,"Friedhof[Called]",nil)
	
	local delete = mysql_query(Datenbank,"DELETE FROM `friedhof` WHERE `Name`='"..MySQL_Save( getPlayerName(player) ).."'")
	mysql_free_result(delete)
end

function pClearElementData(player,x,y,z,dim,int,killer) -- Die ElementDatas werden erstellt, aber bleiben leer (standartwerte nach Tot)
	
	setElementData(player,"Friedhof[Killer]",killer,false)
	setElementData(player,"Friedhof[Name]",getPlayerName(player),false)
	setElementData(player,"Friedhof[Tod]", 1,false)
	setElementData(player,"Friedhof[Zeit]",0,false)
	setElementData(player,"Friedhof[xTod]",x,false)
	setElementData(player,"Friedhof[yTod]",y,false)
	setElementData(player,"Friedhof[zTod]",z,false)
	setElementData(player,"Friedhof[Dimension]",dim,false)
	setElementData(player,"Friedhof[Interior]",int,false)
	setElementData(player,"Friedhof[Transport]",1,false)
	setElementData(player,"Friedhof[Krankenhaus]",0)
	setElementData(player,"Friedhof[Called]",0,false)
	triggerClientEvent(player,"getCoords",player,getElementData(player, "Friedhof[xTod]") , getElementData(player, "Friedhof[yTod]"), getElementData(player, "Friedhof[zTod]"))

end

function checkDeathTime(player) -- Es wird überprüft ob der Spieler lange genug tot war
	local time = getRealTime()
	if( getElementData(player,"Friedhof[TimeTo]") - (tonumber(time.timestamp) - getElementData(player,"Friedhof[TimeStart]") + getElementData(player,"Friedhof[Zeit]")) <= 0) then
		setFriedhofDataNil(player)
		killTimer(timer[player])
		timer[player] = nil
		if(getElementData(player,"Friedhof[Transport]") ~=1) then
			destroyDeathMarker(player)
			destroyElement(deathPlayerBlip[player])
			removeEventHandler("onElementStartSync",DPed[player],syncDPed)
			destroyElement(DPed[player])
			DPed[player] = nil
			deathPlayerBlip[player] = nil
		
			
		end
		setData(player,"UnL","X",getElementData(getRootElement(),"Settings","xFriedhofSpawn"))
		setData(player,"UnL","Y",getElementData(getRootElement(),"Settings","yFriedhofSpawn"))
		setData(player,"UnL","Z",getElementData(getRootElement(),"Settings","zFriedhofSpawn"))
		setData(player,"UnL","Rotation",getElementData(getRootElement(),"Settings","rotationFriedhofSpawn"))
		local kosten = -getElementData(getRootElement(),"Settings","deathPriceMultiple") * getElementData(player,"UnL","Level")
		giveMoney(player,kosten)
		triggerClientEvent(player,"reLife",player,WetterID) -- Spieler wird wiederbelebt
	end
end

function createPickupSetTime(player) -- Timer und Pickup werden erstellt
	local time = getRealTime()
	setElementData(player,"Friedhof[TimeTo]", tonumber((getElementData(getRootElement(),"Settings","FriedhofTimeMultiple") * tonumber(getElementData(player,"UnL","Level"))) ))
	setElementData(player,"Friedhof[TimeStart]", tonumber(time.timestamp) )
	timer[player] = setTimer(checkDeathTime,5000,0,player)
	if(getElementData(player,"Friedhof[Transport]") ~=1) then
		createDeathMarker(player)
		deathPlayerBlip[player] =  createBlip(getElementData(player, "Friedhof[xTod]") , getElementData(player, "Friedhof[yTod]"), getElementData(player, "Friedhof[zTod]"),23,3)

		
		DPed[player] = createPed(getElementData(player,"UnL","Skin"),getElementData(player, "Friedhof[xTod]") , getElementData(player, "Friedhof[yTod]"), getElementData(player, "Friedhof[zTod]"))
		setElementData(DPed[player],"Name",getPlayerName(player))
		setPedAnimation(DPed[player],"CRACK","crckidle2",-1,true,false,false)
		setElementFrozen ( DPed[player], true )
		setElementCollisionsEnabled ( DPed[player], false )
		addEventHandler("onElementStartSync",DPed[player],syncDPed)
		
		setElementVisibleTo(deathPlayerBlip[player],getRootElement(),false)
	end
end

local function zeit(player) -- manuelle Zeitabfrage
	if(getElementData(player,"Friedhof[Tod]") == 1) then
		local time = getRealTime()
		local timeT = getElementData(player,"Friedhof[TimeTo]") - (tonumber(time.timestamp) - getElementData(player,"Friedhof[TimeStart]") + getElementData(player,"Friedhof[Zeit]"))
		local minutes = math.floor(timeT / 60)
		local seconds = math.floor(((timeT / 60) %1) *60)
		if(timeT >= 0) then
			if(minutes ~= 0) then
				outputChatBox("Du musst hier noch "..tostring(minutes).." Minuten und "..tostring(seconds).." Sekunden verbringen!", player,170,170,170)
			else
				outputChatBox("Du musst hier noch "..tostring(timeT).." Sekunden verbringen!",player,170,170,170)
			end
		end
	else
		outputChatBox("Du bist nicht auf dem Friedhof!",player,110,110,110)
	end
end
addCommandHandler("friedhofzeit",zeit,false,false)

function beleben(player)
	if(client == player) then
		if(getElementData(player,"Friedhof[Tod]") ~= 1) then
			spawnPlayer(player,getElementData(player,"UnL","X"),getElementData(player,"UnL","Y"),getElementData(player,"UnL","Z"),getElementData(player,"UnL","Rotation"),getElementData(player,"UnL","Skin"))
			local x,y,z = getElementPosition(player)
			setCameraMatrix ( player, x, y, z + 5, x, y, z)
			triggerClientEvent(player,"doAnim",player) -- crack Animation wird ausgeführt + Player HUD's werden wieder angezeigt.
			setElementAlpha(player,255)
			setElementDimension(player,0)
			triggerClientEvent(player,"doEvent",player) -- Event wird ausgeführt ( Spieler steht auf )
		end
	end
end -- Event das beim Wiederbeleben vom Client getriggert wird, um Alpha und Dimension Public zu setzen und Spieler Posi zu verändern
addEvent("beleben",true)
addEventHandler("beleben",getRootElement(),beleben)

local function createDeathElements(z)
	if(source ~= client) then
		return 1
	end
	if(getElementData(source,"Friedhof[Tod]") ~= 1) then
		return 1
	end
		local player = source
		setElementData(player,"Friedhof[zTod]",z)
		local saved = mysql_query(Datenbank,"UPDATE `friedhof` SET `zTod`='"..MySQL_Save ( tostring(getElementData(source,"Friedhof[zTod]"))).."'  WHERE `Name`='"..MySQL_Save ( getPlayerName(source) ).."'")
		mysql_free_result ( saved )
end
addEvent("createDeathElements",true)
addEventHandler("createDeathElements",getRootElement(),createDeathElements)

local function calledTrue()
	if(source ~= client) then
		return 1
	end
	if(getElementData(source,"Friedhof[Tod]") ~= 1) then
		return 1
	end
	if(getElementData(source,"Friedhof[Transport]") == 0) then
		return 1
	end
	local player = source
	setElementData(source,"Friedhof[Called]",1)
	setElementData(player,"Friedhof[Transport]",0)
	createDeathMarker(player)
	deathPlayerBlip[player] =  createBlip(getElementData(player, "Friedhof[xTod]") , getElementData(player, "Friedhof[yTod]"), getElementData(player, "Friedhof[zTod]"),23,3)
	
	
	DPed[player] = createPed(getElementData(player,"UnL","Skin"),getElementData(player, "Friedhof[xTod]") , getElementData(player, "Friedhof[yTod]"), getElementData(player, "Friedhof[zTod]"))
	setElementData(DPed[player],"Name",getPlayerName(player))
	setPedAnimation(DPed[player],"CRACK","crckidle2",-1,true,false,false)
	setElementFrozen ( DPed[player], true )
	setElementCollisionsEnabled ( DPed[player], false )
	addEventHandler("onElementStartSync",DPed[player],syncDPed)
	
	setElementVisibleTo(deathPlayerBlip[player],getRootElement(),false)

	
end
addEvent("callTrue",true)
addEventHandler("callTrue",getRootElement(),calledTrue)

local function calledFalse()
	if(source ~= client) then
		return 1
	end
	if(getElementData(source,"Friedhof[Tod]") ~= 1) then
		return 1
	end
	setElementData(source,"Friedhof[Called]",1)
end
addEvent("callFalse",true)
addEventHandler("callFalse",getRootElement(),calledFalse)




function moneyFehlt()
	if(source ~= client) then
		return 1
	end
	local kosten = getElementData(getRootElement(),"Settings","deathPriceMultiple") * getElementData(source,"UnL","Level")
	outputChatBox("Aus irgend einem Grund lebst du wieder. Allerdings fehlen dir "..kosten.." $!",source,200,200,0)
end
addEvent("MInfoT",true)
addEventHandler("MInfoT",getRootElement(),moneyFehlt)

local deathMarker = {}
function createDeathMarker(dPlayer)
	deathMarker[dPlayer] = createMarker(getElementData(dPlayer, "Friedhof[xTod]") , getElementData(dPlayer, "Friedhof[yTod]"), getElementData(dPlayer, "Friedhof[zTod]"),"cylinder")
	setElementInterior(deathMarker[dPlayer],getElementData(dPlayer, "Friedhof[Interior]"))
	setElementDimension(deathMarker[dPlayer],getElementData(dPlayer, "Friedhof[Dimension]"))
	addEventHandler("onMarkerHit",deathMarker[dPlayer],onDeathMarkerHit)
	setElementVisibleTo ( deathMarker[dPlayer], getRootElement(), false )
end
function onDeathMarkerHit(player)
	if(getElementType(player) ~= "player") then
		return 1
	end
	if(getElementData(player,"Fraktionen[Fraktion]") == "Medic" and getElementData(player,"Dienst") == true) then
		local tplayer
		for i,v in pairs(deathMarker) do
			if(v == source) then
				tplayer = i
			end
		end
		local time = getRealTime()
		local tplayerD = getElementData(tplayer,"Friedhof[TimeTo]") - (tonumber(time.timestamp) - getElementData(tplayer,"Friedhof[TimeStart]") + getElementData(tplayer,"Friedhof[Zeit]"))
		local name = getPlayerName(tplayer)
		setData(player,"Infoid","Leiche",createInfobox(player,"Verletzter","Name: "..tostring(name).."\nDauer: "..tostring(tplayerD).." Sekunden \nInfo: Drücke >e< um den Patienten aufzuheben. Dannach kannst du ihn zum Krankenwagen tragen!","krankenhaus.png"))
	else
		local tplayer
		for i,v in pairs(deathMarker) do
			if(v == source) then
				tplayer = i
			end
		end
		local name = getPlayerName(tplayer)
		setData(player,"Infoid","Leiche",createInfobox(player,"Verletzter","Hier liegt "..tostring(name).." Er ist dem Tode nahe. Er braucht dringend eine medizinische Versorgung, sonst wird er sterben!","krankenhaus.png"))
	end
	
	addEventHandler("onPlayerMarkerLeave",player,onDeathMarkerLeave)
end
function onDeathMarkerLeave(marker)
		destroyInfobox(source,getElementData(source,"Infoid","Leiche"))
		removeEventHandler("onPlayerMarkerLeave",source,onDeathMarkerLeave)
end
function destroyDeathMarker(dPlayer)
	local players = getElementsByType("player")
	for index,value in ipairs(players) do
		if(isElementWithinMarker(value,deathMarker[dPlayer])) then
			removeEventHandler("onPlayerMarkerLeave",value,onDeathMarkerLeave)
			destroyInfobox(value,getElementData(value,"Infoid","Leiche"))
		end
	end

	if(deathMarker[dPlayer]) then
		destroyElement(deathMarker[dPlayer])
		deathMarker[dPlayer] = nil
	end
end




