local schranke = createObject ( 968, 1132.7928466797, -1291.951171875, 13.328078269958, 0, 90, 0 ) 
local oPlayer


local function enterHospital(player)
	--[[if(enterInterior(player,1462.3000, -1011.2521, 26.8438,2307.2769,-15.7824,26.7496,270,0,4)) then
	
	elseif(getElementDimension(player) == 4) then
		--enterInterior(player,1462.3000, -1011.2521, 26.8438,2307.2769,-15.7824,26.7496,270,0,4)
	end]]
end

local function onLogin()
	bindKey ( source, "enter", "down", enterHospital )
end
addEvent("afterPlayerLogin",true)
addEventHandler("afterPlayerLogin",getRootElement(),onLogin)

medicSchranke = createColSphere ( 1132.7928466797, -1291.951171875, 13.328078269958, 10 )
local function openSchranke(player) -- Schranke öffnen Autom
		if(getElementData(player,"Fraktionen[Fraktion]") == "Medic") then
			if(getPedOccupiedVehicleSeat ( player ) == 0) then
				local x,y,z = getElementRotation(schranke)
				
				
					if(y == 90) then
						moveObject(schranke, 1000, 1132.7928466797, -1291.951171875, 13.328078269958, 0, -90 ,0)
						state = "open"
						oPlayer = player
						schrankenT = setTimer(cSchranke,3000,1)
					end
				
				
			end
		end
end
local function closeSchranke(player) -- Schranke schließen Autom
	if(oPlayer == player) then
		if(getElementData(player,"Fraktionen[Fraktion]") == "Medic") then
		local x,y,z = getElementRotation(schranke)
			if( y == 0) then
				killTimer(schrankenT)
				moveObject(schranke, 1000, 1132.7928466797, -1291.951171875, 13.328078269958, 0, 90 ,0)
				state = "close"
			end
		end
	end
end
addEventHandler ( "onColShapeHit", medicSchranke, openSchranke )
addEventHandler ( "onColShapeLeave", medicSchranke, closeSchranke )

function cSchranke() -- Schranke schließen (Timer)
	moveObject(schranke, 1000, 1132.7928466797, -1291.951171875, 13.328078269958, 0, 90 ,0)
	state = "close"
end

local function onHit()
	if(source ~= client) then
		return 1
	end
	setElementData(source,"krankenhausInfo",createInfobox(source,"Krankenhaus","Herzlich willkommen im westlichen Krankenhaus von San Andreas! Drücke >Enter< um einzutreten!","krankenhaus.png"))		
end
addEvent("krankenhausInfo",true)
addEventHandler("krankenhausInfo",getRootElement(),onHit)

local function onLeave()
	if(source ~= client) then
		return 1
	end
	if(getElementData(source,"krankenhausInfo")) then
		destroyInfobox(source,getElementData(source,"krankenhausInfo"))
		setElementData(source,"krankenhausInfo",false)
	end
end
addEvent("krankenhausInfoD",true)
addEventHandler("krankenhausInfoD",getRootElement(),onLeave)

