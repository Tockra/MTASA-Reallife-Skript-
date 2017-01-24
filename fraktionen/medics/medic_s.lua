local medicVehicle = { [416]=true}
local loadPickup = {}
local Lbutton = {}
local tragen = {}
local tragenATime = {}
local tragenTimeTo = {}
local aspam = {}
local loadTimer = {}
local dLocked = {}

local function mTeamchat(message, messagetype)
	if(messagetype == 2) then
		local team = getPlayerTeam(source)
		local tn= getTeamName(team)
		if(tn == "Medic") then
			if(getElementData(source,"Dienst") ~= true) then
				outputChatBox("Du hast dein Funkgerät nicht dabei!",source,175,175,175)
				return 1
			end
			if(team) then
				local players = getPlayersInTeam(team)
				for i,v in ipairs(players) do
					if(getElementData(v,"Dienst") == true and getElementData(v,"Fraktionen[Fraktion]") == "Medic") then
						outputChatBox("["..getElementData(source,"Fraktionen[Rang]").."]"..getPlayerName(source)..": "..message,v,100,149,237)
					end
				end
			end
		end
		
	end
end
addEventHandler("onPlayerChat",getRootElement(),mTeamchat) -- Teamchat

local function onEnter(player,seat) -- Block Medic Vehicle Enter
	local model = getElementModel(source)
	if(medicVehicle[model]) then
		if(seat == 0) then
			if(getElementData(player,"Fraktionen[Fraktion]") ~= "Medic") then
				cancelEvent()
				outputChatBox("Du traust dich nicht das Fahrzeug zu stehlen, da es vielleicht noch benötigt wird!",player,175,175,175)
				return 1
			end
			if(getElementData(player,"Dienst") ~= true) then
				cancelEvent()
				outputChatBox("Du darfst das Fahrzeug nicht benutzen, wenn du nicht im Dienst bist!",player,175,175,175)
			end
		
		end
	end
	if(getElementData(player,"Fraktionen[Fraktion]") == "Medic" and getElementData(player,"Dienst") == true and tragen[player]) then
		outputChatBox("* Du legst "..tostring(tragen[player]).." vorsichtig ab und steigst in das Fahrzeug.",player,51,204,255)
		dLocked[player] = false
		local tplayer = getPlayerFromName(tragen[player])
		if(tplayer) then
			if(getElementData(tplayer,"Friedhof[Tod]") == 1) then
				setElementData(tplayer,"Friedhof[Transport]",0,false)
				createDeathMarker(tplayer)
				deathPlayerBlip[tplayer] =  createBlip(getElementData(tplayer, "Friedhof[xTod]") , getElementData(tplayer, "Friedhof[yTod]"), getElementData(tplayer, "Friedhof[zTod]"),23,3)
				setElementVisibleTo(deathPlayerBlip[tplayer],getRootElement(),false)
				
				DPed[tplayer] = createPed(getElementData(tplayer,"UnL","Skin"),getElementData(tplayer, "Friedhof[xTod]") , getElementData(tplayer, "Friedhof[yTod]"), getElementData(tplayer, "Friedhof[zTod]"))
				setElementData(DPed[tplayer],"Name",getPlayerName(tplayer))
				setPedAnimation(DPed[tplayer],"CRACK","crckidle2",-1,true,false,false)
				setElementFrozen ( DPed[tplayer], true )
				setElementCollisionsEnabled ( DPed[tplayer], false )
				addEventHandler("onElementStartSync",DPed[tplayer],syncDPed)
				
		

			end
		else
			local save = mysql_query(Datenbank,"UPDATE `friedhof` SET `Transport`='"..MySQL_Save ( tostring(0)).."' WHERE `Name`='"..MySQL_Save ( tragen[player] ).."'")
			mysql_free_result(save)
		end
		tragen[player] = nil
		tragenATime[player] = nil
		tragenTimeTo[player] = nil
	end
end
addEventHandler("onVehicleStartEnter",getRootElement(),onEnter)

function blipUpd(player)
	for i,v in pairs(deathPlayerBlip) do
		if(getElementData(i,"Friedhof[Tod]") == 1) then
			setElementVisibleTo(v,player,true)
		end
	end
end

function showBlips(player,seat)
if(medicVehicle[getElementModel(source)]) then
	if(getElementData(player,"Fraktionen[Fraktion]") =="Medic") then
		if(getElementData(player,"Dienst") == true) then
			if(seat == 0) then
			bindKey(player,"F11","down",blipUpd,player)
			bindKey(player,"lshift","down",loadKW,player)
			bindKey(player,"rshift","down",unloadKW,player)
				for i,v in pairs(deathPlayerBlip) do
					if(getElementData(i,"Friedhof[Tod]") == 1) then
						setElementVisibleTo(v,player,true)
					end
				end
			end
		end
	end
