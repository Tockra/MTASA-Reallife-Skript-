local function enterVehicle(theVehicle, seat, jacked )

	if(seat == 0) then
		if(getVehicleType(theVehicle) == "Automobile") then
			if(getElementData(source,"UnL","Autoschein") ~= 1) then
				setVehicleEngineState(theVehicle,false)
				outputChatBox("Die vielen Schalter am Amaturenbrett verwirren dich.",source,175,175,175)
				outputChatBox("Du bist nicht in der Lage den Motor anzuwerfen.",source,175,175,175)
				outputChatBox("Wenn du Autofahren lernen willst, dann geh zur Stadthalle!",source,175,175,175)
			
			end
		elseif(getVehicleType(theVehicle) == "Bike" or getVehicleType(theVehicle) == "Quad") then
			if(getElementData(source,"UnL","Motorradschein") ~= 1) then
				setVehicleEngineState(theVehicle,false)
				outputChatBox("Die vielen Schalter am Lenker verwirren dich.",source,175,175,175)
				outputChatBox("Du bist nicht in der Lage den Motor anzuwerfen.",source,175,175,175)
				outputChatBox("Wenn du Motorradfahren lernen willst, dann geh zur Stadthalle!",source,175,175,175)
			end
		elseif(getVehicleType(theVehicle) == "Boat") then
			if(getElementData(source,"UnL","Bootschein") ~= 1) then
				setVehicleEngineState(theVehicle,false)
				outputChatBox("Die vielen Hebel verwirren dich.",source,175,175,175)
				outputChatBox("Du bist nicht in der Lage den Motor anzuwerfen.",source,175,175,175)
				outputChatBox("Wenn du Bootfahren lernen willst, dann geh zur Stadthalle!",source,175,175,175)
			end
		elseif(getVehicleType(theVehicle) == "Helicopter" or getVehicleType(theVehicle) == "Plane") then
			if(getElementData(source,"UnL","Flugschein") ~= 1 ) then
				setVehicleEngineState(theVehicle,false)
				outputChatBox("Die vielen Schalter am Amaturenbrett verwirren dich.",source,175,175,175)
				outputChatBox("Du bist nicht in der Lage den Motor anzuwerfen.",source,175,175,175)
				outputChatBox("Wenn du den Flugschein machen willst, dann geh zur Stadthalle!",source,175,175,175)
			end
		
		end

		
	end

end -- Scheine
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), enterVehicle )