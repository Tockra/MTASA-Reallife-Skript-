local ipMysql = "127.0.0.1"
local userMysql = "root"
local pwMysql = "pw"
local databaseMysql = "mta_datenbank"
function OnGameModInit()
	Datenbank = mysql_connect(ipMysql,userMysql,pwMysql,databaseMysql)
	if(Datenbank) then
		outputDebugString  ("Die Verbindung zur MySQL-Datenbank wurd erfolgreich hergestellt.")
	elseif(not Datenbank) then
		outputDebugString ("Die Verbindung zur MySQL Datenbank konnte nicht hergestellt werden")
		shutdown ( "Die Verbindung zur Mysql-Datenbank konnte nicht aufgebaut werden!" )
		return 0
	end
	
end -- Verbindung zur Datenbank + Sonstiges

addEventHandler ( "onResourceStart", resourceRoot, OnGameModInit )

local function onPlayerJoin()
	if(not mysql_ping ( Datenbank )) then
		outputDebugString("Verbindung zur Datenbank verloren")
		Datenbank = mysql_connect(ipMysql,userMysql,pwMysql,databaseMysql);
		if(Datenbank) then
			outputDebugString ("Verbindung zur Datenbank wurde wieder hergestellt.")
		elseif(not Datenbank) then
			outputDebugString ("Die Verbindung konnte nicht hergestellt werden!")
			mysql_close(Datenbank)
		end
	end
end
addEventHandler ( "onPlayerJoin", getRootElement(), onPlayerJoin)
