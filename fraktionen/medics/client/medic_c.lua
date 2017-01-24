local function duty(dienst,skin)
	fadeCamera(false,3)
	toggleAllControls (false)
	setTimer(
	function()
		if(dienst ~= true) then
			triggerServerEvent("setPSkin",getLocalPlayer(),getLocalPlayer(),skin)
			outputChatBox("* Du ziehst deine Dienstkleidung an und nimmst dein Funkgerät aus deinem Spind", 51,204,255)
			outputChatBox("Du bist nun im Dienst!", 175,175,175)
			setElementData(getLocalPlayer(),"DutyLock",false)
		elseif(dienst == true) then
			triggerServerEvent("setPSkin",getLocalPlayer(),getLocalPlayer(),skin)
			outputChatBox("* Du legst deine Dienstkleidung und dein Funkgerät zurück in dein Spind",51,204,255)
			outputChatBox("Du bist nun nicht mehr im Dienst!",175,175,175)
			setElementData(getLocalPlayer(),"DutyLock",false)
		end
		fadeCamera(true,3)
		toggleAllControls (true)
	end,3000,1)
end
addEvent("MedicDuty",true)
addEventHandler("MedicDuty",getRootElement(),duty)

local krawa
local function onEnter(player,seat)
	if(player == getLocalPlayer()) then
		local vehid = getElementModel(source)
		if(vehid == 416) then
			if(seat == 0) then
				krawa = source
				addEventHandler("onClientRender",getRootElement(),showPlaces)
				addEventHandler("onClientRender",getRootElement(),showTimer)
				guiSetVisible(wdw_time,true)
			end
		end
	end
end
addEventHandler("onClientVehicleEnter",getRootElement(),onEnter)

local function onExit(veh,player,seat)
	if(getElementModel(veh) == 416) then
		if(seat == 0) then
			removeEventHandler("onClientRender",getRootElement(),showPlaces)
			removeEventHandler("onClientRender",getRootElement(),showTimer)
			guiSetVisible(wdw_time,false)
			krawa = nil
		end
	end
end
addEvent("exitCV",true)
addEventHandler("exitCV",getRootElement(),onExit)

local function onWasted()
	local veh = getPedOccupiedVehicle(source)
	if(veh and getElementModel(veh) == 416) then
		removeEventHandler("onClientRender",getRootElement(),showPlaces)
		removeEventHandler("onClientRender",getRootElement(),showTimer)
		guiSetVisible(wdw_time,false)
		krawa = nil
	end
end
addEventHandler("onClientPlayerWasted",getRootElement(),onWasted)

local fx,fy = guiGetScreenSize()
local bx,by = 50,50
local h = fy - by - dxGetFontHeight  (0.5, "bankgothic" ) 
function showPlaces()
	dxDrawText("Patienten im Fahrzeug:",0,h,97.0,1044.0,tocolor(255,255,255,255),0.5,"bankgothic","left","top",false,false,false)
	if(getElementData(krawa,"LoadA")) then
		dxDrawImage(0,fy-by,bx,by,"images/krankenwagen/kreuz.png",0,0,0,tocolor(255,255,255,255))
	else
		dxDrawImage(0,fy-by,bx,by,"images/krankenwagen/kreuz.png",0,0,0,tocolor(255,255,255,50))
	end
	
	if(getElementData(krawa,"LoadB")) then
		dxDrawImage(0+bx+5,fy-by,bx,by,"images/krankenwagen/kreuz.png",0,0,0,tocolor(255,255,255,255))
	else
		dxDrawImage(0+bx+5,fy-by,bx,by,"images/krankenwagen/kreuz.png",0,0,0,tocolor(255,255,255,50))
	end
	
	if(getElementData(krawa,"LoadC")) then
		dxDrawImage(0+bx*2+10,fy-by,bx,by,"images/krankenwagen/kreuz.png",0,0,0,tocolor(255,255,255,255))
	else
		dxDrawImage(0+bx*2+10,fy-by,bx,by,"images/krankenwagen/kreuz.png",0,0,0,tocolor(255,255,255,50))
	end
		
