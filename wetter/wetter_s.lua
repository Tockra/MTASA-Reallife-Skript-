function OnGameModInit()
	RandomWeather()
	setTimer(RandomWeather,3600000,0)
end -- Verbindung zur Datenbank + Sonstiges

addEventHandler ( "onResourceStart", resourceRoot, OnGameModInit )

function RandomWeather()
	WetterID = math.random(0,20)
	setWeatherBlended ( WetterID )
	outputServerLog ( "Wetter wurde gechanged. WetterID: "..WetterID )

end -- Wetter