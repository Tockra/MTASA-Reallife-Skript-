local function OnPlayerChangeNick(oldNick, newNick)
			if(getElementData(source,"Benutzername") ~= newNick) then
				if(getElementData(source,"loggedin") == true) then
					outputChatBox("Du kannst hier deinen Nicknamen nicht wechseln!",source)
					cancelEvent()
				end
			end
end -- Namechange Block

addEventHandler("onPlayerChangeNick", getRootElement(), OnPlayerChangeNick)
