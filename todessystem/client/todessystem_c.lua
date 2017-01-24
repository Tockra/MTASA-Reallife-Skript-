local wetter
local function setzeWetter(id, ftime,maxtime) -- Clientseitiges Script für Tot
	setCameraBehindPlayer(getLocalPlayer())
	setTime(tonumber(id), 0)
	showPlayerHudComponent ( "all", false )
	showPlayerHudComponent ( "wanted", true )
	setWeather(16)
	setMinuteDuration ( 600000000 )
	setTimer(friedhofInfoBox,1500,1,ftime,maxtime)
end
addEvent("setClientTime",true)
addEventHandler	("setClientTime", getRootElement(), setzeWetter)


local function setFriedhofOff()
	triggerServerEvent("setFriedhofCol",getLocalPlayer(),false)
end

local function setFriedhofOn()
	triggerServerEvent("setFriedhofCol",getLocalPlayer(),true)
end

local function setFriedhofCol(objects,bool)
	for i,v in pairs(objects) do
		setElementCollisionsEnabled(v,bool)
	end
end
addEvent("friedhofColSet",true)
addEventHandler("friedhofColSet",getRootElement(),setFriedhofCol)
function friedhofInfoBox(ftime,maxtime)
	if(getElementData(getLocalPlayer(),"Friedhof[Zeit]") == 0) then
		local min = maxtime/60
		createInfobox("Friedhof","Du bist auf dem Friedhof gelandet. Du musst hier entweder "..min.." warten oder darauf hoffen, dass du von einem Sanitäter gerettet wirst!","NoPic.png",false,12000)
	else
		local timeT = ftime
		local minutes = math.floor(timeT / 60)
		local seconds = math.floor(((timeT / 60) %1) *60)
		if(minutes ~= 0) then

			createInfobox("Friedhof","Du musst immer noch auf dem Friedhof warten! In genau "..tostring(minutes).." Minuten und "..tostring(seconds).." Sekunden wirst du von deinen Qualen erlöst!","NoPic.png",false,12000)
		else
			createInfobox("Friedhof","Du musst immer noch auf dem Friedhof warten! In genau "..tostring(seconds).." Sekunden wirst du von deinen Qualen erlöst!","NoPic.png",false,12000)
		end
	end
end
function reLife(wetterid) -- Clientseitiges Script fürs wiederbeleben
	startEvent()
	outputChatBox("Irgendwas zieht dich zurück auf die Erde!!!",200,200,0)
	wetter = wetterid
end
addEvent("reLife",true)
addEventHandler("reLife",getRootElement(), reLife)

function setCameraBehindPlayer(player)
	setTimer(setCamera,200,1,player)
end

function setCamera(player)
	setCameraTarget(player)
end

function night(ps, value)
local player = getPlayerFromName(value)
local x,y,z = getElementPosition(player)
local z = z + 10
setElementPosition(getLocalPlayer(),x,y,z)
end
--addCommandHandler("goto",night)

function startEvent() -- Das Event wird gestartet, das einen aus den Friedhof raus lässt( physisch)
	setFriedhofOff() -- Collision vom Friedhof wird ausgeschaltet
	setTimer(
	function() -- 2 Sekunden später ( Warten bis Spieler unterm Friedhof ist)
		local x,y,z = getElementPosition(getLocalPlayer())
		setCameraMatrix ( x, y, z-5, x, y, z - 6) -- Kamera wird mit der Sicht nach unten gesetzt
		setTimer(
		function() -- 2 Sekunden später
			fadeCamera(false,6,255,255,255) -- Kammera wird ausgeblendet (Dauer 6 Sekunden)
			setTimer(
			function() -- 6 Sekunden später ( nach ausblenden ) (Fallen)
				setWeather(wetter)
				local time = getRealTime()
				setMinuteDuration(60000)
				setTime(time.hour ,time.minute)
				setFriedhofOn() -- Collision wird wieder eingeschaltet
				triggerServerEvent("beleben",getLocalPlayer(),getLocalPlayer()) -- Serverseitiges Beleben wird ausgeführt
				fadeCamera(true,6,255,255,255) --Bildschirm wird wieder eingeblendet (Dauer 6 Sek)
			end,6000,1)
		end,2000,1)
	end,2000,1)
end
--addCommandHandler("start",startEvent)

