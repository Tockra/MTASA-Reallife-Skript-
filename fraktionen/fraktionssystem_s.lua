--local rankName ={}
--local rankName["Medic"] = {}
--local rankName["Medic"] = {[1] = "Auszubildender",[2] = "Krankenwagenfahrer",[3] = "Assistenzarzt",[4] = "Arzt",[5] = "Chefarzt"}
--local rankNameRanks = {["Medic"]["Auszubildender"] = 1,["Medic"]["Krankenwagenfahrer"] = 2,["Medic"]["Assistenzarzt"] = 3,["Medic"]["Arzt"] = 4,["Medic"]["Chefarzt"] = 5}
local rankName ={}
rankName["Medic"] = {[1] = "Praktikant",[2] = "Auszubildender",[3] = "Assistenzarzt",[4] = "Arzt",[5] = "Chefarzt"}

local rankNameRanks = {}
rankNameRanks["Medic"] = {["Praktikant"] = 1,["Auszubildender"] = 2,["Assistenzarzt"] = 3,["Arzt"] = 4,["Chefarzt"] = 5}

local rankTimes = {} 
local fraktionInv = {}
local Clicker = {}

local function makeleader(player, cn, ziel)
	local zplayer
	
	if(tostring(ziel) =="") then
		return 1
	end
	
	if(tonumber(ziel)) then
		if(tonumber(ziel) < 0) then
			outputChatBox("Bitte gebe eine gültige ID ein!",player,255,0,0)
			return 1
		end
		zplayer = ID[tonumber(ziel)]
		if(zplayer == nil) then
			outputChatBox("Die ID "..tostring(ziel).." gehört zu keinem Spieler!",player,255,0,0)
			return 1
		end
	else
		zplayer = getPlayerFromName(tostring(ziel))
		if(zplayer == false) then
			outputChatBox(tostring(ziel).." ist im Augenblick leider nicht auf dem Server!",player,255,0,0)
			return 1
		end
	end
	if(getElementData(zplayer,"Fraktionen[Leader]") ~= 0) then
		outputChatBox(getPlayerName(zplayer).." ist bereits Leader seiner Fraktion oder gehört keiner Fraktion an!",player,255,0,0)
		return 1
	end
	
	setElementData(zplayer,"Fraktionen[Leader]",1)
	local saved = mysql_query(Datenbank,"UPDATE `spielerfraktion` SET `Leader`='"..MySQL_Save ( 1 ).."' WHERE `Name`='"..MySQL_Save ( getPlayerName(zplayer) ).."'")
	mysql_free_result ( saved )
	
	outputChatBox("Du hast soeben "..getPlayerName(zplayer).." zum Leader seiner Fraktion gemacht!",player,255,0,0)
	outputChatBox("Du wurdest soeben von einem Admin zum Leader deiner Fraktion gemacht!",zplayer,200,200,0)
end
addCommandHandler("makeleader",makeleader,false,false)

local function deleteLeader(player, cn, ziel)
	local zplayer
	
	if(tostring(ziel) =="") then
		return 1
	end
	
	if(tonumber(ziel)) then
		if(tonumber(ziel) < 0) then
			outputChatBox("Bitte gebe eine gültige ID ein!",player,255,0,0)
			return 1
		end
		zplayer = ID[tonumber(ziel)]
		if(zplayer == nil) then
			outputChatBox("Die ID "..tostring(ziel).." gehört zu keinem Spieler!",player,255,0,0)
			return 1
		end
	else
		zplayer = getPlayerFromName(tostring(ziel))
		if(zplayer == false) then
			outputChatBox(tostring(ziel).." ist im Augenblick leider nicht auf dem Server!",player,255,0,0)
			return 1
		end
	end
	if(getElementData(zplayer,"Fraktionen[Leader]") ~= 1) then
		outputChatBox(getPlayerName(zplayer).." ist im Augenblick kein Leader!",player,255,0,0)
		return 1
	end
	
	setElementData(zplayer,"Fraktionen[Leader]",0)
	local saved = mysql_query(Datenbank,"UPDATE `spielerfraktion` SET `Leader`='"..MySQL_Save ( 0 ).."' WHERE `Name`='"..MySQL_Save ( getPlayerName(zplayer) ).."'")
	mysql_free_result ( saved )
	
	outputChatBox("Du hast soeben "..getPlayerName(zplayer).." wieder zu einen normalen Fraktionsmitglied gemacht!",player,255,0,0)
	outputChatBox("Dir wurden soeben von einem Admin die Leaderrechte entzogen!",zplayer,200,200,0)
