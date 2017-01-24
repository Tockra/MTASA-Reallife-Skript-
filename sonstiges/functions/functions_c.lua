_killTimer = killTimer
function killTimer(theTimer)
	if(isTimer(theTimer) and getTimerDetails ( theTimer )) then
		return _killTimer(theTimer)
	else
		return false
	end
end

local mouseState = "up"

function getMouseState()
	return mouseState
end

local function onClick(button,state)
	mouseState = state
end
addEventHandler("onClientClick",getRootElement(),onClick)