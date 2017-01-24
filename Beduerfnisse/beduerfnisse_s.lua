-- Todo:
-- Duschen, Colas, Nahrung, Bett, Regen Hygiene, Gesundheit, Armor, Krankheiten, Toilette, Stinken + anim, In die Hosen pissen, Hunger (kotzen bei 110), Beeinflussung der Bedürfnisse, Gui

function checkBeduerfnisse(player)
	if(getElementData(player,"Friedhof[Tod]") == 1) then
		return 0
	end
    --________________________Energie_____________________________________________
	givePlayerBeduerfnis(player,"Energie",-0.5) -- alle 30 Sekunden -0.5 Energie
	-- ______________________Hunger_______________________________________________
	givePlayerBeduerfnis(player,"Hunger",-1.25) -- alle 30 Sekunden -1.25 Hunger
	--______________________Hygiene (stehen)______________________________________
	givePlayerBeduerfnis(player,"Hygiene",-0.25) -- alle 30 Sekunden -0.25 Hygiene
	
	--______________________Harndrang_____________________________________________
	givePlayerBeduerfnis(player,"Harndrang",-0.25) -- alle 30 Sekunden -0.25 Harndrang
	if(getElementData(player,"Bedürfnisse","HarndrangIntus")) then
		givePlayerBeduerfnis(player,"Harndrang",-getElementData(player,"Bedürfnisse","HarndrangIntus")) -- Nach 10 Minuten
	end
	--______________________
end

function givePlayerBeduerfnis(player, beduerfnis, amount)
	if(getElementData(player,"Friedhof[Tod]") == 1) then
		return 0
	end
	if(getElementData(player,"Bedürfnisse",beduerfnis) + amount <= 0) then
		triggerEvent("onBeduerfnisDown",player,beduerfnis,0,getElementData(player,"Bedürfnisse",beduerfnis),amount)
		triggerEvent("onPlayerBeduernisLeer",player,beduerfnis)
		setData(player,"Bedürfnisse",beduerfnis,0)
		return 0
	end
	if(amount < 0) then
		triggerEvent("onBeduerfnisDown",player,beduerfnis,getElementData(player,"Bedürfnisse",beduerfnis) + amount,getElementData(player,"Bedürfnisse",beduerfnis),amount)
	else
		triggerEvent("onBeduerfnisUp",player,beduerfnis,getElementData(player,"Bedürfnisse",beduerfnis) + amount,getElementData(player,"Bedürfnisse",beduerfnis),amount)
	end
	setData(player,"Bedürfnisse",beduerfnis,getElementData(player,"Bedürfnisse",beduerfnis) + amount,true)
end

function onPlayerSprint(player,key,state)
	if(getElementData(player,"Friedhof[Tod]") == 1) then
		return 0
	end
	local x,y,z = getElementPosition(player)
	if(x == getElementData(player,"oldSprintHygX") and y == getElementData(player,"oldSprintHygY") and z == getElementData(player,"oldSprintHygZ")) then
		return 1
	end
	setElementData(player,"oldSprintHygX",x)
	setElementData(player,"oldSprintHygY",y)
	setElementData(player,"oldSprintHygZ",z)
	
	if(state == "down") then
		local time = getRealTime()
		setElementData(player,"runStartTime",time.timestamp)
	elseif(state =="up") then
		local time = getRealTime()
		local zeitGes = time.timestamp - getElementData(player,"runStartTime")
		local leftHygie
		local leftEnergie
		if(zeitGes == 0) then
			leftHygie = 0.05 -- Wenn der Spieler kürzer als 1 Sekunde die Leertaste drückt
			leftEnergie = 0.005 -- Wenn der Spieler kürzer als 1 Sekunde die Leertaste drückt
		elseif(zeitGes > 0) then
			leftHygie = 0.05 * zeitGes -- Pro Sekunde die der Spieler rennt bekommt er 0.05 Hygiene abgezogen
			leftEnergie = 0.005 * zeitGes -- Pro Sekunde die der Spieler rennt bekommt er 0.005 Energie abgezogen
		end
		givePlayerBeduerfnis(player,"Hygiene",-leftHygie)
		givePlayerBeduerfnis(player,"Energie",-leftEnergie)
	end
	
end

local function onPlayerSwim()
	if(source ~= client) then
		return 0
	end
	if(getElementData(source,"Friedhof[Tod]") == 1) then
		return 0
	end
	givePlayerBeduerfnis(source,"Hygiene",-0.3) -- Wenn der Spieler im Wasser ist (alle 5 Sekunden)
end
addEvent("onPlayerSwim",true)
addEventHandler("onPlayerSwim",getRootElement(),onPlayerSwim)

