local function onLogin()
	local playername = getPlayerName(source)
	local result = mysql_query(Datenbank, "SELECT * FROM `bankkonten` WHERE `Benutzername`='"..MySQL_Save(playername).."'")
	if(mysql_num_rows(result) ~= 0) then
		local pInfo = mysql_fetch_assoc(result)
		mysql_free_result(result)
		for index,wert in pairs(pInfo) do
			if(tostring(index) ~="GeldSB" and tostring(index) ~="GeldGK") then
				--setElementData(source,"Bank["..tostring(index).."]",tonumber(wert))
				setData(source,"Bank",tostring(index),tonumber(wert))
			else
				--setElementData(source,"Bank["..tostring(index).."]",tonumber(wert),true)
				setData(source,"Bank",tostring(index),tonumber(wert),true)
			end
		end
		setData(source,"Bank","Hallo","Test",true)
		setElementData(source,"KNG",getElementData(source,"Bank")["GKKN"],true)
		setElementData(source,"KNS",getElementData(source,"Bank")["SBKN"],true)
	else
		mysql_free_result(result)
	end
	
	bankNews(source)
end

addEvent("afterPlayerLogin",true)
addEventHandler("afterPlayerLogin",getRootElement(),onLogin)

local function girocr(player,pin)
local x,y,z = getElementPosition(player)
if(getDistanceBetweenPoints3D (x,y,z,2315.8477, -15.3413, 26.7422) > 1.0 and getDistanceBetweenPoints3D (x,y,z,2315.8477, -7.2092, 26.7422) > 1.0) then
	outputChatBox("Du musst in der Nähe des Bankschalters sein!",player)
	return 1
end
if(client == player) then
	if(getElementData(player,"Bank") and getElementData(player,"Bank")["GKKN"] ~= false) then
		if(getElementData(player,"Bank")["GKKN"] > 0) then
			return 1
		end
	end

	local result = mysql_query(Datenbank, "SELECT * FROM `bankkonten` WHERE `Benutzername`='"..MySQL_Save ( getPlayerName(player) ).."'")
	
	local kn = math.random(100000,999999)
	local kncheck = mysql_query(Datenbank, "SELECT * FROM `bankkonten` WHERE `GKKN`='"..MySQL_Save(kn).."'")
	local kncheck2 = mysql_query(Datenbank, "SELECT * FROM `bankkonten` WHERE `SBKN`='"..MySQL_Save(kn).."'")
	while(mysql_num_rows(kncheck) >= 1 or mysql_num_rows(kncheck2) >= 1) do
	mysql_free_result(kncheck)
	mysql_free_result(kncheck2)
	local kn = math.random(100000,999999)
	local kncheck = mysql_query(Datenbank, "SELECT * FROM `bankkonten` WHERE `GKKN`='"..MySQL_Save(kn).."'")
	local kncheck2 = mysql_query(Datenbank, "SELECT * FROM `bankkonten` WHERE `SBKN`='"..MySQL_Save(kn).."'")
	end
	mysql_free_result(kncheck)
	mysql_free_result(kncheck2)
	if(mysql_num_rows(result) == 0) then 
       	mysql_free_result(result)
       	local saved = mysql_query(Datenbank, "INSERT INTO `bankkonten` (GKKN,Pin,Benutzername) VALUES ('"..MySQL_Save ( kn ).."','"..MySQL_Save( pin ).."','"..MySQL_Save( getPlayerName(player) ).."')")
    	mysql_free_result ( saved )
    	
    	local result = mysql_query(Datenbank, "SELECT * FROM `bankkonten` WHERE `Benutzername`='"..MySQL_Save(getPlayerName(player)).."'")
		if(mysql_num_rows(result) ~= 0) then
			local pInfo = mysql_fetch_assoc(result)
			mysql_free_result(result)
			for index,wert in pairs(pInfo) do
				if(tostring(index) ~="GeldSB" and tostring(index) ~= "GeldGK") then
					--setElementData(player,"Bank["..tostring(index).."]",tonumber(wert))
					setData(player,"Bank",tostring(index),tonumber(wert))
				else
					--setElementData(player,"Bank["..tostring(index).."]",tonumber(wert),true)
					setData(player,"Bank",tostring(index),tonumber(wert),true)
				end
			end
			setElementData(player,"KNG",getElementData(player,"Bank")["GKKN"],true)
			setElementData(player,"KNS",getElementData(player,"Bank")["SBKN"],true)
		else
			mysql_free_result(result)
		end
    elseif(mysql_num_rows(result) == 1) then
    	mysql_free_result(result)
    	local saved = mysql_query(Datenbank, "UPDATE `bankkonten` SET `GKKN`='"..MySQL_Save ( kn ).."',`Pin`='"..MySQL_Save ( pin ).."' WHERE `Benutzername`='"..MySQL_Save ( getPlayerName(player) ).."'")
    	mysql_free_result ( saved )
    end	
	--setElementData(player,"Bank[Pin]",pin,false)
	setData(player,"Bank","Pin",pin)
	--setElementData(player,"Bank[GKKN]",kn,false)
	setData(player,"Bank","GKKN",kn)
	setElementData(player,"KNG",getElementData(player,"Bank")["GKKN"],true)
	
	outputChatBox("|______________Erstelt_____________|",player,137,255,66,true)
	outputChatBox("Vielen Dank, dass sie ein Konto bei uns angelegt haben!",player,137,255,66,true)
	outputChatBox("Hier ist ihre Kontokarte.",player,137,255,66,true)
	outputChatBox("Das Konto ist nun aktiviert.",player,137,255,66,true)
	outputChatBox("Ihre Kontonummer: "..kn,player,137,255,66,true)
	outputChatBox("Ihr Pin: "..pin,player,137,255,66,true)
	outputChatBox("|__________________________________|",player,137,255,66,true)