end
addCommandHandler("deleteLeader",deleteLeader)

function createTeams(rs) -- Fortführung von onResourceStart
	if(rs ~= getThisResource()) then
		return 0
	end
	
	local result = mysql_query(Datenbank, "SELECT * FROM `fraktionen`")
	if(mysql_num_rows(result) ~= 0) then
		for index,wert in mysql_rows_assoc(result) do
			createTeam(tostring(wert["Fraktion"]))
			local result2 = mysql_query(Datenbank,"SELECT * FROM `fraktionen` WHERE `Fraktion`='"..wert["Fraktion"].."'")
			local Info = mysql_fetch_assoc(result2)
			mysql_free_result(result2)
			for i,v in pairs(Info) do
				if(tonumber(v)) then
					setElementData(getRootElement(),tostring(wert["Fraktion"]).."["..tostring(i).."]",tonumber(v),false)
				else
					setElementData(getRootElement(),tostring(wert["Fraktion"]).."["..tostring(i).."]",v,false)
				end
			end
		end
		mysql_free_result(result)
	else
		mysql_free_result(result)
	end

	rankTimes[1] = getElementData(getRootElement(),"Settings","fraktionMinimumRankTime_1")
	rankTimes[2] = getElementData(getRootElement(),"Settings","fraktionMinimumRankTime_2")
	rankTimes[3] = getElementData(getRootElement(),"Settings","fraktionMinimumRankTime_3")
	rankTimes[4] = getElementData(getRootElement(),"Settings","fraktionMinimumRankTime_4")
end
addEventHandler("onResourceStart",getRootElement(),createTeams)
local function onLogin()
	local playername = getPlayerName(source)
	local result = mysql_query(Datenbank, "SELECT * FROM `spielerfraktion` WHERE `Name`='"..MySQL_Save(playername).."'")
	if(mysql_num_rows(result) ~= 0) then
		local pInfo = mysql_fetch_assoc(result)
		mysql_free_result(result)
		for index,wert in pairs(pInfo) do
			if(tonumber(wert)) then
				setElementData(source,"Fraktionen["..tostring(index).."]",tonumber(wert),false)
			else
				setElementData(source,"Fraktionen["..tostring(index).."]",wert,false)
			end
		end
	else
		mysql_free_result(result)
	end
	
	if(getElementData(source,"Fraktionen[Fraktion]") ~="" ) then
		local team = getTeamFromName ( tostring(getElementData(source,"Fraktionen[Fraktion]")) )
		if(team) then
			setPlayerTeam ( source, team )
		end
	end
	
	triggerEvent("onPlayerGetFraktionsData",source,getElementData(source,"Fraktionen[Fraktion]"))
end
addEvent("afterPlayerLogin",true)
addEventHandler("afterPlayerLogin",getRootElement(),onLogin)

