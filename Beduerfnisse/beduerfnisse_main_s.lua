--local bList = { [1]="Health",[2]="Armor",[3]="Gesundheit",[4]="Energie",[5]="Harndrang",[6]="Hygiene",[7]="Hunger" }
local bTimer = {}
local function onPlayerRegister(playername)
	  local saved = mysql_query(Datenbank, "INSERT INTO `beduerfnisse` (Name) VALUES ('"..MySQL_Save(playername).."')")
	  if(saved) then
		mysql_free_result(saved)
	  end
end
addEvent("onPlayerRegister",true)
addEventHandler("onPlayerRegister",getRootElement(),onPlayerRegister)
local function onPlayerLogin()
	local playername = getPlayerName(source)
	local result = mysql_query(Datenbank, "SELECT * FROM `beduerfnisse` WHERE `Name`='"..MySQL_Save(playername).."'")
	if(mysql_num_rows(result) ~= 0) then
		local pInfo = mysql_fetch_assoc(result)
		mysql_free_result(result)
		for index,wert in pairs(pInfo) do
			if(tonumber(wert)) then
				setData(source,"Bedürfnisse",tostring(index),tonumber(wert),true)
			else
				setData(source,"Bedürfnisse",tostring(index),wert,true)
			end
		end
	else
		outputDebugString("Die Daten des Spielers "..playername.." konnten nicht aus der Tabelle 'beduerfnisse' ausgelesen werden!")
		mysql_free_result(result)
	end
	
	
	bTimer[source] = setTimer(checkBeduerfnisse,30000,0,source)
	bindKey(source,"sprint","both",onPlayerSprint)
	
	
	if(getElementData(source,"Friedhof[Tod]") == 1) then
		return 0
	end
	if(getElementData(source,"Bedürfnisse","Hygiene") <= 25) then
		local x,y,z = getElementPosition(source)
		setElementData(source,"HygieneIns1",createObject(2029,x,y,z))
		setElementCollisionsEnabled ( getElementData(source,"HygieneIns1"),false)
		attachElements(getElementData(source,"HygieneIns1"),source)
	end
	if(getElementData(source,"Bedürfnisse","Hygiene") <= 5) then
		setElementData(source,"HygieneObj",2)
		local x,y,z = getElementPosition(source)
		setElementData(source,"HygieneIns2",createObject(2029,x,y,z))
		setElementCollisionsEnabled ( getElementData(source,"HygieneIns2"),false)
		attachElements(getElementData(source,"HygieneIns2"),source)
		
		local x,y,z = getElementPosition(source)
		setElementData(source,"HygieneSmoke1",createObject(2079,x,y,z))
		setElementCollisionsEnabled ( getElementData(source,"HygieneSmoke1"),false)
		attachElements(getElementData(source,"HygieneSmoke1"),source)
	end
	if(getElementData(source,"Bedürfnisse","Hygiene") <= 0) then
		local x,y,z = getElementPosition(source)
		setElementData(source,"HygieneIns3",createObject(2029,x,y,z))
		setElementCollisionsEnabled ( getElementData(source,"HygieneIns3"),false)
		attachElements(getElementData(source,"HygieneIns3"),source)
		
		if(getElementData(source,"Bedürfnisse","Gesundheit") > 0) then
			setElementData(source,"GesundheitsTimer",setTimer(
				function(source)
					givePlayerBeduerfnis(source,"Gesundheit",-1) 
				end,1000,0,source))
		end
	end
	
	checkBeduerfnisse(source)
end
addEvent("afterPlayerLogin",true)
addEventHandler("afterPlayerLogin",getRootElement(),onPlayerLogin)

local function onPlayerQuit()
	if(not getElementData(source,"loggedin")) then
		return 0
	end
	local saved = mysql_query(Datenbank,"UPDATE `beduerfnisse` SET `Armor`='"..MySQL_Save ( getElementData(source,"Bedürfnisse","Armor") ).."',`Gesundheit`='"..MySQL_Save ( getElementData(source,"Bedürfnisse","Gesundheit") ).."',`Energie`='"..MySQL_Save ( getElementData(source,"Bedürfnisse","Energie") ).."',`EnergiePushed`='"..MySQL_Save ( getElementData(source,"Bedürfnisse","EnergiePushed")).."',`Harndrang`='"..MySQL_Save ( getElementData(source,"Bedürfnisse","Harndrang")).."',`HarndrangIntus`='"..MySQL_Save ( getElementData(source,"Bedürfnisse","HarndrangIntus")).."',`Hygiene`='"..MySQL_Save ( getElementData(source,"Bedürfnisse","Hygiene")).."',`Hunger`='"..MySQL_Save ( getElementData(source,"Bedürfnisse","Hunger")).."' WHERE `Name`='"..MySQL_Save ( getPlayerName(source) ).."'")
	mysql_free_result ( saved )
	killTimer(bTimer[source])
	bTimer[source] = nil
	unbindKey(source,"sprint")
	if(getElementData(source,"GesundheitsTimer")) then
		killTimer(getElementData(source,"GesundheitsTimer"))
	end
	if(getElementData(source,"HygieneIns1")) then
		destroyElement(getElementData(source,"HygieneIns1"))
	end
	if(getElementData(source,"HygieneIns2")) then
		destroyElement(getElementData(source,"HygieneIns2"))
	end
	if(getElementData(source,"HygieneSmoke1")) then
		destroyElement(getElementData(source,"HygieneSmoke1"))
	end
	if(getElementData(source,"HygieneIns3")) then
		destroyElement(getElementData(source,"HygieneIns3"))
	end
end
addEventHandler("onPlayerQuit",getRootElement(),onPlayerQuit)

local function onStop(rs)
	if(rs ~= getThisResource) then
		return 0
	end
	local players = getElementsByType("player")
	for index, value in ipairs(players) do
	if(getElementData(value,"loggedin")) then
		local saved = mysql_query(Datenbank,"UPDATE `beduerfnisse` SET `Health`='"..MySQL_Save ( getElementData(value,"Bedürfnisse","Health")).."', `Armor`='"..MySQL_Save ( getElementData(value,"Bedürfnisse","Armor") ).."',`Gesundheit`='"..MySQL_Save ( getElementData(value,"Bedürfnisse","Gesundheit") ).."',`Energie`='"..MySQL_Save ( getElementData(value,"Bedürfnisse","Energie") ).."',`EnergiePushed`='"..MySQL_Save ( getElementData(value,"Bedürfnisse","EnergiePushed")).."',`Harndrang`='"..MySQL_Save ( getElementData(value,"Bedürfnisse","Harndrang")).."',`HarndrangIntus`='"..MySQL_Save ( getElementData(value,"Bedürfnisse","HarndrangIntus")).."',`Hygiene`='"..MySQL_Save ( getElementData(value,"Bedürfnisse","Hygiene")).."',`Hunger`='"..MySQL_Save ( getElementData(value,"Bedürfnisse","Hunger")).."' WHERE `Name`='"..MySQL_Save ( getPlayerName(value) ).."'")
		mysql_free_result ( saved )
		end
	end
end
addEventHandler("onResourceStop",root,onStop)

local function onWasted()
	if(getElementData(source,"GesundheitsTimer")) then
		killTimer(getElementData(source,"GesundheitsTimer"))
	end
end
addEventHandler("onPlayerWasted",getRootElement(),onWasted)