end
	
	
end
addEvent("CreateGiro", true)
addEventHandler("CreateGiro", getRootElement(), girocr)

local function sbcr(player)

local x,y,z = getElementPosition(player)
if(getDistanceBetweenPoints3D (x,y,z,2315.8477, -15.3413, 26.7422) > 1.0 and getDistanceBetweenPoints3D (x,y,z,2315.8477, -7.2092, 26.7422) > 1.0) then
	outputChatBox("Du musst in der Nähe des Bankschalters sein!",player)
	return 1
end
if(client == player) then
	if(getElementData(player,"Bank") and getElementData(player,"Bank")["SBKN"] ~= false ) then
		if(getElementData(player,"Bank")["SBKN"] > 0 ) then
			return 1
		end
	end
	local result = mysql_query(Datenbank, "SELECT * FROM `bankkonten` WHERE `Benutzername`='"..MySQL_Save(getPlayerName(player)).."'")
	
	local kn = math.random(100000,999999)
	local kncheck = mysql_query(Datenbank, "SELECT * FROM `bankkonten` WHERE `GKKN`='"..MySQL_Save(kn).."'")
	local kncheck2 = mysql_query(Datenbank, "SELECT * FROM `bankkonten` WHERE `SBKN`='"..MySQL_Save(kn).."'")
	while(mysql_num_rows(kncheck) >= 1 or mysql_num_rows(kncheck2) >= 1) do
	mysql_free_result(kncheck)
	mysql_free_result(kncheck2)
	local kn = math.random(100000,999999)
	local kncheck = mysql_query(Datenbank, "SELECT * FROM `bankkonten` WHERE `GKKN`='"..MySQL_Save(kn).."'")
	local kncheck2 = mysql_query(Datenbank, "SELECT * FROM `bankkonten` WHERE `SBKN`='"..MySQL_Save(kn).."'")
	end
	mysql_free_result(kncheck)
	mysql_free_result(kncheck2)
	if(mysql_num_rows(result) == 0) then 
       	mysql_free_result(result)
       	local saved = mysql_query(Datenbank, "INSERT INTO `bankkonten` (SBKN,Benutzername) VALUES ('"..MySQL_Save(kn).."','"..MySQL_Save(getPlayerName(player)).."')")
    	mysql_free_result ( saved )
    	
    	local result = mysql_query(Datenbank, "SELECT * FROM `bankkonten` WHERE `Benutzername`='"..MySQL_Save(getPlayerName(player)).."'")
		if(mysql_num_rows(result) ~= 0) then
			local pInfo = mysql_fetch_assoc(result)
			mysql_free_result(result)
			for index,wert in pairs(pInfo) do
				if(tostring(index) ~="GeldSB" and tostring(index) ~= "GeldGK") then
					--setElementData(player,"Bank["..tostring(index).."]",tonumber(wert))
					setData(player,"Bank",tostring(index),tonumber(wert))
				else
					--setElementData(player,"Bank["..tostring(index).."]",tonumber(wert),true)
					setData(player,"Bank",tostring(index),tonumber(wert),true)
				end
			end
			setElementData(player,"KNG",getElementData(player,"Bank")["GKKN"],true)
			setElementData(player,"KNS",getElementData(player,"Bank")["SBKN"],true)
		else
			mysql_free_result(result)
		end
    elseif(mysql_num_rows(result) == 1) then
    	mysql_free_result(result)
    	local saved = mysql_query(Datenbank, "UPDATE `bankkonten` SET `SBKN`='"..MySQL_Save(kn).."' WHERE `Benutzername`='"..MySQL_Save(getPlayerName(player)).."'")
    	mysql_free_result ( saved )
    end	
	--setElementData(player,"Bank[SBKN]",kn,false)
	setData(player,"Bank","SBKN",kn)
	setElementData(player,"KNS",getElementData(player,"Bank")["SBKN"],true)
	
	outputChatBox("|______________Erstelt_____________|",player,137,255,66,true)
	outputChatBox("Vielen Dank, dass Sie ein Sparbuch bei uns angelegt haben!",player,137,255,66,true)
	outputChatBox("Sie bekommen schonmal ihr Sparbuch",player,137,255,66,true)
	outputChatBox("Ihr Konto ist nun aktiviert!",player,137,255,66,true)
	outputChatBox("Ihre Kontonummer: "..kn,player,137,255,66,true)
	outputChatBox("|__________________________________|",player,137,255,66,true)