end
end
addEventHandler ( "onVehicleEnter", getRootElement(), showBlips )

function hideBlips(player,seat)
if(medicVehicle[getElementModel(source)]) then
	triggerClientEvent(player,"exitCV",player,source,player,seat)
	unbindKey ( player, "F11")
	unbindKey(player,"lshift")
	unbindKey(player,"rshift")
	if(getElementData(player,"Fraktionen[Fraktion]") =="Medic") then
			for i,v in pairs(deathPlayerBlip) do
				if(getElementData(i,"Friedhof[Tod]") == 1) then
					setElementVisibleTo(v,player,false)
				end
			end
	end
end
end
addEventHandler("onVehicleStartExit",getRootElement(),hideBlips)

local function onW()
	unbindKey ( source, "F11")
	unbindKey(source,"lshift")
	unbindKey(source,"rshift")
	unbindKey(source,"e","down",onTragen)
	if(getElementData(source,"Fraktionen[Fraktion]") =="Medic") then
		for i,v in pairs(deathPlayerBlip) do
			if(getElementData(i,"Friedhof[Tod]") == 1) then
				setElementVisibleTo(v,source,false)
			end
		end
	end
end
addEventHandler("onPlayerWasted",getRootElement(),onW)

function dutyMedic(player)
	if(getElementData(player,"Fraktionen[Fraktion]") ~= "Medic") then
		return 1
	end
	local x,y,z = getElementPosition(player)
	if(getDistanceBetweenPoints3D(1172.9,-1323.3269042969,15.402950286865,x,y,z) <= 1.5) then
		if(getElementData(player,"Dienst") ~= true) then
			if(getElementData(player,"DutyLock") == true) then
				return 1
			end
			setElementData(player,"Dienst",true)
			triggerClientEvent(player,"MedicDuty",player,false,getElementData(player,"Fraktionen[Skin]"))
			bindKey(player,"e","down",onTragen)
			setElementData(player,"DutyLock",true,true)

		elseif(getElementData(player,"Dienst") == true) then
			if(tragen[player]) then
				outputChatBox("Du trägst noch einen Patienten. Du kannst den Dienst nicht abbrechen!",player,175,175,175)
				return 1
			end
			if(dLocked[player] == true) then
				return 1
			end
			if(getElementData(player,"DutyLock") == true) then
				return 1
			end
			setElementData(player,"Dienst",false)
			unbindKey(player,"e","down",onTragen)
			triggerClientEvent(player,"MedicDuty",player,true,getElementData(player,"UnL","Skin"))
			setElementData(player,"DutyLock",true,true)
		end

	end
end


function onPlayerGetFraktionsData(fraktion)
	if(fraktion == "Medic") then
		bindKey(source,"e","down",dutyMedic)
	end
end
addEvent("onPlayerGetFraktionsData",true)
addEventHandler("onPlayerGetFraktionsData",getRootElement(),onPlayerGetFraktionsData)

-- A = Abstand
-- R = Blickrichtung
-- X = X Pos
-- Y = Y Pos
-- X(R) =
-- Y(R) = 
-- X(0) = X² + A
-- Y(0) = 0
-- X(90) = Y 

local function getPlayerFrontPos(player)
	if(getPedOccupiedVehicle ( player )) then
		local abstand = 5
		local x,y,z = getElementPosition(getPedOccupiedVehicle ( player ))
		rx,ry, rota = getElementRotation ( getPedOccupiedVehicle ( player ) )
		local nx = math.sin(math.rad(rota)) * abstand
		local ny = math.sqrt(abstand^2 - nx^2)
	
		if(rota <=90 or rota >=270) then
			createPickup(x + nx,y - ny,z,3,1239,2000)
			setVehicleDoorState ( getPedOccupiedVehicle ( player ), 3, 1 )
			--createObject(1337,x + nx,y - ny,z)
		elseif(rota > 90 and rota < 270) then
			createPickup(x + nx,y + ny,z,1239,2000)
			setVehicleDoorState ( getPedOccupiedVehicle ( player ), 3, 1 )
			--createObject(1337,x + nx,y + ny,z)
		end
		
		outputChatBox(tostring(rx))
	end
end
--addCommandHandler("vor",getPlayerFrontPos)
local function setSkin(player,skin)
	if(player ~= client) then
		return 1
	end
	
	if(skin ~= getElementData(player,"UnL","Skin") and skin ~= getElementData(player,"Fraktionen[Skin]")) then
		return 1
	end
	
	setElementModel(player,skin)
end

addEvent("setPSkin",true)
addEventHandler("setPSkin",getRootElement(),setSkin)


