local fx,fy = guiGetScreenSize()
local ix,iy
local ibx,iby

local infoImage = {}
local infoCloseButton
local infoLeftChange
local infoRightChange
local infoNextChange
local infoLastChange

local btn_infoBox_exit = {}
local btn_infoBox_back = {}
local btn_infoBox_lastbox = {}
local btn_infoBox_nextbox = {}
local btn_infoBox_next = {}

local info = {}
local infoID = {}
local infoName = {}
local showInfo = {}

local infotext = {}
local infoseite = {}
function createInfobox(name,text,filepath,locked,time)
	local id = getHighestInfobox() + 1
	
	for index,value in pairs(infoName) do
		if(index == name) then
			return false
		end
	end
	playSound("sounds/info.wav")
	infoID[id] = name
	infoName[name] = id
	for index,value in pairs(showInfo) do
		if(value == true) then
			setInfoboxVisible(index,false)
		end
	end
	-- Direct X Drawing
	ibx,iby = 413.0,125.0
	ix,iy =fx/2-ibx/2, fy - iby - 50
	
	
	btn_infoBox_exit[id] = guiCreateButton(ix + ibx - 40,iy,40,20,"",false)
	guiSetAlpha(btn_infoBox_exit[id],0)
	
	btn_infoBox_back[id] = guiCreateButton(ix + ibx - 25 - 25 - 25 ,iy+iby - 15,25,15,"",false)
	guiSetAlpha(btn_infoBox_back[id],0)
	
	btn_infoBox_next[id] = guiCreateButton(ix + ibx - 25 - 25,iy+iby - 15,25,15,"",false)
	guiSetAlpha(btn_infoBox_next[id],0)
	
	btn_infoBox_lastbox[id] = guiCreateButton(ix + ibx - 25 - 25 - 26 - 25,iy+iby - 15,25,15,"",false)
	guiSetAlpha(btn_infoBox_lastbox[id],0)
	
	btn_infoBox_nextbox[id] = guiCreateButton(ix + ibx - 25 ,iy+iby - 15,25,15,"",false)
	guiSetAlpha(btn_infoBox_nextbox[id],0)

	if(not filepath) then
		infoImage[id] = dxCreateTexture ( "infoboxen/images/NoPic.png" )
	else
		infoImage[id] = dxCreateTexture ( "infoboxen/images/"..filepath )
	end

	infoCloseButton = dxCreateTexture ( "infoboxen/images/infoCancel.png" )
	infoLeftChange = dxCreateTexture ( "infoboxen/images/infoBoxLinks.png" )
	infoRightChange = dxCreateTexture ( "infoboxen/images/infoBoxRechts.png" )
	infoNextChange = dxCreateTexture ( "infoboxen/images/infoBoxNext.png" )
	infoLastChange = dxCreateTexture ( "infoboxen/images/infoBoxLast.png" )
	local pbx,pby = 64,64
	infotext[id] = {}
	local w=1
	local ttext = text
	infoseite[id] = 1
	infotext[id][1] = text
	if(getClip(tostring(ttext)) ~= "") then
		repeat
			w = w+1
			infotext[id][w] = getClip(ttext)
			ttext = getClip(ttext)
		until getClip(ttext) == ""
	end
	
	
	info[id] = function()
		if(showInfo[id] == true) then
		
			dxDrawRectangle(ix,iy,ibx,iby,tocolor(175,175,175,100),false)
			--dxDrawText("Überschrift",875.0,872.0,1409.0,902.0,tocolor(255,255,255,255),1.0,"bankgothic","left","top",false,false,true)
			dxDrawText(name,ix + 94,iy + 8,ibx - 94,902.0,tocolor(255,255,255,255),1.0,"bankgothic","left","top",false,false,true)
			dxDrawText(infotext[id][infoseite[id]],ix + 100,iy + 38,ix+ibx,iy +iby - 18 ,tocolor(255,255,255,255),1.1,"arial","left","top",true,true,true)
			dxDrawImage(ix + 15,iy + iby/2 - 32,pbx,pby,infoImage[id],0.0,0.0,0.0,tocolor(255,255,255,255),true)
			dxDrawImage(ix + ibx - 40,iy,40,20,infoCloseButton,0.0,0.0,0.0,tocolor(255,255,255,255),true)
			dxDrawImage(ix + ibx - 25 - 25 ,iy+iby - 15,25,15,infoRightChange,0.0,0.0,0.0,tocolor(255,255,255,255),true)
			dxDrawImage(ix + ibx - 25 - 25 - 25,iy+iby - 15,25,15,infoLeftChange,0.0,0.0,0.0,tocolor(255,255,255,255),true)
			dxDrawImage(ix + ibx - 25,iy+iby - 15,25,15,infoNextChange,0.0,0.0,0.0,tocolor(255,255,255,255),true)
			dxDrawImage(ix + ibx - 25 - 25 - 26 - 25,iy+iby - 15,25,15,infoLastChange,0.0,0.0,0.0,tocolor(255,255,255,255),true)
			
			dxDrawText(""..infoseite[id].." / "..w.."",(ix + 15 + 32) - dxGetTextWidth("1 / 3")/2,iy + iby - dxGetFontHeight() - 10,10,10,tocolor(255,255,255,255),1.0,"default","left","top",false,false,true)
		else
			
		end
	end
	addEventHandler("onClientRender",getRootElement(),info[id])
	
	if(locked ~= true) then
		addEventHandler("onClientGUIClick",btn_infoBox_exit[id],
		function(button)
			if button == "left" then
				destroyInfobox(id)
			end
		end)
	end
	
	addEventHandler("onClientGUIClick",btn_infoBox_next[id],
		function(button)
			if button == "left" then
				if(infoseite[id] +1 <= w) then
					infoseite[id] = infoseite[id] +1 
				end
			end
		end)
		
	addEventHandler("onClientGUIClick",btn_infoBox_nextbox[id],
		function(button)
			if button == "left" then
					for i=id,getHighestInfobox(),1 do
						if(infoID[i] and i ~= id) then
							setInfoboxVisible(id,false)
							setInfoboxVisible(i,true)
							break
						end
					end

			end
		end )
		
	addEventHandler("onClientGUIClick",btn_infoBox_lastbox[id],
		function(button)
			if button == "left" then
				local nextInfobox
				for i=id,1,-1 do
					if(infoID[i] and i ~= id) then
						setInfoboxVisible(id,false)
						setInfoboxVisible(i,true)
						break
					end
				end

			end
		end)
		
	
	addEventHandler("onClientGUIClick",btn_infoBox_back[id],
		function(button)
			if button == "left" then
				if(infoseite[id] > 1) then
					infoseite[id] = infoseite[id] - 1
				end
			end
		end )
	
	addEventHandler("onClientMouseEnter",btn_infoBox_exit[id],
		function()
			infoCloseButton = dxCreateTexture ( "infoboxen/images/infoCancelM.png" )
		end
	)
	
	addEventHandler("onClientMouseLeave",btn_infoBox_exit[id],
		function()
			infoCloseButton = dxCreateTexture ( "infoboxen/images/infoCancel.png" )
		end
	)
	
	
	addEventHandler("onClientMouseEnter",btn_infoBox_lastbox[id],
		function()
			infoLastChange = dxCreateTexture ( "infoboxen/images/infoBoxLastM.png" )
		end
	)
	
	addEventHandler("onClientMouseLeave",btn_infoBox_lastbox[id],
		function()
			infoLastChange = dxCreateTexture ( "infoboxen/images/infoBoxLast.png" )
		end
	)
	
	addEventHandler("onClientMouseEnter",btn_infoBox_nextbox[id],
		function()
			infoNextChange = dxCreateTexture ( "infoboxen/images/infoBoxNextM.png" )
		end
	)
	
	addEventHandler("onClientMouseLeave",btn_infoBox_nextbox[id],
		function()
			infoNextChange = dxCreateTexture ( "infoboxen/images/infoBoxNext.png" )
		end
	)
	
	
	addEventHandler("onClientMouseEnter",btn_infoBox_back[id],
		function()
			infoLeftChange = dxCreateTexture ( "infoboxen/images/infoBoxLinksM.png" )
		end
	)
	
	addEventHandler("onClientMouseLeave",btn_infoBox_back[id],
		function()
			infoLeftChange = dxCreateTexture ( "infoboxen/images/infoBoxLinks.png" )
		end
	)
	
	addEventHandler("onClientMouseEnter",btn_infoBox_next[id],
		function()
			infoRightChange = dxCreateTexture ( "infoboxen/images/infoBoxRechtsM.png" )
		end
	)
	
	addEventHandler("onClientMouseLeave",btn_infoBox_next[id],
		function()
			infoRightChange = dxCreateTexture ( "infoboxen/images/infoBoxRechts.png" )
		end
	)
	
	setInfoboxVisible(id,true)
	if(time) then
		setTimer(
		function(id)
			destroyInfobox(id)
		end,time,1,id)
	end
	triggerServerEvent("giveInfoid",getLocalPlayer(),id)
	return id