end
end
addEvent("CreateSB",true)
addEventHandler("CreateSB", getRootElement(), sbcr)

function quitPlayer()

end
addEventHandler ( "onPlayerQuit", getRootElement(), quitPlayer )
addEventHandler ( "onResourceStop", getRootElement(), quitPlayer)

local function einzahlen(betrag,spar,giro)
local time = getRealTime()
local hour = time.hour
local minute = time.minute
if(hour < 8 or hour >= 20) then
	return 1
end
if(client == source) then
	local x,y,z = getElementPosition(source)
	if(getDistanceBetweenPoints3D (x,y,z,2315.8477, -15.3413, 26.7422) > 2.0 and getDistanceBetweenPoints3D (x,y,z,2315.8477, -7.2092, 26.7422) > 2.0) then
		outputChatBox("Du musst in der Nähe des Bankschalters sein!",source)
		return 1
	end
	if(tonumber(betrag) <= 0) then
		return 1
	end
	local money = math.sqrt((tonumber(betrag) ^ 2))
	if(getElementData(source,"UnL","GeldH") < money) then
		outputChatBox("Du hast leider nicht genug Geld auf der Hand!",source,137,255,66)
		return 1
	end
	
	outputChatBox("|________________Einzahlen________________|",source,137,255,66)
	if(giro == true) then
		outputChatBox("Alter Kontostand:      "..tostring(getElementData(source,"Bank")["GeldGK"]).." $",source,137,255,66)
	elseif(spar == true) then
		outputChatBox("Alter Kontostand:      "..tostring(getElementData(source,"Bank")["GeldSB"]).." $",source,137,255,66)
	end
	giveMoney(source, tonumber(0-money) )
	if(	giro == true) then
		setGK(source,tonumber(getElementData(source,"Bank")["GeldGK"] + money))
	elseif(spar == true) then
		setSB(source, tonumber(getElementData(source,"Bank")["GeldSB"] + money))
	end
	outputChatBox("Geänderter Betrag:   +"..tostring(money).." $",source,137,255,66)
	outputChatBox("__________________________________________",source,137,255,66)
	if(giro == true) then
		outputChatBox("Neuer Kontostand       +"..tostring(getElementData(source,"Bank")["GeldGK"]).." $",source,137,255,66)
	elseif(spar == true) then
		outputChatBox("Neuer Kontostand       +"..tostring(getElementData(source,"Bank")["GeldSB"]).." $",source,137,255,66)
	end
	triggerClientEvent(source,"einzahlenA",source)
end
end
addEvent("intrace",true)
addEventHandler("intrace",getRootElement(),einzahlen)

function abbuchen(betrag,pin,spar,giro)
local time = getRealTime()
local hour = time.hour
local minute = time.minute
if(hour < 8 or hour >= 20) then
	return 1
