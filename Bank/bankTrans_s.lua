local function bi(player)
if(client ~= player) then
	return 1
end
if(not antiSpam(player)) then
	return 1
end
local result = mysql_query(Datenbank, "SELECT * FROM `ueberweisungen` WHERE `Adressat`='"..MySQL_Save(getPlayerName(player)).."' AND `Showed`='0'")
for k,row in mysql_rows_assoc(result) do	
	triggerClientEvent(player,"createLine",player,row["Absender"],row["Betrag"],row["Datum"],row["Uhrzeit"],row["Verwendungszweck"])
end
mysql_free_result(result)
end
addEvent("holeDatenTrans",true)
addEventHandler("holeDatenTrans",getRootElement(),bi)

local function deleteEintrag(player,absender,time)
	if(client ~=player) then
		return 1
	end
	local delete = mysql_query(Datenbank,"UPDATE `ueberweisungen` SET `Showed`='1' WHERE `Adressat`='".. MySQL_Save ( getPlayerName(player) ).."' AND `Absender`='"..MySQL_Save( absender ).."' AND `Uhrzeit`='"..MySQL_Save( time).."'")
	mysql_free_result(delete)
end
addEvent("deleteEintragTrans",true)
addEventHandler("deleteEintragTrans", getRootElement(),deleteEintrag)

local function KcheckK(player,zielname)
		if(antiSpamDif(player)) then
			return 1
		end
		result = mysql_query(Datenbank, "SELECT * FROM `bankkonten` WHERE `Benutzername`='"..MySQL_Save(zielname).."'")
		if(mysql_num_rows(result) == 0) then
			outputChatBox(""..zielname.." existiert nicht oder besitzt kein Girokonto!",player)
			return 1
		end
		local info = mysql_fetch_assoc(result)
		mysql_free_result(result)
		triggerClientEvent(player,"setzeKN",player,info["GKKN"])
		
end
addEvent("KontoCheck",true)
addEventHandler("KontoCheck",getRootElement(),KcheckK)

local aspam = {}
function antiSpamDif(player)
	local time = getRealTime()
	if(tonumber(aspam[player])) then
		if(time.timestamp <= aspam[player] + 1) then
			return true
		end
		aspam[player]= time.timestamp
		return false
	else
		aspam[player]= time.timestamp
		return false
	end
	
end