function loadKW(player)
	--[[local time = getRealTime()
	if(tonumber(aspam[player])) then
		if(time.timestamp <= aspam[player] + 2) then
			return 1
		end
		aspam[player]= time.timestamp
	else
		aspam[player]= time.timestamp
	end]]
	if(antiSpam(player)) then
		return 1
	end
	
	local vehicle = getPedOccupiedVehicle ( player )
	if(getElementSpeed(vehicle) == 0) then
		if(Lbutton[vehicle] ~= true) then
			local abstand = 5
			local x,y,z = getElementPosition(vehicle)
			rx,ry,rz = getElementRotation ( vehicle )
			local nx = math.sin(math.rad(rz)) * abstand
			local ny = math.sqrt(abstand^2 - nx^2)
		
			if(rz <=90 or rz >=270) then
				--loadPickup[vehicle] = createPickup(x + nx,y - ny,z,3,1239,2000)
				triggerClientEvent(player,"getGroundOfKPickup",player,x + nx,y - ny,z)
				setElementFrozen ( vehicle, true)
				outputChatBox("Nun kannst du Patienten mitnehmen",player,170,51,51)
				--addEventHandler("onPickupHit",loadPickup[vehicle],loadP)
				setVehicleDoorOpenRatio(vehicle,5,1,600)
				setVehicleDoorOpenRatio(vehicle,4,1,600)
				
				Lbutton[vehicle] = true
			elseif(rz > 90 and rz < 270) then
				--loadPickup[vehicle] = createPickup(x + nx,y + ny,z,3,1239,2000)
				triggerClientEvent(player,"getGroundOfKPickup",player,x + nx,y + ny,z)
				setElementFrozen ( vehicle, true )
				outputChatBox("Nun kannst du Patienten mitnehmen",player,170,51,51)
				--[[if(loadPickup[vehicle]) then
					addEventHandler("onPickupHit",loadPickup[vehicle],loadP)
				end]]
				Lbutton[vehicle] = true
				setVehicleDoorOpenRatio(vehicle,5,1,600)
				setVehicleDoorOpenRatio(vehicle,4,1,600)
			end
		elseif(Lbutton[vehicle] ==true) then
			if(loadPickup[vehicle]) then
				removeEventHandler("onPickupHit",loadPickup[vehicle],loadP)
				destroyElement(loadPickup[vehicle])
				loadPickup[vehicle] = nil
			end
			setElementFrozen ( vehicle, false )
			Lbutton[vehicle]= false	
			setVehicleDoorOpenRatio(vehicle,5,0,600)
			setVehicleDoorOpenRatio(vehicle,4,0,600)
		end
	else
		outputChatBox("Der Krankenwagen muss zum Stillstand kommen, bevor man ihn beladen kann!",player,175,175,175)
	end
end

local function createP(player,x,y,z)
	if(player ~= client) then
		return 0
	end
	
	local vehicle = getPedOccupiedVehicle ( player )
	loadPickup[vehicle] = createPickup(x,y,z,3,1239,2000)
	if(loadPickup[vehicle]) then
		addEventHandler("onPickupHit",loadPickup[vehicle],loadP)
	end
