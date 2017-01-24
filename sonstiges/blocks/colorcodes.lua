local function playerConnect(playerNick, playerIP, playerUsername, playerSerial, playerVersion)
if(string.find(playerNick,"#")) then
	cancelEvent(true,"Du hast einen Farbcode in deinem Namen. \Bitte entferne diesen aus deinem Namen!")
end

end -- Farbcodeverbot

addEventHandler ("onPlayerConnect", getRootElement(), playerConnect)