local function showLeaderPanel(player)
	if(not antiSpam(player)) then
		return 1
	end
	if(getElementData(player,"Fraktionen[Leader]") == 1) then
		local Fraktion = getElementData(player,"Fraktionen[Fraktion]")
		local Kassenzuwachs = getElementData(getRootElement(),tostring(Fraktion).."[Kassenzuwachs]")
		local Kassenstand = getElementData(getRootElement(),tostring(Fraktion).."[Kasse]")
		local gehalt1 = getElementData(getRootElement(),tostring(Fraktion).."[Gehaltsklasse 1]")
		local gehalt2 = getElementData(getRootElement(),tostring(Fraktion).."[Gehaltsklasse 2]")
		local gehalt3 = getElementData(getRootElement(),tostring(Fraktion).."[Gehaltsklasse 3]")
		local gehalt4 = getElementData(getRootElement(),tostring(Fraktion).."[Gehaltsklasse 4]")
		local gehalt5 = getElementData(getRootElement(),tostring(Fraktion).."[Gehaltsklasse 5]")
		local minL = getElementData(getRootElement(),tostring(Fraktion).."[GehaltMin]")
		local maxL = getElementData(getRootElement(),tostring(Fraktion).."[GehaltMax]")
		local result = mysql_query(Datenbank, "SELECT * FROM `spielerfraktion` WHERE `Fraktion`='"..MySQL_Save(getElementData(player,"Fraktionen[Fraktion]")).."'")
        local mitgliederZ = mysql_num_rows(result)
		local online = countPlayersInTeam ( getPlayerTeam(player) )
		mysql_free_result(result)
		local mitgliederMax = getElementData(getRootElement(),tostring(Fraktion).."[MaxPlayers]")
		createListeFL(player)
		triggerClientEvent(player,"showLeaderPanel",player,Fraktion,Kassenzuwachs,Kassenstand,gehalt1,gehalt2,gehalt3,gehalt4,gehalt5,minL,maxL,mitgliederZ,mitgliederMax,online)
	end
end
addCommandHandler("show",showLeaderPanel)

local function saveGehaltRanks(gh1,gh2,gh3,gh4,gh5)
	if(client == source) then
		if(not antiSpam(source)) then
			return 1
		end
		local g1,g2,g3,g4,g5 = tonumber(gh1),tonumber(gh2),tonumber(gh3),tonumber(gh4),tonumber(gh5)
		local Fraktion = getElementData(source,"Fraktionen[Fraktion]")
		local mindl = tonumber(getElementData(getRootElement(),tostring(Fraktion).."[GehaltMin]"))
		local maxl = tonumber(getElementData(getRootElement(),tostring(Fraktion).."[GehaltMax]"))
		if(getElementData(source,"Fraktionen[Leader]") ~= 1) then
			return 1
		end
		if(g1 < mindl) then
			outputChatBox("Ein Mitglied dieser Fraktion muss mindestens "..tostring(mindl).." $ als Lohn erhalten!",source,175,175,175)
			return 1
		end
		
		if(g5 > maxl) then
			outputChatBox("Ein Mitglied dieser Fraktion kann maximal "..tostring(maxl).." $ als Lohn erhalten!",source,175,175,175)
			return 1
		end
		if(g1 >= g2) then
			outputChatBox("Der Gehalt des zweiten Ranges darf nicht geringer oder gleich groß sein, als der des ersten!",source,175,175,175)
			return 1
		end
		
		if(g2 >= g3) then
			outputChatBox("Der Gehalt des dritten Ranges darf nicht geringer oder gleich groß sein, als der des zweiten!",source,175,175,175)
			return 1	
		end
		
		if(g3 >= g4) then
			outputChatBox("Der Gehalt des vierten Ranges darf nicht geringer oder gleich groß sein, als der des dritten!",source,175,175,175)
			return 1
		end
		
		if(g4 >= g5) then
			outputChatBox("Der Gehalt des fünften Ranges darf nicht geringer oder gleich groß sein, als der des vierten!",source,175,175,175)
			return 1
		end
		setElementData(getRootElement(),tostring(Fraktion).."[Gehaltsklasse 1]",g1)
		setElementData(getRootElement(),tostring(Fraktion).."[Gehaltsklasse 2]",g2)
		setElementData(getRootElement(),tostring(Fraktion).."[Gehaltsklasse 3]",g3)
		setElementData(getRootElement(),tostring(Fraktion).."[Gehaltsklasse 4]",g4)
		setElementData(getRootElement(),tostring(Fraktion).."[Gehaltsklasse 5]",g5)
		local saved = mysql_query(Datenbank,"UPDATE `fraktionen` SET `Gehaltsklasse 1`='"..MySQL_Save ( getElementData(getRootElement(),tostring(Fraktion).."[Gehaltsklasse 1]") ).."', `Gehaltsklasse 2`='"..MySQL_Save ( getElementData(getRootElement(),tostring(Fraktion).."[Gehaltsklasse 2]") ).."',`Gehaltsklasse 3`='"..MySQL_Save ( getElementData(getRootElement(),tostring(Fraktion).."[Gehaltsklasse 3]") ).."',`Gehaltsklasse 4`='"..MySQL_Save ( getElementData(getRootElement(),tostring(Fraktion).."[Gehaltsklasse 4]") ).."',`Gehaltsklasse 5`='"..MySQL_Save ( getElementData(getRootElement(),tostring(Fraktion).."[Gehaltsklasse 5]") ).."' WHERE `Fraktion`='"..MySQL_Save ( Fraktion ).."'")
		mysql_free_result ( saved )
		outputChatBox("Die neuen Löhne wurden erfolgreich gespeichert!",source,200,200,0)
	end
