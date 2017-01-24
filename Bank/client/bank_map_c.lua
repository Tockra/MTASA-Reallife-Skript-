local brein = createPickup(1462.3000, -1011.2521, 26.8438, 3, 1239,5000) --Bank eingang
local bankEingang = createColSphere ( 1462.3000, -1011.2521, 26.8438, 1 )

local braus = createPickup(2305.7766,-16.1296,26.7496, 3, 1239,5000)	   --Bank ausgang
local bankAusgang = createColSphere ( 2305.7766,-16.1296,26.7496,1 )
setElementDimension(braus,4)                           -- Element wird in Dimension 4 gebracht...
setElementDimension(bankAusgang,4)

local bicon1 = createPickup(2315.8477, -15.3413, 26.7422, 3, 1274,5000)
local infoSchalter01 = createColSphere ( 2315.8477, -15.3413, 26.7422, 1 )
setElementDimension(bicon1,4)
setElementDimension(infoSchalter01,4)
	   
local bicon2 = createPickup(2315.8477, -7.2092, 26.7422, 3, 1274,5000)
local infoSchalter02 = createColSphere ( 2315.8477, -7.2092, 26.7422, 1 )
setElementDimension(bicon2,4)
setElementDimension(infoSchalter02,4)
	
local binfo = createPickup(2308.8696289063,-13.408550262451,26.7421875,3,1239)
local bankComputer = createColSphere ( 2308.8696289063,-13.408550262451,26.7421875, 1 )
setElementDimension(binfo,4)
setElementDimension(bankComputer,4)

local bankbot1 = createPed(17,2318.3064,-15.2842,26.7496) --Bots Bank 17
setPedRotation(bankbot1,90)	--Bots Bank
local bankbot2 = createPed(17,2318.3064,-7.1736,26.7496) --Bots Bank
setPedRotation(bankbot2,90) --Bots Bank
setElementDimension(bankbot1,4) --Bots Bank
setElementDimension(bankbot2,4) --Bots Bank

local function onEnterEnterP(player)
		if(player ~= getLocalPlayer()) then
			return false
		end
		infobox = createInfobox("Bank Los Santos","Vor dir befindet sich eine Fiale der Umta-Finanzgruppe. Hier kannst du dein Geld sicher aufbewahren! Drücke >Enter< um einzutreten!","infobank.png")
		addEventHandler("onClientColShapeLeave",bankEingang,onLeaveEnterP)
end
addEventHandler("onClientColShapeHit",bankEingang,onEnterEnterP)

function onLeaveEnterP(player)
	if(player ~= getLocalPlayer()) then
			return false
	end
	destroyInfobox(infobox)
	removeEventHandler("onClientColShapeLeave",bankEingang,onLeaveEnterP)
end
local function onEnterExitP(player)
	if(player ~= getLocalPlayer()) then
			return false
	end
	if(getElementDimension(player) ~= 4) then
		return 1
	end
	infobox = createInfobox("Ausgang","Das ist der Ausgang der Sparkasse. Um das Gebäude zu verlassen drücke >Enter<","exitinfo.png")
	addEventHandler("onClientColShapeLeave",bankAusgang,onLeaveExitP)
end
addEventHandler("onClientColShapeHit",bankAusgang,onEnterExitP)

function onLeaveExitP(player)
	if(player ~= getLocalPlayer()) then
			return false
	end
	destroyInfobox(infobox)
	removeEventHandler("onClientColShapeLeave",bankAusgang,onLeaveExitP)
end

local function onEnterInfoschalterP(player)
	if(player ~= getLocalPlayer()) then
		return false
	end
	if(getElementDimension(player) ~= 4) then
		return 1
	end
	local time = getRealTime()
	local hour = time.hour
	local state
	if(hour >= 20 or hour < 8) then
		state = "~Geschlossen~"
	else
		state = "~Geöffnet~"
	end
	infobox = createInfobox("Bankschalter", "Das ist der Bankschalter der Umta. Er ist täglich von 8:00h bis 20:00 h geöffnet. Im augenblick ist er "..state.." . Um mit den Bankangestellten zu sprechen, klicke den Bankschalter an.","infobank.png")
	
	addEventHandler("onClientColShapeLeave",infoSchalter01,onLeaveInfoschalterP)
	addEventHandler("onClientColShapeLeave",infoSchalter02,onLeaveInfoschalterP)
end
addEventHandler("onClientColShapeHit",infoSchalter01,onEnterInfoschalterP)
addEventHandler("onClientColShapeHit",infoSchalter02,onEnterInfoschalterP)

function onLeaveInfoschalterP(player)
	if(player ~= getLocalPlayer()) then
		return false
	end
	destroyInfobox(infobox)
	removeEventHandler("onClientColShapeLeave",infoSchalter01,onLeaveInfoschalterP)
	removeEventHandler("onClientColShapeLeave",infoSchalter02,onLeaveInfoschalterP)
	
end

local function onEnterBCP(player)
		if(player ~= getLocalPlayer()) then
			return false
		end
		if(getElementDimension(player) ~= 4) then
			return 1
		end
		infobox = createInfobox("Infocomputer", "An diesem Computer kannst du dir Auskünfte über dein Konto holen. Du kannst hier deinen Kontostand abfragen, deine erhaltenen Überweisungen sehen und die Kontonummer andere Spieler ausfindig machen.", "infobank.png")
		addEventHandler("onClientColShapeLeave",bankComputer,onLeaveBCP)
end
addEventHandler("onClientColShapeHit",bankComputer,onEnterBCP)

function onLeaveBCP(player)
	if(player ~= getLocalPlayer()) then
			return false
	end
	destroyInfobox(infobox)
	removeEventHandler("onClientColShapeLeave",bankComputer,onLeaveBCP)
end

function createPets()
local hour,minute = getTime()
	if(hour >= 8 and hour < 20) then 
		if(not bankbot1 or not bankbot2) then
			bankbot1 = createPed(17,2318.3064,-15.2842,26.7496) --Bots Bank 17
			setPedRotation(bankbot1,90)	--Bots Bank
			bankbot2 = createPed(17,2318.3064,-7.1736,26.7496) --Bots Bank
			setPedRotation(bankbot2,90) --Bots Bank
			setElementDimension(bankbot1,4) --Bots Bank
			setElementDimension(bankbot2,4) --Bots Bank
		end
	else
		if(bankbot1 and bankbot2) then
			destroyElement(bankbot1)
			destroyElement(bankbot2)
			bankbot1 = nil
			bankbot2 = nil
		end
	end 
end
addEvent("checkBankPed",true)
addEventHandler("checkBankPed",getRootElement(),createPets)