end
addEvent("createKPickupG",true)
addEventHandler("createKPickupG",getRootElement(),createP)
local krankenHaus = {}
krankenHaus[1] = {["x"]=1177.6102294922,["y"]=-1323.4741210938,["z"]=14.079194068909,["rota"]=270 }
krankenHaus[2] = {["x"]=2018.4805908203,["y"]=-1429.56640625,["z"]=13.541042327881,["rota"]=135 }
function unloadKW(player)
	local time = getRealTime()
	local krahaus 
	if(tonumber(aspam[player])) then
		if(time.timestamp <= aspam[player] + 2) then
			return 1
		end
		aspam[player]= time.timestamp
	else
		aspam[player]= time.timestamp
	end
	
	local veh = getPedOccupiedVehicle(player)
	local x,y,z = getElementPosition(veh)
	if(getDistanceBetweenPoints3D(x,y,z,1177.8601074219,-1308.1912841797,13.830633163452) <= 5) then
		krahaus = 1
	elseif(getDistanceBetweenPoints3D(x,y,z,2030.5870361328,-1417.9331054688,16.9921875) <= 5 ) then
		krahaus = 2
	else
		outputChatBox("Du bist an keinem Krankenhaus",player,175,175,175)
		return 1
	end
	
	if(getElementSpeed(veh) ~= 0) then
		outputChatBox("Der Krankenwagen muss stehen, damit er entladen werden kann!",player,175,175,175)
		return 1
	end
	if(getElementData(veh,"LoadA") == false and getElementData(veh,"LoadB") == false and getElementData(veh,"LoadC") == false) then
		outputChatBox("Es befindet sich kein Patient im Krankenwagen!",player,175,175,175)
		return 1
	end
	
	if(getElementData(veh,"LoadA")) then
		local tplayer = getPlayerFromName(getElementData(veh,"LoadA"))
		if(tplayer) then
			setElementData(tplayer,"Friedhof[Krankenhaus]",krahaus,true)
			setData(tplayer,"UnL","X",krankenHaus[krahaus]["x"],false)
			setData(tplayer,"UnL","Y",krankenHaus[krahaus]["y"],false)
			setData(tplayer,"UnL","Z",krankenHaus[krahaus]["z"],false)
			setData(tplayer,"UnL","Rotation",krankenHaus[krahaus]["rota"],false)
			local kosten = -getElementData(getRootElement(),"Settings","hospitalPriceMultiple") * getElementData(tplayer,"UnL","Level")
			giveMoney(tplayer,kosten)
			setFraktionskasse("Medic",math.abs(kosten))
			setFriedhofDataNil(tplayer)
			killTimer(timer[tplayer])
			triggerClientEvent(tplayer,"relifeKW",tplayer,getElementModel ( player))
			triggerClientEvent(tplayer,"setWeatherKW",tplayer,WetterID)
		else
			local delete = mysql_query(Datenbank,"DELETE FROM `friedhof` WHERE `Name`='"..MySQL_Save( getElementData(veh,"LoadA")).."'")
			mysql_free_result(delete)
			local result = mysql_query(Datenbank,"SELECT * FROM `benutzertabelle` WHERE `Benutzername`='"..MySQL_Save( getElementData(veh,"LoadA")).."'")
			local data = mysql_fetch_assoc(result)
			mysql_free_result(result)
			local tempData = {}
			for index, value in pairs(data) do
				tempData[index] = value
			end
			local kosten = getElementData(getRootElement(),"Settings","hospitalPriceMultiple") * tempData["Level"]
			local money = tempData["GeldH"] - kosten
			setFraktionskasse("Medic",kosten)
			local saved = mysql_query(Datenbank,"UPDATE `benutzertabelle` SET `X`='"..MySQL_Save( krankenHaus[krahaus]["x"] ).."' , `Y`='"..MySQL_Save(krankenHaus[krahaus]["y"]).."' , `Z`='"..MySQL_Save(krankenHaus[krahaus]["z"]).."' , `Rotation`='"..MySQL_Save(krankenHaus[krahaus]["rota"]).."' , `Krankenhaus`='"..MySQL_Save(krahaus).."' , `GeldH`='"..MySQL_Save(money).."' WHERE `Benutzername`='"..MySQL_Save ( getElementData(veh,"LoadA") ).."'")
			mysql_free_result(saved)
		end
		setElementData(veh,"LoadA",false,true)
		setElementData(veh,"LoadATime",false,true)
		setElementData(veh,"LoadACTime",false,true)
		setElementData(veh,"LoadALoadTime",false,true)
	end
	
	if(getElementData(veh,"LoadB") ) then
		local tplayer = getPlayerFromName(getElementData(veh,"LoadB"))
		if(tplayer) then
			setElementData(tplayer,"Friedhof[Krankenhaus]",krahaus,true)
			setData(tplayer,"UnL","X",krankenHaus[krahaus]["x"])
			setData(tplayer,"UnL","Y",krankenHaus[krahaus]["y"])
			setData(tplayer,"UnL","Z",krankenHaus[krahaus]["z"])
			setData(tplayer,"UnL","Rotation",krankenHaus[krahaus]["rota"],false)
			local kosten = -getElementData(getRootElement(),"Settings","hospitalPriceMultiple") * getElementData(tplayer,"UnL","Level")
			giveMoney(tplayer,kosten)
			setFraktionskasse("Medic",math.abs(kosten))
			setFriedhofDataNil(tplayer)
			killTimer(timer[tplayer])
			triggerClientEvent(tplayer,"relifeKW",tplayer,getElementModel ( player))
			triggerClientEvent(tplayer,"setWeatherKW",tplayer,WetterID)
		else
			local delete = mysql_query(Datenbank,"DELETE FROM `friedhof` WHERE `Name`='"..MySQL_Save( getElementData(veh,"LoadB")).."'")
			mysql_free_result(delete)
			local result = mysql_query(Datenbank,"SELECT * FROM `benutzertabelle` WHERE `Benutzername`='"..MySQL_Save( getElementData(veh,"LoadB")).."'")
			local data = mysql_fetch_assoc(result)
			mysql_free_result(result)
			local tempData = {}
			for index, value in pairs(data) do
				tempData[index] = value
			end
			local kosten = getElementData(getRootElement(),"Settings","hospitalPriceMultiple") * tempData["Level"]
			local money = tempData["GeldH"] - kosten
			setFraktionskasse("Medic",kosten)
			local saved = mysql_query(Datenbank,"UPDATE `benutzertabelle` SET `X`='"..MySQL_Save( krankenHaus[krahaus]["x"] ).."' , `Y`='"..MySQL_Save(krankenHaus[krahaus]["y"]).."' , `Z`='"..MySQL_Save(krankenHaus[krahaus]["z"]).."' , `Rotation`='"..MySQL_Save(krankenHaus[krahaus]["rota"]).."' , `Krankenhaus`='"..MySQL_Save(krahaus).."' , `GeldH`='"..MySQL_Save(money).."' WHERE `Benutzername`='"..MySQL_Save ( getElementData(veh,"LoadB") ).."'")
			mysql_free_result(saved)
		end
		setElementData(veh,"LoadB",false,true)
		setElementData(veh,"LoadBTime",false,true)
		setElementData(veh,"LoadBCTime",false,true)
		setElementData(veh,"LoadBLoadTime",false,true)			
	end
	
	if(getElementData(veh,"LoadC") ) then
		local tplayer = getPlayerFromName(getElementData(veh,"LoadC"))
		if(tplayer) then
			setElementData(tplayer,"Friedhof[Krankenhaus]",krahaus,true)
			setData(tplayer,"UnL","X",krankenHaus[krahaus]["x"],false)
			setData(tplayer,"UnL","Y",krankenHaus[krahaus]["y"],false)
			setData(tplayer,"UnL","Z",krankenHaus[krahaus]["z"],false)
			setData(tplayer,"UnL","Rotation",krankenHaus[krahaus]["rota"],false)
			local kosten = -getElementData(getRootElement(),"Settings","hospitalPriceMultiple") * getElementData(tplayer,"UnL","Level")
			giveMoney(tplayer,kosten)
			setFraktionskasse("Medic",math.abs(kosten))
			setFriedhofDataNil(tplayer)
			killTimer(timer[tplayer])
			triggerClientEvent(tplayer,"relifeKW",tplayer,getElementModel ( player))
			triggerClientEvent(tplayer,"setWeatherKW",tplayer,WetterID)
		else
			local delete = mysql_query(Datenbank,"DELETE FROM `friedhof` WHERE `Name`='"..MySQL_Save( getElementData(veh,"LoadC")).."'")
			mysql_free_result(delete)
			local result = mysql_query(Datenbank,"SELECT * FROM `benutzertabelle` WHERE `Benutzername`='"..MySQL_Save( getElementData(veh,"LoadC")).."'")
			local data = mysql_fetch_assoc(result)
			mysql_free_result(result)
			local tempData = {}
			for index, value in pairs(data) do
				tempData[index] = value
			end
			local kosten = getElementData(getRootElement(),"Settings","hospitalPriceMultiple") * tempData["Level"]
			local money = tempData["GeldH"] - kosten
			setFraktionskasse("Medic",kosten)
			local saved = mysql_query(Datenbank,"UPDATE `benutzertabelle` SET `X`='"..MySQL_Save( krankenHaus[krahaus]["x"] ).."' , `Y`='"..MySQL_Save(krankenHaus[krahaus]["y"]).."' , `Z`='"..MySQL_Save(krankenHaus[krahaus]["z"]).."' , `Rotation`='"..MySQL_Save(krankenHaus[krahaus]["rota"]).."' , `Krankenhaus`='"..MySQL_Save(krahaus).."' , `GeldH`='"..MySQL_Save(money).."' WHERE `Benutzername`='"..MySQL_Save ( getElementData(veh,"LoadC") ).."'")
			mysql_free_result(saved)
		end
		setElementData(veh,"LoadC",false,true)
		setElementData(veh,"LoadCTime",false,true)
		setElementData(veh,"LoadCCTime",false,true)
		setElementData(veh,"LoadCLoadTime",false,true)
		outputChatBox("Du hast den Krankenwagen erfolgreich entladen!",player,51,204,255)
	end