end
addEvent("saveGehalt",true)
addEventHandler("saveGehalt",getRootElement(),saveGehaltRanks)

local function onQuit()
	fraktionInv[source] = nil
	if(getElementData(source,"Fraktionen[Fraktion]")) then
		local saved = mysql_query(Datenbank,"UPDATE `spielerfraktion` SET `Rang`='"..MySQL_Save ( getElementData(source,"Fraktionen[Rang]") ).."',`RankDatum`='"..MySQL_Save ( getElementData(source,"Fraktionen[RankDatum]") ).."',`Sonstiges`='"..MySQL_Save ( getElementData(source,"Fraktionen[Sonstiges]") ).."',`Skin`='"..MySQL_Save ( getElementData(source,"Fraktionen[Skin]") ).."' WHERE `Name`='"..MySQL_Save ( getPlayerName(source) ).."'")
		mysql_free_result ( saved )
	end	
end
addEventHandler("onPlayerQuit",getRootElement(),onQuit)
local function einstellen()
	if(source == client) then
		if(getElementData(source,"Fraktionen[Leader]") == 1) then
			if(getElementData(source,"Friedhof[Tod]") == 1 or getElementData(source,"LeaderInv") ~= false) then
				return 1
			end
			local result = mysql_query(Datenbank, "SELECT * FROM `spielerfraktion` WHERE `Fraktion`='"..MySQL_Save(getElementData(source,"Fraktionen[Fraktion]")).."'")
			local mitgliederZ = mysql_num_rows(result)
			mysql_free_result(result)
			if(mitgliederZ >= getElementData(getRootElement(),getElementData(source,"Fraktionen[Fraktion]").."[MaxPlayers]")) then
				outputChatBox("Du kannst keinen weiteren Spielern einen Job anbieten!",source,175,175,175)
				return 1
			end
			setElementData(source,"LeaderInv",createInfobox(source,"Arbeitsvertrag", "Du kannst nun einen Spieler einen Arbeitsvertrag überreichen! Wenn du einem Spieler einen Job anbieten möchtest, dann klicke ihn an!","fraktionadd.png",true))
			addEventHandler("onPlayerClick",source,onLeaderInvClick)
		end
	end
end
addEvent("einstellen",true)
addEventHandler("einstellen",getRootElement(),einstellen)

