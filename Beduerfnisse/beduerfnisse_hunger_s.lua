addEvent("onBeduerfnisDown",false)
addEvent("onBeduerfnisUp",false)

local function onBeduerfnisUp(beduerfnis,newAmount,oldAmount,Amount)
	if(beduerfnis ~= "Hunger") then
		return 0
	end
	setData(source,"Bedürfnisse","HarndrangIntus",amount * 0.9)
end
addEventHandler("onBeduerfnisUp",getRootElement(),onBeduerfnisUp)