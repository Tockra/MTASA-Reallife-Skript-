setTimer(
function()
	if(not isElementInWater(getLocalPlayer())) then
		return 0
	end
	triggerServerEvent("onPlayerSwim",getLocalPlayer())
end,5000,-1)

addEventHandler("onClientResourceStart",getResourceRootElement(),
	function(resource)
			local dff = engineLoadDFF("Beduerfnisse/particles/insects.dff",0)
			engineReplaceModel(dff,2029)
			local dff = engineLoadDFF("Beduerfnisse/particles/WS_factorysmoke.dff",0)
			engineReplaceModel(dff,2079)
	end
)