function onLeaderInvClick(mb,ms,target)
	if(mb ~= "left") then
		return 1
	end
	if(ms ~= "down") then
		return 1
	end
	if(not target) then
		return 1
	end
	if(getElementType(target) ~= "player") then
		return 1
	end
	
	if(getElementData(source,"Fraktionen[Leader]") ~= 1) then
		removeEventHandler("onPlayerClick",source,onLeaderInvClick)
		destroyInfobox(source,getElementData(source,"LeaderInv"))
		setElementData(source,"LeaderInv",false)
		return 1
	end
	
	if(target == source) then
		removeEventHandler("onPlayerClick",source,onLeaderInvClick)
		destroyInfobox(source,getElementData(source,"LeaderInv"))
		setElementData(source,"LeaderInv",false)
		return 1
	end  
	if(getElementData(target,"Fraktionen[Fraktion]")) then
		outputChatBox(getPlayerName(target).." ist bereits Mitglied einer Fraktion!",source,175,175,175)
		destroyInfobox(source,getElementData(source,"LeaderInv"))
		setElementData(source,"LeaderInv",false)
		return 1
	end
	local x,y,z = getElementPosition(target)
	local bx,by,bz = getElementPosition(source)
	if(getDistanceBetweenPoints3D(x,y,z,bx,by,bz) > 8) then
		outputChatBox(getPlayerName(target).." ist zu weit entfernt um ihn einen Arbeitsvertrag zu übergeben.",source,175,175,175)
		return 1
	end
	
	if(fraktionInv[target] == nil) then
		fraktionInv[target] = getElementData(source,"Fraktionen[Fraktion]")
		triggerClientEvent(target,"showInviteFraktion",target,getPlayerName(source),fraktionInv[target])
		removeEventHandler("onPlayerClick",source,onLeaderInvClick)
		destroyInfobox(source,getElementData(source,"LeaderInv"))
		setElementData(source,"LeaderInv",false)
		outputChatBox("Du hast "..getPlayerName(target).." erfolgreich den Arbeitsvertrag überreicht!",source,51,204,255)
		outputServerLog(getPlayerName(source).." hat "..getPlayerName(target).." einen Arbeitsvertrag übergeben! Fraktion: "..getElementData(source,"Fraktionen[Fraktion]"))
	else
		outputChatBox(getPlayerName(target).." wurde bereits ein Arbeitsvertrag überreicht!",source,175,175,175)
		destroyInfobox(source,getElementData(source,"LeaderInv"))
		setElementData(source,"LeaderInv",false)
	end
end

local function setFraktion()
	if(source == client) then
		if(fraktionInv[source] == nil) then
			return 1
		end
		local target = source
		local time = getRealTime()
		setElementData(target,"Fraktionen[Fraktion]",fraktionInv[target])
		local group = aclGetGroup(tostring(fraktionInv[target]))
		local team = getTeamFromName(tostring(fraktionInv[target]))
		setPlayerTeam ( target, team )
		aclGroupAddObject ( group, "user."..string.lower(getPlayerName(target)))
		aclSave()
		setElementData(target,"Fraktionen[JoinDatum]",time.timestamp)
		setPlayerRank(target,1)
		fraktionInv[target] = nil
		setElementData(source,"Fraktionen[Skin]",getElementData(getRootElement(),getElementData(target,"Fraktionen[Fraktion]").."[FirstSkin]"))
		setElementData(source,"Fraktionen[Sonstiges]",0)
		local result = mysql_query(Datenbank, "SELECT * FROM `spielerfraktion` WHERE `Name`='"..MySQL_Save(getPlayerName(source)).."'")
		local nums = mysql_num_rows(result)
		mysql_free_result(result)
		if(nums == 0) then
			if(getElementData(source,"Fraktionen[Fraktion]")) then
				local saved = mysql_query(Datenbank, "INSERT INTO `spielerfraktion` (Name,Fraktion,Rang,JoinDatum,RankDatum,Skin) VALUES ('"..MySQL_Save(getPlayerName(source)).."','"..MySQL_Save(getElementData(source,"Fraktionen[Fraktion]")).."','"..MySQL_Save(getElementData(source,"Fraktionen[Rang]") ).."','"..MySQL_Save(getElementData(source,"Fraktionen[JoinDatum]")).."','"..MySQL_Save(getElementData(source,"Fraktionen[RankDatum]")).."','"..MySQL_Save(getElementData(source,"Fraktionen[Skin]")).."')")
				mysql_free_result(saved)
			end
		end
		outputChatBox("Herzlichen Glückwunsch du gehörst ab nun zu einer Fraktion!",target,0,255,0)
		outputServerLog(getPlayerName(source).." hat den Arbeitsvertrag angenommen! Fraktion: "..getElementData(source,"Fraktionen[Fraktion]"))
		triggerEvent("onPlayerFraktionJoin",source,getElementData(source,"Fraktionen[Fraktion]"))
	end