end
if(source == client) then
	local x,y,z = getElementPosition(source)
	if(getDistanceBetweenPoints3D (x,y,z,2315.8477, -15.3413, 26.7422) > 2.0 and getDistanceBetweenPoints3D (x,y,z,2315.8477, -7.2092, 26.7422) > 2.0) then
		outputChatBox("Du musst in der Nähe des Bankschalters sein!",source)
		return 1
	end
	local money = tonumber(betrag)
	if(money == nil) then
		return 1
	end
	if(money <= 0) then
		return 1
	end
	outputChatBox("|________________Abbuchen________________|",source,137,255,66)
	if(spar == true) then
		if(getElementData(source,"Bank")["GeldSB"] < money) then
			outputChatBox("Du hast leider nicht genug Geld auf deinem Sparbuch!",source,137,255,66)
			return 1
		end
		outputChatBox("Alter Kontostand:      "..tostring(getElementData(source,"Bank")["GeldSB"]).." $",source,137,255,66)
		setSB(source,tonumber(getElementData(source,"Bank")["GeldSB"]) - money)
		giveMoney(source,tonumber(money))
	elseif(giro == true) then
		if(tostring(getElementData(source,"Bank")["Pin"]) ~= tostring(pin) ) then
			outputChatBox("Falscher Pin!",source,137,255,66)
			return 1
		end
		if(getElementData(source,"Bank")["GeldGK"] < money) then
			outputChatBox("Du hast leider nicht genug Geld auf deinem Girokonto!",source,137,255,66)
			return 1
		end
		outputChatBox("Alter Kontostand:      "..tostring(getElementData(source,"Bank")["GeldGK"]).." $",source,137,255,66)
	
		setGK(source,tonumber(getElementData(source,"Bank")["GeldGK"] - money ))
		giveMoney(source,tonumber(money))
	
	end
	outputChatBox("Geänderter Betrag:   -"..tostring(money).." $",source,137,255,66)
	outputChatBox("__________________________________________",source,137,255,66)
	if(giro == true) then
		outputChatBox("Neuer Kontostand       +"..tostring(getElementData(source,"Bank")["GeldGK"]).." $",source,137,255,66)
	elseif(spar == true) then
		outputChatBox("Neuer Kontostand       +"..tostring(getElementData(source,"Bank")["GeldSB"]).." $",source,137,255,66)
	end
	
	triggerClientEvent(source,"aevent",source)

end
end
addEvent("extracte",true)
addEventHandler("extracte",getRootElement(),abbuchen)

local function traweisung(betrag,zielkn,zielname,vz1,vz2)
local time = getRealTime()
local hour = time.hour
local minute = time.minute
local second  = time.second
if(hour < 8 or hour >= 20) then
	return 1
