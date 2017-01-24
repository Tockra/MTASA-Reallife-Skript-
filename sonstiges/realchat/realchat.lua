local function Realchat(message, messageType)
local distance = tonumber(getElementData(getRootElement(),"Settings","RealchatDistance"))
if(messageType == 0) then
	if(getElementData(source,"loggedin") == true) then
		local posX, posY, posZ = getElementPosition( source )
		local chatSphere = createColSphere( posX, posY, posZ, distance )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		local dev = getElementData(getRootElement(),"Settings","RealchatDistance") / 5
		for i, nearbyPlayer in ipairs( nearbyPlayers ) do
			local x,y,z = getElementPosition(nearbyPlayer)
			local sx,sy,sz = getElementPosition(source)
			local abstand = getDistanceBetweenPoints3D ( sx,sy,sz,x,y,z)
			if(abstand <= dev *1) then
				outputChatBox( getPlayerName ( source )..": "..message, nearbyPlayer,230,230,230 )
			elseif(abstand <= dev * 2) then
				outputChatBox( getPlayerName ( source )..": "..message, nearbyPlayer,200,200,200 )			
			elseif(abstand <= dev * 3) then
				outputChatBox( getPlayerName ( source )..": "..message, nearbyPlayer,170,170,170 )				
			elseif(abstand <= dev * 4) then
				outputChatBox( getPlayerName ( source )..": "..message, nearbyPlayer, 140,140,140)				
			elseif(abstand <= dev * 5) then
				outputChatBox( getPlayerName ( source )..": "..message, nearbyPlayer, 110,110,110 )				
			end
	    end
-- 230
-- 200
-- 170
-- 140
-- 110
	end
end
end -- Realchat

addEventHandler( "onPlayerChat", getRootElement(), Realchat )


local function BlockChat()
	cancelEvent()
end -- Blockchat
addEventHandler( "onPlayerChat", getRootElement(), BlockChat )