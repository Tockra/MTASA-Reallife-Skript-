

local function onLogin()
	bindKey ( source, "enter", "down", enterExitBank )
end
addEvent("afterPlayerLogin",true)
addEventHandler("afterPlayerLogin",getRootElement(),onLogin)

function enterExitBank(player)
	if(enterInterior(player,1462.3000, -1011.2521, 26.8438,2307.2769,-15.7824,26.7496,270,0,4)) then
		triggerClientEvent(player,"checkBankPed",player)
	else if(getElementDimension(player) == 4) then
		enterInterior(player,2305.7766,-16.1296,26.7496,1462.5670166016,-1013.8486328125,26.794647216797,180,0,0)
	end
	end
end

local doors = {
createObject ( 2987, 2304.34765625, -16.8623046875, 26.940687179565, 0, 0, 90 ),
createObject ( 2987, 2304.337890625, -15.30078125, 26.940687179565, 0, 0, 91.246948242188 ),
createObject ( 1522, 2314.802734375, 0.81087404489517, 25.745349884033 ),
createObject ( 3093, 2303.9736328125, -15.9755859375, 26.880865097046 ),
createObject ( 3093, 2303.982421875, -17.73046875, 26.880865097046 ),
createObject ( 3093, 2303.9814453125, -17.1630859375, 26.880865097046 )
}
for index,value in pairs(doors) do
	setElementDimension(value,4)
end