end
if(source == client) then
	local x,y,z = getElementPosition(source)
	if(getDistanceBetweenPoints3D (x,y,z,2315.8477, -15.3413, 26.7422) > 2.0 and getDistanceBetweenPoints3D (x,y,z,2315.8477, -7.2092, 26.7422) > 2.0) then
		outputChatBox("Du musst in der Nähe des Bankschalters sein!",source)
		return 1
	end
	if(betrag == "" or zielkn == "" or zielname == "" or vz1 == "") then
		outputChatBox("Bitte fülle ALLE Felder aus!",source,137,255,66)
		return 1
	end
	local money = tonumber(betrag)
	if(money <= 0 ) then
		return 1
	end
	if(zielname == getPlayerName(source) or tonumber(zielkn) == getElementData(source,"Bank")["GKKN"]) then
		outputChatBox("Du kannst dir selbst kein Geld überweisen!",source,137,255,66)
		return 1
	end
	if(getElementData(source,"Bank")["GeldGK"] < money) then
		outputChatBox("Du hast nicht genug Geld auf deinem Girokonto!",source,137,255,66)
		return 1
	end
	local vz = vz1.." "..vz2
	
	
	result = mysql_query(Datenbank, "SELECT * FROM `bankkonten` WHERE `Benutzername`='"..MySQL_Save(zielname).."'")
	if(mysql_num_rows(result) == 0) then
		outputChatBox(zielname.." besitzt kein Konto oder existiert nicht!",source,137,255,66)
		mysql_free_result(result)
		return 1
	end
	mysql_free_result(result)


	result = mysql_query(Datenbank, "SELECT * FROM `bankkonten` WHERE `GKKN`='"..MySQL_Save(zielkn).."'")
	if(mysql_num_rows(result) == 0) then
		outputChatBox("Die Girokontonummer ( "..zielkn.." ) gehört keinen Spieler",source,137,255,66)
		mysql_free_result(result)
		return 1
	end
	mysql_free_result(result)

	
	
	result = mysql_query(Datenbank, "SELECT * FROM `bankkonten` WHERE `GKKN`='"..MySQL_Save(zielkn).."' AND `Benutzername`='"..MySQL_Save(zielname).."'")
	if(mysql_num_rows(result) == 0) then
		outputChatBox("Die Girokontonummer ( "..zielkn.." ) gehÃ¶rt nicht dem Spieler "..zielname)
		mysql_free_result(result)
		return 1
	end
	mysql_free_result(result)

	setGK(source, tonumber(getGK(source)-money) )
	local ziel = getPlayerFromName(zielname)
	
	local result = mysql_query(Datenbank,"SELECT `GeldGK` FROM `bankkonten` WHERE `Benutzername`='"..zielname.."'")
	local alt = mysql_fetch_assoc(result)
	mysql_free_result ( result )
	if(ziel) then
		setGK(ziel,tonumber(getGK(ziel) + money) )
		outputChatBox("Du hast gerade Geld überwiesen bekommen. Für genauere Informationen besuche die Bank!",ziel,137,255,66)
	elseif(ziel == false) then
		local saved = mysql_query(Datenbank,"UPDATE `bankkonten` SET `GeldGK`='"..MySQL_Save(tostring(alt["GeldGK"] + money)).."', `Neues`='1' WHERE `GKKN`='"..MySQL_Save ( zielkn ).."'")
		mysql_free_result ( saved )
	end
		
		local time = getRealTime()
		local month = time.monthday
		local day = time.month + 1
		local year = time.year + 1900
		local datum = year.."-"..month.."-"..day
		local zeit = time.hour..":"..time.minute..":"..time.second
		local saved = mysql_query(Datenbank, "INSERT INTO `ueberweisungen` (Adressat,Absender,Betrag,Verwendungszweck,Datum,Uhrzeit) VALUES ('"..MySQL_Save(tostring( zielname )).."','"..MySQL_Save(tostring( getPlayerName(source) )).."','"..MySQL_Save(tostring( money )).."','"..MySQL_Save(tostring( vz )).."','"..datum.."','"..zeit.."')")
		mysql_free_result( saved )
	
	triggerClientEvent(source,"transA",source)
end
end
addEvent("transaction",true)
addEventHandler("transaction",getRootElement(),traweisung)

local function checkT()
if(client == source) then
	local time = getRealTime()
	local hour = time.hour
	local minute = time.minute
	if(hour < 8 or hour >= 20) then
		triggerClientEvent(source,"closeBank",source)
		outputChatBox("~Geschlossen~",source)
	elseif(hour >= 8 and hour < 20) then
		triggerClientEvent(source,"openBank",source)
	end
end
end
addEvent("checkTime",true)
addEventHandler("checkTime",getRootElement(),checkT)

function updateKontostand(player)
	local saved = mysql_query(Datenbank,"UPDATE `benutzertabelle` SET `GeldH`='"..MySQL_Save ( tostring(getElementData(player,"UnL","GeldH")) ).."' WHERE `Benutzername`='"..MySQL_Save ( getPlayerName(player) ).."'")
	mysql_free_result ( saved )
	local saved = mysql_query(Datenbank,"UPDATE `bankkonten` SET `GeldSB`='"..MySQL_Save ( tostring(getElementData(player,"Bank")["GeldSB"]) ).."' , `GeldGK`='"..MySQL_Save ( tostring (getElementData(player,"Bank")["GeldGK"]) ).."' WHERE `Benutzername`='"..MySQL_Save ( getPlayerName(player) ).."'")
	mysql_free_result ( saved ) 
end -- MySQL Update


function bankNews(player)
	if(getElementData(player,"Bank") and getElementData(player,"Bank")["Neues"] == 1) then
		setTimer(delay,2500,1,player)
	end
end

function delay(player)
	createInfobox(player,"Bankinfo","Während du offline warst ist mindestens eine Überweisung auf Ihren Konto eingegangen. Gehe zur Bank und nutze den Infocomputer, um mehr Informationen zu erhalten!","infobank.png")
    local saved = mysql_query(Datenbank,"UPDATE `bankkonten` SET `Neues`='0' WHERE `Benutzername`='"..MySQL_Save ( getPlayerName(player) ).."'")
	mysql_free_result ( saved ) 
	--setElementData(player,"Bank[Neues]", 0,false)
	setData(player,"Bank","Neues",0)
end