end

function loadP(player)

	if(getElementData(player,"Fraktionen[Fraktion]") == "Medic" and getElementData(player,"Dienst") == true) then
		setData(player,"Infoid","Krankenwagen",createInfobox(player, "Krankenwagen","Wenn du einen Patienten trägst, kannst du diesen mit >e< in den Krankenwagen legen! Du kannst bis zu 3 Patienten zur gleichen Zeit in diesem Krankenwagen transportieren. Der Fahrer hat eine Übersicht über alle seine Patienten!","krankenhaus.png",false,15000))
	end
end

local function onExplode()
	if(medicVehicle[getElementModel(source)]) then
		if(loadPickup[source]) then
			removeEventHandler("onPickupHit",loadPickup[source],loadP)
			destroyElement(loadPickup[source])
			loadPickup[source] = nil
		end
		
		if(loadTimer[source]) then
			killTimer(loadTimer[source])
			loadTimer[source] = nil
		end
	
		
	end
end
addEventHandler("onVehicleExplode",getRootElement(),onExplode)

function onTragen(player)
	if(getElementData(player,"Fraktionen[Fraktion]") == "Medic") then
		
		if(getElementData(player,"Dienst") ~= true) then
			return 1
		end
		
		if(getPedOccupiedVehicle(player)) then
			return 1
		end
		
		if(antiSpam(player)) then
			return 1
		end
		onTragenF(player)
		onEinladen(player)


	end
