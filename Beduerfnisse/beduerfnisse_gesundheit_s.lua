addEvent("onBeduerfnisDown",false)
addEvent("onBeduerfnisUp",false)

local function onBeduerfnisUp(beduerfnis,newAmount,oldAmount,Amount)
	if(beduerfnis ~= "Gesundheit") then
		return 0
	end
	if(newAmount == 0) then

		if(getElementData(source,"GesundheitsTimer")) then
			killTimer(getElementData(source,"GesundheitsTimer"))
			setElementData(source,"GesundheitsTimer",false)
		end
	end
end
addEventHandler("onBeduerfnisDown",getRootElement(),onBeduerfnisUp)