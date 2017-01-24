local krankenhaus_p = createPickup(1172.9,-1323.3269042969,15.402950286865,3,1239,10)
local krankenhaus_m =  createColSphere ( 1172.9,-1323.3269042969,15.402950286865, 1 )
local unloadWest = createPickup(1177.8601074219,-1308.1912841797,13.830633163452,3,1318,10)
local unloadEast = createPickup(2030.5870361328,-1417.9331054688,16.9921875,3,1318,10)

local function onKraHit(player)
	if(player == getLocalPlayer()) then
		triggerServerEvent("krankenhausInfo",getLocalPlayer())
	end
end
addEventHandler("onClientColShapeHit",krankenhaus_m,onKraHit)

local function onKraLeave(player)
	if(player == getLocalPlayer()) then
		triggerServerEvent("krankenhausInfoD",getLocalPlayer())
	end
end
addEventHandler("onClientColShapeLeave",krankenhaus_m,onKraLeave)