end

function onTragenF(player)	
		local ped = getElementsByType("ped")
		local distance = 2.6
		local x,y,z = getElementPosition(player)
		local dPlayer = false
		for index,value in pairs(DPed) do
			local bx,by,bz = getElementPosition(value)
			if(getDistanceBetweenPoints3D(x,y,z,bx,by,bz) < distance) then
				dPlayer = index
				distance = getDistanceBetweenPoints3D(x,y,z,bx,by,bz)
			end
		end
		if(dPlayer == false) then
			return 1
		end
		if(tragen[player]) then
			outputChatBox("Du trägst bereits einen Patienten!",player,175,175,175)
			return 1
		end
		dLocked[player] = true
		local time = getRealTime()
		local zeit = getElementData(dPlayer,"Friedhof[TimeTo]") - (tonumber(time.timestamp) - getElementData(dPlayer,"Friedhof[TimeStart]") + getElementData(dPlayer,"Friedhof[Zeit]"))
		setElementData(dPlayer,"Friedhof[Transport]",1,false)
		destroyDeathMarker(dPlayer)
		destroyElement(deathPlayerBlip[dPlayer])
		deathPlayerBlip[dPlayer] = nil
		removeEventHandler("onElementStartSync",DPed[dPlayer],syncDPed)
		destroyElement(DPed[dPlayer])
		DPed[dPlayer] = nil
		tragen[player] = getPlayerName(dPlayer)
		tragenATime[player] = time.timestamp
		tragenTimeTo[player] = zeit
		outputChatBoxInRange(20,"* "..getPlayerName(player).." hebt den regungslosen Körper von "..tragen[player].." auf!",player, 51,204,255)
		outputChatBox("* Du hebst den regungslosen Körper von "..tragen[player].." auf!",player, 51,204,255)
end

function onEinladen(player)
		if(tragen[player] == nil) then
			return 1
		end
		local odistance = 2
		local vehicle
		local distance
		local time = getRealTime()
		local px,py,pz = getElementPosition(player)
		for i,v in pairs(loadPickup) do
				local x,y,z = getElementPosition(v)
				local distance = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
				if(distance <= 1.5) then
					if(odistance > distance) then
						odistance = distance
						vehicle = i
					end
				end
		end
		if(vehicle == nil) then
			return 1
		end
		
		if(tragenTimeTo[player] -(time.timestamp - tragenATime[player]) <= 0) then
			outputChatBox(tragen[player].." ist gestorben während du ihn getragen hast!",player,51,204,255)
			clearTragen(player)
			return 1
		end
		if(vehicle) then
			if(getElementData(vehicle,"LoadA") == false) then
				setElementData(vehicle,"LoadA",tragen[player],true)
				setElementData(vehicle,"LoadATime",tragenTimeTo[player] -(time.timestamp - tragenATime[player]),true)
				setElementData(vehicle,"LoadALoadTime",time.timestamp,true)
			elseif(getElementData(vehicle,"LoadB") == false) then
				setElementData(vehicle,"LoadB",tragen[player],true)
				setElementData(vehicle,"LoadBTime",tragenTimeTo[player] -(time.timestamp - tragenATime[player]),true)
				setElementData(vehicle,"LoadBLoadTime",time.timestamp,true)
			elseif(getElementData(vehicle,"LoadC") == false) then
				setElementData(vehicle,"LoadC",tragen[player],true)
				setElementData(vehicle,"LoadCTime",tragenTimeTo[player] -(time.timestamp - tragenATime[player]),true)
				setElementData(vehicle,"LoadCLoadTime",time.timestamp,true)
			else 
				outputChatBox("Der Krankenwagen ist voll. Du kannst keine weiteren Patienten mitnehmen!",player,175,175,175)
				return 1
			end
			if(loadTimer[vehicle] == nil) then
				loadTimer[vehicle] = setTimer(lTimer,500,0,vehicle)
			end
			outputChatBox("* Du legst "..tragen[player].." in den Krankenwagen",player,51,204,255)
			dLocked[player] = false
			outputChatBoxInRange(20,"* "..getPlayerName(player).." legt "..tragen[player].." in den Krankenwagen",player,51,204,255)
			clearTragen(player)
			if(getElementData(player,"Infoid","Krankenwagen")) then
				destroyInfobox(player,getElementData(player,"Infoid","Krankenwagen"))
			end
		end
end

local function onMedicQuit()

