local function input_Console(text)
	if(getElementType(source) == "player") then
		if(getElementData(source,"loggedin") == false) then
			outputConsole("Du kannst die Konsole erst verwenden, wenn du eingeloggt bist !",source,175,175,175)
			cancelEvent()
		end
	end
end -- Konsolen Block
addEventHandler ( "onConsole", getRootElement(), input_Console )