end

function showTimer()
	local veh = getPedOccupiedVehicle ( getLocalPlayer() )
	if(getElementData(veh,"LoadA")) then
		local timeT = getElementData(veh,"LoadACTime")
		local minutes = math.floor(timeT / 60)
		local seconds = math.floor(((timeT / 60) %1) *60)
	--	local  seconds = math.floor((timeT/60 - math.floor(timeT / 60) ) *60)
		if(seconds < 10) then
			seconds = tostring("0"..seconds)
		end
		guiSetText(label_p1,tostring(minutes).." : "..tostring(seconds))
	else
		guiSetText(label_p1,"-")
	end
	
	if(getElementData(veh,"LoadB")) then
		local timeT = getElementData(veh,"LoadBCTime")
		local minutes = math.floor(timeT / 60)
		local seconds = math.floor(((timeT / 60) %1) *60)
		if(seconds < 10) then
			seconds = tostring("0"..seconds)
		end
		guiSetText(label_p2,tostring(minutes).." : "..tostring(seconds))
	else
		guiSetText(label_p2,"-")
	end
	
	if(getElementData(veh,"LoadC")) then
		local timeT = getElementData(veh,"LoadCCTime")
		local minutes = math.floor(timeT / 60)
		local seconds = math.floor(((timeT / 60) %1) *60)
		if(seconds < 10) then
			seconds = tostring("0"..seconds)
		end
		guiSetText(label_p3,tostring(minutes).." : "..tostring(seconds))
	else
		guiSetText(label_p3,"-")
	end
end

local ped
local function startKWB(skin)
	playSound ( "sounds/Herzschlag.mp3")
	setTimer(
	function()
		setCameraGoggleEffect ( "thermalvision" )
		setTimer(
		function()
			setCameraGoggleEffect ( "normal" )
			setTimer(
			function()
				setCameraGoggleEffect ( "thermalvision" )
				setTimer(
				function()
					setCameraGoggleEffect ( "normal" )
					fadeCamera(false,0.1)
					setTimer(
					function()
						playSound("sounds/Defi.mp3")
						setTimer(
						function()
							fadeCamera(false,0,255,255,255)
							setTimer(
							function()
								ped = createPed(skin,2232.8225097656,-1107.3049316406,1051.2778320313,50)
								setElementInterior(ped,5)
								setElementDimension(ped,3)
								setElementInterior(getLocalPlayer(),5)
								setElementDimension(getLocalPlayer(),3)
								setCameraMatrix(2229.1315917969, -1106.6284179688, 1050.7058105469,2231.1315917969, -1106.6284179688, 1050.7058105469,0)
								fadeCamera(true,2,255,255,255)
								setTimer(
								function()
									x=2229.1315917969
									z=1050.7058105469
									addEventHandler("onClientPreRender",getRootElement(),moveCCamera)
								end,500,1)
							end,675,1)
						end,2585,1)
					end,100,1)
				end,600,1)
			end,647,1)
		end,600,1)
	end,227,1)
end
addEvent("relifeKW",true)
addEventHandler("relifeKW",getRootElement(),startKWB)
--2229.1315917969, -1106.6284179688, 1050.7058105469  
-- int 5