end
addEvent("FraktionInviteAccept",true)
addEventHandler("FraktionInviteAccept",getRootElement(),setFraktion)

local function cancelFraInvite()
	if(client == source) then
		fraktionInv[source] = nil
	end
end
addEvent("FraktionInviteCancel",true)
addEventHandler("FraktionInviteCancel",getRootElement(),cancelFraInvite)

function setPlayerRank(player,Rank)
	if(not getPlayerName(player)) then
		return false
	end
	if(Rank > 5 or Rank < 1) then
		return false
	end
	if(getElementData(player,"Fraktionen[Fraktion]")) then
		local time = getRealTime()
		setElementData(player,"Fraktionen[Rang]",rankName[tostring(getElementData(player,"Fraktionen[Fraktion]"))][Rank])
		setElementData(player,"Fraktionen[RankDatum]",time.timestamp)
	end
end

function getPlayerRank(player,rank)
	local fraktion = getElementData(player,"Fraktionen[Fraktion]")
	return rankNameRanks[tostring(fraktion)][tostring(rank)]
end

function createListeFL(leader)
	local result = mysql_query(Datenbank, "SELECT * FROM `spielerfraktion` WHERE `Fraktion`='"..MySQL_Save(getElementData(leader,"Fraktionen[Fraktion]")).."'")
	for k,row in mysql_rows_assoc(result) do
		local player = getPlayerFromName(row["Name"])
		local R,G,B = getElementData(getRootElement(),getElementData(leader,"Fraktionen[Fraktion]").."[R]"),getElementData(getRootElement(),getElementData(leader,"Fraktionen[Fraktion]").."[G]"),getElementData(getRootElement(),getElementData(leader,"Fraktionen[Fraktion]").."[B]")
		if(player) then
			triggerClientEvent(leader,"createLineFL",leader,row["Name"],getElementData(player,"Fraktionen[Rang]"),getPlayerRank(player,getElementData(player,"Fraktionen[Rang]")),getElementData(player,"Fraktionen[RankDatum]"),getElementData(player,"Fraktionen[JoinDatum]"),false,R,G,B)
		else
			triggerClientEvent(leader,"createLineFL",leader,row["Name"],row["Rang"],getPlayerRank(leader,tostring(row["Rang"])),row["RankDatum"],row["JoinDatum"],true)
		end
	end
	mysql_free_result(result)
end

local function playerRankUp(playern)
	if(not antiSpam(source)) then
		return 1
	end
	if(client ~= source) then
		return 1
	end
	if(getElementData(source,"Fraktionen[Leader]") ~= 1) then
		return 1
	end
	local player = getPlayerFromName(playern)
	if(not player) then
		outputChatBox(playern.." muss online sein, damit du ihn befördern kannst!")
		return 1
	end
	if(getElementData(source,"Fraktionen[Fraktion]") ~= getElementData(player,"Fraktionen[Fraktion]")) then
		return 1
	end
	local rank = getPlayerRank(player,getElementData(player,"Fraktionen[Rang]"))
	local time = getRealTime()
	local zeitAufRang = time.timestamp - getElementData(player,"Fraktionen[RankDatum]")

	if(rank == 5 ) then
		outputChatBox("Es gibt keinen höheren Rang in einer Fraktion, als Rang 5!",source,175,175,175)
		return 1
	end
	if(zeitAufRang >= rankTimes[rank]) then
		setPlayerRank(player,rank + 1)
		outputChatBox("Herzlichen Glückwunsch, du wurdest soeben von "..getPlayerName(source).." zum "..getElementData(player,"Fraktionen[Rang]").." befördert!",player,0,200,0)
		outputChatBox("* Du hast soeben "..playern.." zum "..getElementData(player,"Fraktionen[Rang]").." befördert!",source,51,204,255)
		triggerClientEvent(source,"setListedRank",source,playern,getElementData(player,"Fraktionen[Rang]"),getPlayerRank(player,getElementData(player,"Fraktionen[Rang]")))
		outputServerLog ( getPlayerName(source).." hat "..playern.." auf Rang "..getPlayerRank(player,getElementData(player,"Fraktionen[Rang]")).." befördert! Fraktion: "..getElementData(source,"Fraktionen[Fraktion]"))
	else
	local timeTo = rankTimes[rank] - zeitAufRang
	local days = math.floor(timeTo/60/60/24)
	local hours = math.floor(((timeTo/60/60/24) %1)*24)
	if(days < 1) then
		outputChatBox(getPlayerName(player).." muss noch ungefähr "..tostring(hours).." Stunde(n) auf seinem aktuellen Rang bleiben!",source,175,175,175)
	else
		outputChatBox(getPlayerName(player).." muss noch "..tostring(days).." Tag(e) und "..tostring(hours).." Stunde(n) auf seinem aktuellen Rang bleiben!",source,175,175,175)
	end
	end
