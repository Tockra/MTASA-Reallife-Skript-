local function OnPlayerConnect()
	fadeCamera(source,true,5)
	setCameraMatrix(source,1172.2449951172,-947.93182373047,64.605712890625,1182.7590332031,-934.09954833984,55.335052490234)
	outputChatBox("Herzlich Willkommen auf meinem Testserver", source)
	showPlayerHudComponent ( source, "vehicle_name", false)
	showPlayerHudComponent ( source, "area_name", false )
end
addEventHandler ( "onPlayerJoin", getRootElement(), OnPlayerConnect)