rota = 0
function moveCCamera()
	--Aufstehen
	--local x,y,z 
	--end 1196.125,12.883803367615
	setElementInterior(getLocalPlayer(),5)
	if(x <= -1106.5284179688 or z <= 1050.8058105469) then
	x,z = x + 0.005,z + 0.005
	--2229.1315917969, -1106.6284179688, 1052.0
	setCameraMatrix(x, -1106.6284179688, z,x +15, -1106.6284179688, z,0,rota)
	else
		removeEventHandler("onClientPreRender",getRootElement(),moveCCamera)
		setTimer(
		function()
			setPedControlState(ped,"walk",true)
			setPedControlState(ped,"backwards",true)
			setTimer(
			function()
				setPedControlState(ped,"walk",false)
				setPedControlState(ped,"backwards",false)
				destroyElement(ped)
				fadeCamera(false,1)
				setTimer(
				function()
					if(getElementData(getLocalPlayer(),"Friedhof[Krankenhaus]") == 1) then
						setElementInterior(getLocalPlayer(),0)
						setCameraMatrix(1211.1435546875,-1323.7407226563,28.469081878662,1205.6850585938,-1323.7543945313,27.217357635498)
					elseif(getElementData(getLocalPlayer(),"Friedhof[Krankenhaus]") == 2) then
						setElementInterior(getLocalPlayer(),0)
						setCameraMatrix(1988.0588378906, -1471.30859375, 29.696105957031,1992.1458740234, -1465.6910400391, 28.847299575806)
					end
					local time = getRealTime()
					setMinuteDuration(60000)
					setWeather(wetter)
					setTime(time.hour ,time.minute)
					fadeCamera(true)
					outputChatBox("Drücke die Entertaste, um das Krankenhaus zu verlassen!",170,51,51)
					bindKey("enter","down",spawnKrankenhaus)
					
				end,1000,1)
				
			end,2500,1)
		end,1500,1)
	end

	
end

local function swetter(wetterid)
	wetter = wetterid
end
addEvent("setWeatherKW",true)
addEventHandler("setWeatherKW",getRootElement(),swetter)

function spawnKrankenhaus()
	fadeCamera(false)
	unbindKey("enter","down",spawnKrankenhaus)
	showPlayerHudComponent ( "all", true )
	showPlayerHudComponent ( "vehicle_name", false)
	showPlayerHudComponent ( "area_name", false )
	
	triggerServerEvent("spawnPlayerK",getLocalPlayer(),getLocalPlayer())
	setTimer(
	function()
		fadeCamera(true,1)
		setCameraTarget(getLocalPlayer(),getLocalPlayer())
	end,200,1)
end

function radio()
	playSound("radio.justnetwork.eu:8000/listen.pls")
end
addCommandHandler("radio",radio)

function createTimePanel()
GUIEditor_Label = {}
	local h = fy - by - dxGetFontHeight  (0.5, "bankgothic" ) - 99
	wdw_time = guiCreateWindow(0,h,128,98,"Zeit",false)
	guiWindowSetSizable(wdw_time,false)
		
	GUIEditor_Label[1] = guiCreateLabel(10,26,54,16,"Patient 1:",false,wdw_time)
	guiLabelSetColor(GUIEditor_Label[1],0,180,0)
	GUIEditor_Label[2] = guiCreateLabel(10,48,54,16,"Patient 2:",false,wdw_time)
	guiLabelSetColor(GUIEditor_Label[2],0,180,0)
	GUIEditor_Label[3] = guiCreateLabel(10,70,54,16,"Patient 3:",false,wdw_time)
	guiLabelSetColor(GUIEditor_Label[3],0,180,0)
	label_p1 = guiCreateLabel(78,27,48,15,"",false,wdw_time)
	guiLabelSetColor(label_p1,170,51,51)
	guiSetFont(label_p1,"default-bold-small")
	label_p2 = guiCreateLabel(78,48,48,15,"",false,wdw_time)
	guiLabelSetColor(label_p2,170,51,51)
	guiSetFont(label_p2,"default-bold-small")
	label_p3 = guiCreateLabel(78,71,48,15,"",false,wdw_time)
	guiLabelSetColor(label_p3,170,51,51)
	guiSetFont(label_p3,"default-bold-small")
	
	guiSetVisible(wdw_time,false)
	


end

local function getG(x,y,z)
	local nz = getGroundPosition ( x,y,z )
	triggerServerEvent("createKPickupG",getLocalPlayer(),getLocalPlayer(),x,y,nz + 1)
end
addEvent("getGroundOfKPickup",true)
addEventHandler("getGroundOfKPickup",getRootElement(),getG)