end
addEvent("rankUp",true)
addEventHandler("rankUp",getRootElement(),playerRankUp)

local function playerRankDown(playern)
	if(not antiSpam(source)) then
		return 1
	end
	if(client ~= source) then
		return 1
	end
	if(getElementData(source,"Fraktionen[Leader]") ~= 1) then
		return 1
	end
	
	local player = getPlayerFromName(playern)
	if(player) then
		if(getElementData(source,"Fraktionen[Fraktion]") ~= getElementData(player,"Fraktionen[Fraktion]")) then
			return 1
		end
		local rank = getPlayerRank(player,getElementData(player,"Fraktionen[Rang]"))
		if(rank == 1 ) then
			outputChatBox("Es gibt keinen niedrigeren Rang in einer Fraktion, als Rang 1!",source,175,175,175)
			return 1
		end
		
		setPlayerRank(player,rank - 1)
		outputChatBox("Du wurdest soeben von "..getPlayerName(source).." zum "..getElementData(player,"Fraktionen[Rang]").." degradiert!",player,0,200,0)
		outputChatBox("* Du hast soeben "..playern.." erfolgreich zum "..getElementData(player,"Fraktionen[Rang]").." degradiert!",source,51,204,255)
		triggerClientEvent(source,"setListedRank",source,playern,getElementData(player,"Fraktionen[Rang]"),getPlayerRank(player,getElementData(player,"Fraktionen[Rang]")))
		outputServerLog ( getPlayerName(source).." hat "..playern.." auf Rang "..getPlayerRank(player,getElementData(player,"Fraktionen[Rang]")).." degradiert! Fraktion: "..getElementData(source,"Fraktionen[Fraktion]"))
	else
		local result = mysql_query(Datenbank,"SELECT * FROM `spielerfraktion` WHERE `Name`='"..MySQL_Save(playern).."' AND `Fraktion`='"..getElementData(source,"Fraktionen[Fraktion]").."'")
		local num = mysql_num_rows(result)
		local data = mysql_fetch_assoc(result)
		local playerD = {}
		mysql_free_result(result)
		if(num ~= 0) then
			for index,value in pairs(data) do
				playerD[index] = value
			end
			local rank = getPlayerRank(source,playerD["Rang"])
			if(rank == 1 ) then
				outputChatBox("Es gibt keinen niedrigeren Rang in einer Fraktion, als Rang 1!",source,175,175,175)
				return 1
			end
			local time = getRealTime()
			local saved = mysql_query(Datenbank,"UPDATE `spielerfraktion` SET `Rang`='"..MySQL_Save ( rankName[getElementData(source,"Fraktionen[Fraktion]")][rank - 1] ).."', `RankDatum`='"..MySQL_Save ( time.timestamp).."' WHERE `Name`='"..MySQL_Save ( playern ).."' AND `Fraktion`='"..getElementData(source,"Fraktionen[Fraktion]").."'")
			mysql_free_result(saved)
			triggerClientEvent(source,"setListedRank",source,playern,rankName[getElementData(source,"Fraktionen[Fraktion]")][rank - 1],rank - 1)
			outputChatBox("* Du hast soeben "..playern.." erfolgreich zum "..rankName[getElementData(source,"Fraktionen[Fraktion]")][rank - 1].." degradiert!",source,51,204,255)
			outputServerLog ( getPlayerName(source).." hat "..playern.." auf Rang "..rankName[getElementData(source,"Fraktionen[Fraktion]")][rank - 1].." degradiert! Fraktion: "..getElementData(source,"Fraktionen[Fraktion]"))
			--41625
		end
	end
	
