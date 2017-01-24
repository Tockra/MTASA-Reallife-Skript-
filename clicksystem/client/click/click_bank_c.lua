local bs1 = createObject ( 3093, 2317.5576171875, -16.115314483643, 26.47106552124 )
setElementInterior(bs1,10)
setElementDimension(bs1,4)
local bs2 = createObject ( 3093, 2317.5537109375, -8.05859375, 26.47106552124 )
setElementInterior(bs2,10)
setElementDimension(bs2,4)
local binfo = createObject ( 1337, 2308.7980957031, -12.309606552124, 26.683696746826 )
setElementInterior(binfo,10)
setElementDimension(binfo,4)

function elementClicked(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, cE)
	if(guiGetInputEnabled() == false) then
        local x,y,z = getElementPosition(getLocalPlayer())
      	if(state == "down" and button == "left") then
	        if(cE ~=false) then
	        	
		        if(cE == bs1 or cE == bs2) then
		        	if(getDistanceBetweenPoints3D (x,y,z,2315.8477, -15.3413, 26.7422) <= 1.0 or getDistanceBetweenPoints3D (x,y,z,2315.8477, -7.2092, 26.7422) <= 1.0) then
		                destroyInfobox(infobox)
		                triggerServerEvent("checkTime",getLocalPlayer())
		            else
		            	outputChatBox("Du bist zu weit weg!")
		            end
		        elseif(cE == binfo) then
		        	if(getDistanceBetweenPoints3D(x,y,z,2308.8696289063,-13.408550262451,26.7421875) <= 1.5) then
		        		destroyInfobox(infobox)
		        		showBinfo()
		        		bistate = 1
		        	else
		        		outputChatBox("Du bist zu weit weg!")
		        	end 
		       
		        end
		        
	        end
        end
    end
 
end
addEventHandler( "onClientClick", getRootElement(), elementClicked )