local function doEvent()
	dimD = math.random(1,50)
	setElementDimension(getLocalPlayer(),dimD)
	createCircle()
	setTimer(
	function() -- 7 Sekunden später (6 Sekunden für Kammera 1 Sekunde zum betrachten)
		showPlayerHudComponent ( "all", true )
		showPlayerHudComponent ( "vehicle_name", false)
		showPlayerHudComponent ( "area_name", false )
		setElementDimension(getLocalPlayer(),0)
	
		setPedAnimation( getLocalPlayer(), "ped", "getup_front",-1,false) -- Aufstehen
		setCameraTarget(getLocalPlayer(),getLocalPlayer()) -- Kamera wird hinter den Spieler gesetzt
		setTimer(
		function()
			triggerServerEvent("MInfoT",getLocalPlayer())
			deleteCircle()
			setPedAnimation( getLocalPlayer()) -- Spieler wird aus der Animation gerissen	
		end,1500,1)
	end,7000,1)
end
addEvent("doEvent",true)
addEventHandler("doEvent",getRootElement(),doEvent)

local function doAnim()
	showPlayerHudComponent ( "all", true )
	showPlayerHudComponent ( "vehicle_name", false)
	showPlayerHudComponent ( "area_name", false )
	setPedAnimation( getLocalPlayer(), "CRACK", "crckidle2")
end
addEvent("doAnim",true)
addEventHandler("doAnim",getRootElement(),doAnim)

local obj = {}
function createCircle()
	local abstand = 1.5
	local x,y,z = 1795.155761718750000,156.274917602539060,32.573036193847656-1.75
	
	for rota = 0,360,9 do
		
		local nx = math.sin(math.rad(rota)) * abstand
		local ny = math.sqrt(abstand^2 - nx^2)

		if(rota <=90 or rota >=270) then
			local sx,sy = x + nx,y - ny
			obj[rota] = createObject(3525,sx,sy,z)
			setElementDimension(obj[rota],dimD)
			
		elseif(rota > 90 and rota < 270) then
			local sx,sy = x + nx,y + ny
			obj[rota] = createObject(3525,sx,sy,z)
			setElementDimension(obj[rota],dimD)
		end
	end
end

function deleteCircle()
	for rota = 0,360,9 do
		destroyElement(obj[rota])
	end
end
addCommandHandler("fire",createCircle)
addCommandHandler("dfire",deleteCircle)

function createFriedhofW()
	GUIEditor_Label = {}
	local fx,fy = guiGetScreenSize()
	local bx,by = 370,115
	wdw_friedhof = guiCreateWindow(fx/2 -bx/2,fy/2-by/2,bx,by,"Friedhof",false)
	guiSetAlpha(wdw_friedhof,0.80000001192093)
	guiWindowSetMovable(wdw_friedhof,false)
	guiWindowSetSizable(wdw_friedhof,false)
	GUIEditor_Label[1] = guiCreateLabel(0.0622,0.2522,0.8919,0.313,"Du bist tot. Hast du den Rettungsdienst alamiert, bevor\ndu gestorben bist? Sie könnten dich vielleicht retten!",true,wdw_friedhof)
	guiSetAlpha(GUIEditor_Label[1],1)
	guiSetFont(GUIEditor_Label[1],"default-bold-small")
	btn_friedhof_yes = guiCreateButton(0.7324,0.6522,0.2216,0.2348,"Ja",true,wdw_friedhof)
	btn_friedhof_no = guiCreateButton(0.4838,0.6522,0.2216,0.2348,"Nein",true,wdw_friedhof)
	guiSetVisible(wdw_friedhof,false)
	
	addEventHandler("onClientGUIClick",btn_friedhof_yes,
	function(button)
		if(button == "left") then
			guiSetVisible(wdw_friedhof,false)
			showCursor(false)
			guiSetInputEnabled(false)
			triggerServerEvent("callTrue",getLocalPlayer())
		end
	end
	, false)
	addEventHandler("onClientGUIClick",btn_friedhof_no,
	function(button)
			guiSetVisible(wdw_friedhof,false)
			showCursor(false)
			guiSetInputEnabled(false)
			triggerServerEvent("callFalse",getLocalPlayer())
	end
	, false)

end

function showFriedhoffW()
	guiSetVisible(wdw_friedhof,true)
	showCursor(true)
	guiSetInputEnabled(true)
	setTimer(
	function()
		guiSetVisible(wdw_friedhof,false)
		showCursor(false)
		guiSetInputEnabled(false)
		triggerServerEvent("callFalse",getLocalPlayer())
	end,15000,1)
end
addEvent("showFriedhofPanel",true)
addEventHandler("showFriedhofPanel",getRootElement(),showFriedhoffW)

local function getCoords(x,y,z)
	local z = getGroundPosition(x,y,z)
	triggerServerEvent("createDeathElements",getLocalPlayer(),z+1)
end
addEvent("getCoords",true)
addEventHandler("getCoords",getRootElement(),getCoords)

function get(cn,value)
	veh = getPedOccupiedVehicle(getLocalPlayer())
	setElementCollisionsEnabled(veh,false)
end
addCommandHandler("get",get)
