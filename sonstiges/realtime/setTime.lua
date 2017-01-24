function onServerStart()
	local time = getRealTime()
	setMinuteDuration(60000)
	setTime(time.hour ,time.minute)
end 
addEventHandler ( "onResourceStart", resourceRoot, onServerStart )