end

addEvent("createInfobox",true)
addEventHandler("createInfobox",getRootElement(),createInfobox)
function setInfoboxVisible(id,state)
		if(showInfo[tonumber(id)] == state) then
			return false
		end
		showInfo[tonumber(id)] = state
		if(btn_infoBox_next[id]) then
			guiSetEnabled( btn_infoBox_next[id],state)
			guiSetEnabled( btn_infoBox_back[id],state)
			guiSetEnabled( btn_infoBox_exit[id],state)
			guiSetEnabled( btn_infoBox_lastbox[id],state)
			guiSetEnabled( btn_infoBox_nextbox[id],state)
		end
		return true
end

function getInfoboxVisible(id)
	return showInfo[tonumber(id)]
end

function destroyInfobox(id)
	if(not infoID[id]) then
		return false
	end
	triggerServerEvent("removeInfoid",getLocalPlayer(),id)
	removeEventHandler("onClientRender",getRootElement(),info[id])
	destroyElement(btn_infoBox_exit[id])
	destroyElement(btn_infoBox_next[id])
	destroyElement(btn_infoBox_back[id])
	destroyElement(btn_infoBox_nextbox[id])
	destroyElement(btn_infoBox_lastbox[id])
	
	infoName[infoID[id]] = nil
	infoID[id] = nil
	
	if(getInfoboxVisible(id) == true) then
		setInfoboxVisible(getHighestInfobox(),true)
	end
	showInfo[id] = nil
	if(getHighestInfobox() ~= 0 ) then
	setTimer(
		function()
			setInfoboxVisible(getHighestInfobox(),true)
		end,100,1)
	end
	return true