end
addEvent("rankDown",true)
addEventHandler("rankDown",getRootElement(),playerRankDown)

local function removPlayerFromFraktion(playern)
	if(source ~= client) then
		return 1
	end
	if(getElementData(source,"Fraktionen[Leader]") ~= 1) then
		return 1
	end
	local player = getPlayerFromName(playern)
	if(player) then
		if(getElementData(player,"Fraktionen[Fraktion]") ~= getElementData(source,"Fraktionen[Fraktion]")) then
			return 1
		end
		if(playern == getPlayerName(source)) then
			outputChatBox("Du kannst dich nicht selbst entlassen!",source,175,175,175)
			return 1
		end
		setElementData(player,"Fraktionen[Name]",false)
		setElementData(player,"Fraktionen[Leader]",false)
		setElementData(player,"Fraktionen[Fraktion]",false)
		setElementData(player,"Fraktionen[Rang]",false)
		setElementData(player,"Fraktionen[JoinDatum]",false)
		setElementData(player,"Fraktionen[RankDatum]",false)
		setElementData(player,"Fraktionen[Sonstiges]",false)
		setPlayerTeam ( player, nil )
		outputChatBox("Du wurdest gerade von "..getPlayerName(source).." entlassen!",player,200,0,0)
		triggerEvent("onPlayerFraktionLeave",player,tostring(getElementData(source,"Fraktion[Fraktion]")))
	else
		
	end
	local result = mysql_query(Datenbank,"SELECT * FROM `spielerfraktion` WHERE `Name`='"..MySQL_Save(playern).."' AND `Fraktion`='"..getElementData(source,"Fraktionen[Fraktion]").."'")
	local num = mysql_num_rows(result)
	mysql_free_result(result)
	if(num == 0) then
		return 1
	end
	local delete = mysql_query(Datenbank,"DELETE FROM `spielerfraktion` WHERE `Name`='"..MySQL_Save( playern ).."' AND `Fraktion`='"..getElementData(source,"Fraktionen[Fraktion]").."'")
	mysql_free_result(delete)
	local group = aclGetGroup(tostring(getElementData(source,"Fraktionen[Fraktion]")))
	aclGroupRemoveObject ( group, "user."..string.lower(playern))
	aclSave ()
	outputChatBox("Du hast gerade "..playern.." erfolgreich entlassen!",source,200,0,0)
	outputServerLog(getPlayerName(source).." hat "..playern.." entlassen! Fraktion: "..getElementData(source,"Fraktionen[Fraktion]"))
	triggerClientEvent(source,"removeRowL",source,playern)
end
addEvent("rPFF",true)
addEventHandler("rPFF",getRootElement(),removPlayerFromFraktion)

function setFraktionskasse(fraktion,amount)
	if(not tonumber(amount)) then
		return false
	end
	if(tonumber(fraktion)) then
		return false
	end
	setElementData(getRootElement(),fraktion.."[Kasse]",getElementData(getRootElement(),fraktion.."[Kasse]") + amount, false)
	local update = mysql_query(Datenbank,"UPDATE `fraktionen` SET `Kasse`='"..MySQL_Save ( getElementData(getRootElement(),fraktion.."[Kasse]") ).."' WHERE `Fraktion`='"..MySQL_Save ( fraktion ).."'")
	return getElementData(getRootElement(),fraktion.."[Kasse]")
end

