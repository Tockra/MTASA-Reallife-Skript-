addEvent("onBeduerfnisDown",false)
addEvent("onBeduerfnisUp",false)
local function onBeduerfnisDown(beduerfnis,newAmount,oldAmount,Amount)
	if(beduerfnis ~= "Hygiene") then
		return 0
	end
	if(newAmount <= 25 and not getElementData(source,"HygieneIns1") ) then
		local x,y,z = getElementPosition(source)
		setElementData(source,"HygieneIns1",createObject(2029,x,y,z))
		setElementCollisionsEnabled ( getElementData(source,"HygieneIns1"),false)
		attachElements(getElementData(source,"HygieneIns1"),source)
	elseif(newAmount <= 5 and not getElementData(source,"HygieneIns2")) then
		local x,y,z = getElementPosition(source)
		setElementData(source,"HygieneIns2",createObject(2029,x,y,z))
		setElementCollisionsEnabled ( getElementData(source,"HygieneIns2"),false)
		attachElements(getElementData(source,"HygieneIns2"),source)
				
		setElementData(source,"HygieneSmoke1",createObject(2079,x,y,z))
		setElementCollisionsEnabled ( getElementData(source,"HygieneSmoke1"),false)
		attachElements(getElementData(source,"HygieneSmoke1"),source)
	elseif(newAmount <= 0 and oldAmount > 0) then
		if(not getElementData(source,"HygieneIns3")) then
			local x,y,z = getElementPosition(source)
			setElementData(source,"HygieneIns3",createObject(2029,x,y,z))
			setElementCollisionsEnabled ( getElementData(source,"HygieneIns3"),false)
			attachElements(getElementData(source,"HygieneIns3"),source)
		end

		if(not getElementData(source,"GesundheitsTimer")) then
			setElementData(source,"GesundheitsTimer",setTimer(
				function(player)
					givePlayerBeduerfnis(player,"Gesundheit",-1) 
				end,1000,0,source))		
		end
	end
end
addEventHandler("onBeduerfnisDown",getRootElement(),onBeduerfnisDown)

local function onBeduerfnisUp(beduerfnis,newAmount,oldAmount,Amount)
	if(beduerfnis ~= "Hygiene") then
		return 0
	end
	if(newAmount > 0 and getElementData(source,"GesundheitsTimer")) then
		killTimer(getElementData(source,"GesundheitsTimer"))
		setElementData(source,"GesundsheitsTimer",false)
	end
end
addEventHandler("onBeduerfnisUp",getRootElement(),onBeduerfnisUp)

