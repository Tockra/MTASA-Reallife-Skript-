local function RegisterMYSQL(playerid, name, pw, geburtstag, geschlecht)
if(client == playerid) then
	if(#name < 5)then
		return 1
	end
	
	if(#name > 16) then
		return 1
	end
	
	if(getElementData(playerid,"loggedin") == true) then
		return 1
	end
        local result = mysql_query(Datenbank, "SELECT * FROM `benutzertabelle` WHERE `Serial`='"..getElementData(playerid,"PlayerSerial").."'")
        if(mysql_num_rows(result) >= 1) then 
        	mysql_free_result(result)
        	outputChatBox("Du hast an diesem Computer bereits einen Account registriert. Bitte log dich mit diesen ein!",playerid)
            triggerClientEvent(playerid,"RegisterDialog",playerid)
            return 1          		
        end
        local result = mysql_query(Datenbank, "SELECT * FROM `benutzertabelle` WHERE `Benutzername`='"..MySQL_Save(name).."'")
        if(mysql_num_rows(result) >= 1) then
        	mysql_free_result(result)
        	outputChatBox("Der Name "..name.." wurde bereits registriert! Such dir bitte einen anderen NickNamen aus!",playerid)
        	triggerClientEvent(playerid,"RegisterDialog",playerid)
        	return 1
        end
        --local saved = mysql_query(Datenbank, "INSERT INTO `benutzertabelle` (Serial,Benutzername,Geburtsdatum,Geschlecht,Passwort,Skin,X,Y,Z) VALUES ('"..MySQL_Save(getElementData(playerid,"PlayerSerial")).."','"..MySQL_Save(name).."','"..MySQL_Save(geburtstag).."','"..MySQL_Save(geschlecht).."','"..MySQL_Save(pw).."','"..MySQL_Save(tostring(101))..MySQL_Save(tostring(1193.2167)).."','"..MySQL_Save(tostring(-1266.1366)).."','"..MySQL_Save(tostring(23.6099)).."')")
        local saved = mysql_query(Datenbank, "INSERT INTO `benutzertabelle` (Benutzername,Passwort,Serial,Geschlecht,Geburtsdatum) VALUES ('"..MySQL_Save(name).."','"..MySQL_Save(pw).."','"..MySQL_Save(getPlayerSerial(playerid) ).."','"..MySQL_Save(geschlecht).."','"..MySQL_Save(geburtstag).."')")
		mysql_free_result(saved)
        addAccount ( string.lower(name), pw )													
        if(saved) then
        	outputChatBox("Vielen Dank, dein Account wurde registriert.",playerid)
        	outputChatBox("Dein Passwort lautet: "..pw,playerid)
       	 	outputChatBox("Bitte schreib es dir auf, da du dich sonst nicht mehr registrieren kannst!",playerid)
       	 	outputChatBox("Jetzt kannst du dich Anmelden.",playerid)
       	 	triggerClientEvent(playerid,"LoginDialog",playerid)
        elseif(not saved) then
        	outputChatBox("Es trat ein schwerwiegender Fehler auf!!! Du wirst nun gekickt, um den Fehler zu beheben! Wenn dieser Fehler wiederholt auftritt, dann melde dies bitte schnellsmÃ¶glich einen Admin",playerid)
       	
        end
        setPlayerName(playerid,name)
		triggerEvent("onPlayerRegister",playerid,name)
end
end
addEvent( "register", true )
addEventHandler( "register", getRootElement(), RegisterMYSQL )


local function LoginCheck(playerid, nick, pw)
if(client == playerid) then
	if(#nick < 5)then
		return 1
	end -- Check ob der Name mehr als 5 Zeichen hat
	local account = getAccount ( string.lower(nick) ) 
	if(account == false) then
		outputChatBox("Der Benutzername: "..nick.." existiert nicht, bitte registrier dich!", playerid)
		triggerClientEvent(playerid,"LoginDialog",playerid)
		return 1
	end -- Check ob der Account Ã¼berhaupt existiert
	local account = getAccount ( string.lower(nick), pw )
	if(account == false) then
		outputChatBox("Dein Passwort ist falsch, sie haben noch "..tostring(maxpwtrys - getElementData(playerid,"pwtrys")).." sonst werden sie gebannt",playerid)
		triggerClientEvent(playerid,"LoginDialog",playerid)
		wrongPassword(playerid)
		return 1
	end -- Check ob das Passwort zu dem Account passt
	
	setElementData(playerid,"logginA",true,false)
	logIn ( playerid, account, pw )
	setElementData(playerid,"logginA",false,false)

	local result = mysql_query(Datenbank, "SELECT * FROM `benutzertabelle` WHERE `Benutzername`='"..MySQL_Save(nick).."'")
	if(mysql_num_rows(result) ~= 0) then
		local pInfo = mysql_fetch_assoc(result)
		mysql_free_result(result)
		for index,wert in pairs(pInfo) do
			if(tonumber(wert)) then
				setData(playerid,"UnL",tostring(index),tonumber(wert))
			else
				setData(playerid,"UnL",tostring(index),wert)
			end
		end
		setData(playerid,"UnL","Passwort",false)
	elseif(mysql_num_rows(result) == 0) then
		outputChatBox("Aus irgendeinen Grund existiert dein Benutzerkonto auf dem Server, aber nicht in der Datenbank!",playerid,255,0,0)
		outputChatBox("Bitte erstelle ein Thread im Bug Bereich unseres Forums!",playerid,255,0,0)
		return 1
	else
		mysql_free_result(result)
	end
	
	setElementData(playerid,"SpielerName",nick)
	setPlayerName ( playerid, nick )
	setElementData(playerid,"loggedin",true,false)
	
	setOldFriedhofData(playerid)
	givePlayerMoney(playerid, tonumber(getElementData(playerid,"UnL","GeldH")))
	triggerEvent("afterPlayerLogin",playerid)
	if(tonumber(getElementData(playerid,"Friedhof[Tod]") ) ~=1) then
		local x,y,z = getPlayerSpawn(playerid)
		spawnPlayer ( playerid, x,y,z, getElementData(playerid,"UnL","Rotation"), getSkin(playerid) )
		setCameraTarget(playerid,playerid)
	elseif(tonumber( getElementData(playerid,"Friedhof[Tod]") ) == 1) then
		vFriedhof(playerid)
		setCameraTarget(playerid,playerid)
	end

	
--	spawnPlayer(playerid, 3101.984375, -2312.6472167969,6100.404296875, 0,101)
--	setElementDimension(playerid,5)
	
	checkKrankenhaus(playerid)
end
end
addEvent("logincheck",true)
addEventHandler("logincheck", getRootElement(), LoginCheck)



local function onPLogin()
	if(	getElementData(source,"logginA") == false) then
		outputChatBox("Du kannst dich hier nur über das Log-In Fenster einloggen !",source)
		cancelEvent()
	end
end
addEventHandler("onPlayerLogin", getRootElement(),onPLogin)

local function loggedOut()
	cancelEvent()
	outputChatBox( "Du kannst dich nicht ausloggen !", source )
end
addEventHandler("onPlayerLogout",getRootElement(),loggedOut)

