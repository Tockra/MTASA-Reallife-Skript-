
function teleportToDo()
	
		setElementPosition(getLocalPlayer(),1172.9,-1323.3269042969,15.402950286865)
		setElementDimension(getLocalPlayer(),0)
		--showPlayerHudComponent ( "all", true )
		--setMinuteDuration ( 60000 )
	
end -- teleportiert mich zur aktuellen "Baustelle"
bindKey ( "p", "down", teleportToDo )

function mauszeigerVisible(player, key, keyState)
	if ( keyState == "down" ) then
		showCursor(true)
	elseif( keyState == "up") then
		showCursor(false)
	end
	
end -- Mauszeiger altgr


local function Rotation(rotation)
	setPedCameraRotation ( getLocalPlayer(), rotation )
end
addEvent("Rotation",true)
addEventHandler("Rotation",getRootElement(),Rotation)