if(getElementData(source,"Fraktionen[Fraktion]") == "Medic" and getElementData(source,"Dienst") == true) then
	if(tragen[source]) then
		local tplayer = getPlayerFromName(tragen[source])
		if(tplayer) then
			setElementData(tplayer,"Friedhof[Transport]",0,false)
			createDeathMarker(tplayer)
			deathPlayerBlip[tplayer] =  createBlip(getElementData(tplayer, "Friedhof[xTod]") , getElementData(tplayer, "Friedhof[yTod]"), getElementData(tplayer, "Friedhof[zTod]"),23,3)
			setElementVisibleTo(deathPlayerBlip[tplayer],getRootElement(),false)
			
			DPed[tplayer] = createPed(getElementData(tplayer,"UnL","Skin"),getElementData(tplayer, "Friedhof[xTod]") , getElementData(tplayer, "Friedhof[yTod]"), getElementData(tplayer, "Friedhof[zTod]"))
			setElementData(DPed[tplayer],"Name",getPlayerName(tplayer))
			setElementFrozen(DPed[tplayer],"CRACK","crckidle2",-1,true,false,false)
			setElementFrozen ( DPed[tplayer], true )
			setElementCollisionsEnabled ( DPed[tplayer], false )
			addEventHandler("onElementStartSync",DPed[tplayer],syncDPed)
			
		else
			local save = mysql_query(Datenbank,"UPDATE `friedhof` SET `Transport`='"..MySQL_Save ( tostring(0)).."' WHERE `Name`='"..MySQL_Save ( tragen[source] ).."'")
			mysql_free_result(save)
		end

		tragenATime[source] = nil
		tragenTimeTo[source] = nil
		tragen[source] = nil
	end
end
unbindKey(source,"e","down",onTragen)
unbindKey(source,"e","down",dutyMedic)
end
addEventHandler("onPlayerQuit",getRootElement(),onMedicQuit)

function syncDPed()
	setPedAnimation(source,"CRACK","crckidle2",-1,true,false,false)
end

--[[local function onEinladen(player)
	if(getElementData(player,"Fraktionen[Fraktion]") == "Medic") then
		local odistance = 2
		local vehicle
		local distance
		local time = getRealTime()
		for i,v in pairs(loadPickup) do
				local x,y,z = getElementPosition(v)
				local px,py,pz = getElementPosition(player)
				local distance = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
				if(distance <= 1.5) then
					if(odistance > distance) then
						odistance = distance
						vehicle = i
					end
				end
		end
		if(vehicle == nil) then
			outputChatBox("Du stehst nicht vor der Tür eines Krankenwagens",player,175,175,175)
			return 1
		end
		
		if(tragen[player] == nil) then
			outputChatBox("Du musst jemanden bei dir haben, den du in den Krankenwagen legen möchtest!",player,175,175,175)
			return 1
		end
		if(tragenTimeTo[player] -(time.timestamp - tragenATime[player]) <= 0) then
			outputChatBox(tragen[player].." ist gestorben während du ihn getragen hast!",player,51,204,255)
			clearTragen(player)
			return 1
		end
		if(vehicle) then
			if(getElementData(vehicle,"LoadA") == false) then
				setElementData(vehicle,"LoadA",tragen[player],true)
				setElementData(vehicle,"LoadATime",tragenTimeTo[player] -(time.timestamp - tragenATime[player]),true)
				setElementData(vehicle,"LoadALoadTime",time.timestamp,true)
			elseif(getElementData(vehicle,"LoadB") == false) then
				setElementData(vehicle,"LoadB",tragen[player],true)
				setElementData(vehicle,"LoadBTime",tragenTimeTo[player] -(time.timestamp - tragenATime[player]),true)
				setElementData(vehicle,"LoadBLoadTime",time.timestamp,true)
			elseif(getElementData(vehicle,"LoadC") == false) then
				setElementData(vehicle,"LoadC",tragen[player],true)
				setElementData(vehicle,"LoadCTime",tragenTimeTo[player] -(time.timestamp - tragenATime[player]),true)
				setElementData(vehicle,"LoadCLoadTime",time.timestamp,true)
			else 
				outputChatBox("Der Krankenwagen ist voll. Du kannst keine weiteren Patienten mitnehmen!",player,175,175,175)
				return 1
			end
			if(loadTimer[vehicle] == nil) then
				loadTimer[vehicle] = setTimer(lTimer,500,0,vehicle)
			end
			outputChatBox("* Du legst "..tragen[player].." in den Krankenwagen",player,51,204,255)
			outputChatBoxInRange(20,"* "..getPlayerName(player).." legt "..tragen[player].." in den Krankenwagen",player,51,204,255)
			clearTragen(player)
		
		end
	end
end
addCommandHandler("einladen",onEinladen,false,false)]]

function clearTragen(player) 
	tragen[player] = nil
	tragenATime[player] = nil
	tragenTimeTo[player] = nil
end