end
addEvent("destroyInfobox",true)
addEventHandler("destroyInfobox",getRootElement(),destroyInfobox)

function getHighestInfobox()
	local highest = 0
	for index,value in pairs(infoID) do
		if(value) then
			highest = index
		end
	end
	return highest
end


function getClip(string)
	local fullString = tostring(string)
	for line = 1, 5,1 do
		if(line <= 4) then
			local lastSpace
			local finalString = ""
			for i = 1,string.len(fullString),1 do
			
				if(dxGetTextWidth ( finalString, 1.1, "arial" ) < ibx - 100 ) then
					finalString=finalString..""..string.char( string.byte(fullString,i) )
					if(string.char( string.byte(fullString,i)) == " ") then
						lastSpace = i
					end
				else
					if(lastSpace) then
						fullString = string.sub(fullString,lastSpace+1)
					else
						fullString = string.sub(fullString,i-1)
					end
					break
				end
				
				if(i == string.len(fullString) and line <= 4) then
					if(lastSpace) then
						fullString = ""
					end
				end
			end
		else
			if(fullString == string) then
				return ""
			else
				return fullString
			end
		end
	end
end

local function getPicture(name)
	local string = string.lower(name)
	local finalString = ""
	for i = 1,string.len(string),1 do
		if(string.sub (string, i,i) == "ü") then
			finalString = finalString.."ue"
		elseif(string.sub (string, i,i) == "ö") then
			finalString = finalString.."oe"
		elseif(string.sub (string, i,i) == "ä") then
			finalString = finalString.."ae"
		else
			finalString = finalString..string.char(string.byte(string,i))
		end
	end
	return finalString
end