function lTimer(veh)
	local time = getRealTime()
	local target = getVehicleOccupant(veh)
	if(getElementData(veh,"LoadA")) then
		if(getElementData(veh,"LoadATime") -(time.timestamp - getElementData(veh,"LoadALoadTime")) > 0) then
			setElementData(veh,"LoadACTime", getElementData(veh,"LoadATime") -(time.timestamp - getElementData(veh,"LoadALoadTime")),true)
		else
			outputChatBox(getElementData(veh,"LoadA").." ist verstorben. Du warst nicht schnell genug!",target,170,51,51)
			setElementData(veh,"LoadA",false,true)
			setElementData(veh,"LoadATime",false,true)
			setElementData(veh,"LoadACTime",false,true)
			setElementData(veh,"LoadALoadTime",false,true)
		end
	end
	if(getElementData(veh,"LoadB")) then
		if(getElementData(veh,"LoadBTime") -(time.timestamp - getElementData(veh,"LoadBLoadTime")) > 0) then
			setElementData(veh,"LoadBCTime", getElementData(veh,"LoadBTime") -(time.timestamp - getElementData(veh,"LoadBLoadTime")),true)
		else
			outputChatBox(getElementData(veh,"LoadB").." ist verstorben. Du warst nicht schnell genug!",target,170,51,51)
			setElementData(veh,"LoadB",false,true)
			setElementData(veh,"LoadBTime",false,true)
			setElementData(veh,"LoadBCTime",false,true)
			setElementData(veh,"LoadBLoadTime",false,true)
		end
	end
	if(getElementData(veh,"LoadC")) then
		if(getElementData(veh,"LoadCTime") -(time.timestamp - getElementData(veh,"LoadCLoadTime")) > 0) then
			setElementData(veh,"LoadCCTime", getElementData(veh,"LoadCTime") -(time.timestamp - getElementData(veh,"LoadCLoadTime")),true)
		else
			outputChatBox(getElementData(veh,"LoadC").." ist verstorben. Du warst nicht schnell genug!",target,170,51,51)
			setElementData(veh,"LoadC",false,true)
			setElementData(veh,"LoadCTime",false,true)
			setElementData(veh,"LoadCCTime",false,true)
			setElementData(veh,"LoadCLoadTime",false,true)
		end
	end

	if(getElementData(veh,"LoadA") == false and getElementData(veh,"LoadB") == false and getElementData(veh,"LoadC") == false) then
		killTimer(loadTimer[veh])
		loadTimer[veh] = nil
	end
end

function checkKrankenhaus(player)
	if(getElementData(player,"UnL","Krankenhaus") == 1) then
		createInfobox(player,"Krankenhaus","Während du offline warst wurdest du von einem Sanitäter wiederbelebt. Dies hat dich "..getElementData(getRootElement(),"Settings","hospitalPriceMultiple") * getElementData(player,"UnL","Level").." $ gekostet. Wenn du bei deinem nächsten Besuch ein höheres Level erreicht hast, wird die Behandlung noch teurer!","krankenhaus.png")
		local saved = mysql_query(Datenbank,"UPDATE `benutzertabelle` SET `Krankenhaus`='0' WHERE `Benutzername`='"..MySQL_Save ( getPlayerName(player) ).."'")
		mysql_free_result ( saved ) 
	end
end

local function spawnPlayerK(player)
if(client == player) then
	if(getElementData(player,"UnL","Krankenhaus")) then
		local kosten = getElementData(getRootElement(),"Settings","hospitalPriceMultiple") * getElementData(player,"UnL","Level")
		outputChatBox("Der Krankenhausbesuch hat dich "..kosten.." $ gekostet!",player,170,51,51)
		fadeCamera(player,true,1)
		setElementAlpha(player,255)
		setElementDimension(player,0)
		spawnPlayer(player,getElementData(player,"UnL","X"),getElementData(player,"UnL","Y"),getElementData(player,"UnL","Z"),getElementData(player,"UnL","Rotation"),getElementData(player,"UnL","Skin"))
	end
end
end
addEvent("spawnPlayerK",true)
addEventHandler("spawnPlayerK",getRootElement(),spawnPlayerK)

local function onFraktionLeave(fraktion)
	if(fraktion == "Medic") then
		unbindKey(source,"e","down",onTragen)
		unbindKey(source,"e","down",dutyMedic)
	end
end
addEvent("onPlayerFraktionLeave",true)
addEventHandler("onPlayerFraktionLeave",getRootElement(),onFraktionLeave)

local function onFraktionJoin(fraktion)
	if(fraktion ~= "Medic") then
		return 1
	end
	bindKey(source,"e","down",dutyMedic)
end
addEvent("onPlayerFraktionJoin",true)
addEventHandler("onPlayerFraktionJoin",getRootElement(),onFraktionJoin)



