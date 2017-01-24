function createGrid()
	local fx,fy = guiGetScreenSize()
	local bx,by = 459,225
	wdw_bankinfo = guiCreateWindow(fx/2 - bx/2,fy/2 - by/2,bx,by,"Transaktionsinfo",false)
	guiBringToFront ( wdw_bankinfo )
	guiWindowSetSizable ( wdw_bankinfo, false )
	guiWindowSetMovable ( wdw_bankinfo, false )
	guiSetAlpha(wdw_bankinfo,1)
	
	grid_list = guiCreateGridList(9/bx,24/by,352/bx,187/by,true,wdw_bankinfo)
	guiGridListSetSelectionMode(grid_list,1)
	
	sender = guiGridListAddColumn(grid_list,"Absender",0.2)
	money = guiGridListAddColumn(grid_list,"Betrag",0.2)
	date = guiGridListAddColumn(grid_list,"Datum",0.2)
	time = guiGridListAddColumn(grid_list,"Uhrzeit",0.2)
	vwz = guiGridListAddColumn(grid_list,"Verwendungszweck     ",2)
	btn_ok = guiCreateButton(363/459,28/225,86/459,28/225,"Okay",true,wdw_bankinfo)
	btn_delete = guiCreateButton(363/459,63/225,86/459,28/225,"Löschen",true,wdw_bankinfo)
	guiSetVisible(wdw_bankinfo,false)
	
	addEventHandler("onClientGUIClick",btn_ok,
	function(button)
		if(button == "left") then
			bistate = 0
			guiSetVisible(wdw_bankinfo,false)
			showCursor(false)
			guiSetInputEnabled(false)
			guiGridListClear ( grid_list )
		end
	end
,false)


	addEventHandler("onClientGUIClick",btn_delete,
		function(button)
			if(button == "left") then
				triggerServerEvent("deleteEintragTrans",getLocalPlayer(),getLocalPlayer(),guiGridListGetItemText ( grid_list, guiGridListGetSelectedItem ( grid_list ), 1 ), guiGridListGetItemText ( grid_list, guiGridListGetSelectedItem ( grid_list ), 4 ))
				guiGridListRemoveRow ( grid_list, guiGridListGetSelectedItem ( grid_list ))
			end
		end
,false)
end

function createBinfo()
	local fx,fy = guiGetScreenSize()
	local bx,by = 356,100
	
	wdw_binfo = guiCreateWindow(fx/2 -bx/2, fy/2 - by/2,bx,by,"Informationsschalter",false)
	guiSetAlpha(wdw_binfo,1)
	guiBringToFront ( wdw_binfo )
	guiWindowSetSizable ( wdw_binfo, false )
	guiWindowSetMovable ( wdw_binfo, false )
	
	label_info = guiCreateLabel(0.0562,0.25,0.8596,0.27,"Bitte wählen sie aus, was sie machen möchten ...",true,wdw_binfo)
	guiSetAlpha(wdw_binfo,1)
	guiLabelSetColor(GUIEditor_Label[1],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[1],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[1],"left",false)
	guiSetFont(GUIEditor_Label[1],"default-bold-small")
	btn_tinfo = guiCreateButton(0.0393,0.59,0.4298,0.24,"Überweisungsinformationen",true,wdw_binfo)
	guiSetAlpha(btn_tinfo,1)
	btn_kinfo = guiCreateButton(0.4944,0.59,0.2219,0.24,"Kontostand",true,wdw_binfo)
	guiSetAlpha(btn_kinfo,1)
	btn_kfinder = guiCreateButton(0.736,0.59,0.2219,0.24,"Kontofinder",true,wdw_binfo)
	guiSetAlpha(btn_kfinder,1)
	btn_ainfo = guiCreateButton(0.882,0.24,0.0646,0.17,"?",true,wdw_binfo)
	guiSetAlpha(btn_ainfo,1)
	
	addEventHandler("onClientGUIClick",btn_tinfo,
	function(button)
		if(button == "left") then
			guiSetVisible(wdw_binfo,false)
			showCursor(false)
			guiSetInputEnabled(false)
			showTinfo()
		end
	end
,false)

	addEventHandler("onClientGUIClick",btn_kinfo,
	function(button)
		if(button == "left") then
			guiSetVisible(wdw_binfo,false)
			showCursor(false)
			guiSetInputEnabled(false)
			if(getElementData(getLocalPlayer(),"Bank_c")) then
				guiSetText(sbstand,"( "..getElementData(getLocalPlayer(),"Bank_c")["GeldSB"].." $ ) ")
				guiSetText(gkstand,"( "..getElementData(getLocalPlayer(),"Bank_c")["GeldGK"].." $ ) ")
			end
			showKinfo()
		end
	end
,false)

	addEventHandler("onClientGUIClick",btn_kfinder,
	function(button)
		if(button == "left") then
			guiSetVisible(wdw_binfo,false)
			showCursor(false)
			guiSetInputEnabled(false)
			guiSetText ( edt_kfinder_kn, "")
			guiSetText ( edt_kfinder_name, "" )
			showKfinder()
		end
	end
,false)

	addEventHandler("onClientGUIClick",btn_ainfo,
	function(button)
		if(button == "left") then
			guiSetVisible(wdw_binfo,false)
			showCursor(false)
			guiSetInputEnabled(false)
			showAinfo()
		end
	end
,false)

	guiSetVisible(wdw_binfo,false)
	


end

function createAinfo()
	local fx,fy = guiGetScreenSize()
	local bx,by = 336,166
	
	wdw_ainfo = guiCreateWindow(fx/2 -bx/2, fy/2 - by/2,bx,by,"Info",false)
	guiSetAlpha(wdw_ainfo,1)
	guiBringToFront ( wdw_ainfo )
	guiWindowSetSizable ( wdw_ainfo, false )
	guiWindowSetMovable ( wdw_ainfo, false )
	
	ainfo_label = guiCreateLabel(0.0804,0.1867,0.9077,0.512,"Hier kannst du entweder schauen, wer \ndir Geld überwiesen hat, schauen \nwieviel Geld du auf deinen Konten hast \noder die Kontonummer von einem Freund \nherausfinden, um diesen Geld zu überweisen.",true,wdw_ainfo)
	guiSetAlpha(ainfo_label,1)
	guiLabelSetColor(ainfo_label,255,255,255)
	guiLabelSetVerticalAlign(ainfo_label,"top")
	guiLabelSetHorizontalAlign(ainfo_label,"left",false)
	guiSetFont(ainfo_label,"clear-normal")
	btn_ainfo_back = guiCreateButton(0.0774,0.747,0.2708,0.1446,"Zurück",true,wdw_ainfo)
	guiSetAlpha(btn_ainfo_back,1)
	btn_ainfo_close = guiCreateButton(0.7411,0.747,0.2143,0.1446,"Abbrechen",true,wdw_ainfo)
	guiSetAlpha(btn_ainfo_close,1)
	guiSetVisible(wdw_ainfo,false)
	addEventHandler("onClientGUIClick",btn_ainfo_close,
	function(button)
		if(button == "left") then
			bistate = 0
			guiSetVisible(wdw_ainfo,false)
			showCursor(false)
			guiSetInputEnabled(false)
		end
	end
,false)
	
	addEventHandler("onClientGUIClick",btn_ainfo_back,
	function(button)
		if(button == "left") then
			guiSetVisible(wdw_ainfo,false)
			showCursor(false)
			guiSetInputEnabled(false)
			showBinfo()
		end
	end
,false)
end

function createKinfo(sb,gk)

	local fx,fy = guiGetScreenSize()
	local bx,by = 476,265
	
	wdw_kinfo = guiCreateWindow(fx/2 -bx/2, fy/2 - by/2,bx,by,"Kontoinformationen",false)
	guiSetAlpha(wdw_kinfo,1)
	guiBringToFront ( wdw_kinfo )
	guiWindowSetSizable ( wdw_kinfo, false )
	guiWindowSetMovable ( wdw_kinfo, false )
	
	kinfo_sb = guiCreateStaticImage(0.0987,0.1925,0.229,0.483,"images/sparbuch.png",true,wdw_kinfo)
	guiSetAlpha(kinfo_sb,1)
	kinfo_gk = guiCreateStaticImage(0.5588,0.3962,0.2941,0.2679,"images/sparkassenKarte.png",true,wdw_kinfo)
	guiSetAlpha(kinfo_gk,1)
	
	sbstand = guiCreateLabel(0.1113,0.7094,0.3046,0.0792,"( 0 $ ) ",true,wdw_kinfo)
	guiSetAlpha(sbstand,1)
	guiLabelSetColor(sbstand,255,255,255)
	guiLabelSetVerticalAlign(sbstand,"top")
	guiLabelSetHorizontalAlign(sbstand,"left",false)
	guiSetFont(sbstand,"default-bold-small")
	guiLabelSetColor(sbstand,0,200,0)
	
	gkstand = guiCreateLabel(0.5588,0.7094,0.3046,0.0792,"( 0 $ ) ",true,wdw_kinfo)
	guiSetAlpha(gkstand,1)
	guiLabelSetColor(gkstand,255,255,255)
	guiLabelSetVerticalAlign(gkstand,"top")
	guiLabelSetHorizontalAlign(gkstand,"left",false)
	guiSetFont(gkstand,"default-bold-small")
	guiLabelSetColor(gkstand,0,200,0)

	GUIEditor_Label[3] = guiCreateLabel(0.1113,0.117,0.1891,0.0755,"Sparbuch",true,wdw_kinfo)
	guiSetAlpha(GUIEditor_Label[3],1)
	guiLabelSetColor(GUIEditor_Label[3],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[3],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[3],"left",false)
	GUIEditor_Label[4] = guiCreateLabel(0.5588,0.3057,0.1891,0.0755,"Girokonto",true,wdw_kinfo)
	guiSetAlpha(GUIEditor_Label[4],1)
	guiLabelSetColor(GUIEditor_Label[4],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[4],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[4],"left",false)
	btn_kinfo_close = guiCreateButton(0.7479,0.8566,0.208,0.1019,"Abbrechen",true,wdw_kinfo)
	guiSetAlpha(btn_kinfo_close,1)
	btn_kinfo_back = guiCreateButton(0.5168,0.8566,0.208,0.1019,"Zurück",true,wdw_kinfo)
	guiSetAlpha(btn_kinfo_back,1)
	guiSetVisible(wdw_kinfo,false)

	
	addEventHandler("onClientGUIClick",btn_kinfo_close,
	function(button)
		if(button == "left") then
			bistate = 0
			guiSetVisible(wdw_kinfo,false)
			showCursor(false)
			guiSetInputEnabled(false)
		end
	end
,false)
	
	addEventHandler("onClientGUIClick",btn_kinfo_back,
	function(button)
		if(button == "left") then
			guiSetVisible(wdw_kinfo,false)
			showCursor(false)
			guiSetInputEnabled(false)
			showBinfo()
		end
	end
,false)

end

function createKfinder()
	GUIEditor_Label = {}
	local fx,fy = guiGetScreenSize()
	local bx,by = 318,173
	wdw_kfinder = guiCreateWindow(fx/2 -bx/2, fy/2 - by/2,bx,by,"Konto finden",false)
	guiBringToFront ( wdw_kfinder )
	guiWindowSetSizable ( wdw_kfinder, false )
	guiWindowSetMovable ( wdw_kfinder, false )
	guiSetAlpha(wdw_kfinder,1)
	
	edt_kfinder_name = guiCreateEdit(0.0786,0.5607,0.4277,0.1445,"",true,wdw_kfinder)
	guiSetAlpha(edt_kfinder_name,1)
	GUIEditor_Label[1] = guiCreateLabel(0.0912,0.1618,0.8868,0.2543,"Gib unten den Namen des Spielers ein, dessen \nGirokontonummer du brauchst !",true,wdw_kfinder)
	guiSetAlpha(GUIEditor_Label[1],1)
	guiLabelSetColor(GUIEditor_Label[1],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[1],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[1],"left",false)
	GUIEditor_Label[2] = guiCreateLabel(0.0881,0.4451,0.3585,0.1272,"Benutzername:",true,wdw_kfinder)
	guiSetAlpha(GUIEditor_Label[2],1)
	guiLabelSetColor(GUIEditor_Label[2],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[2],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[2],"left",false)
	guiSetFont(GUIEditor_Label[2],"default-bold-small")
	edt_kfinder_kn = guiCreateEdit(0.5849,0.5607,0.2013,0.1445,"",true,wdw_kfinder)
	guiSetAlpha(edt_kfinder_kn,1)
	guiEditSetReadOnly(edt_kfinder_kn,true)
	btn_kfinder_suchen = guiCreateButton(0.7327,0.8035,0.2264,0.1387,"Suchen",true,wdw_kfinder)
	guiSetAlpha(btn_kfinder_suchen,1)
	btn_kfinder_back = guiCreateButton(0.4874,0.8035,0.2264,0.1387,"Zurück",true,wdw_kfinder)
	guiSetAlpha(btn_kfinder_back,1)
	btn_kfinder_close = guiCreateButton(0.239,0.8035,0.2264,0.1387,"Abbrechen",true,wdw_kfinder)
	guiSetAlpha(btn_kfinder_close,1)
	GUIEditor_Label[3] = guiCreateLabel(0.5912,0.4451,0.3585,0.1279,"KN:",true,wdw_kfinder)
	guiSetAlpha(GUIEditor_Label[3],1)
	guiLabelSetColor(GUIEditor_Label[3],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[3],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[3],"left",false)
	guiSetFont(GUIEditor_Label[3],"default-bold-small")
	guiSetVisible(wdw_kfinder,false)
	guiEditSetMaxLength(edt_kfinder_name,16)
	
	addEventHandler("onClientGUIClick",btn_kfinder_suchen,
	function(button)
		if(button == "left") then
			if(guiGetText(edt_kfinder_name) == "") then
				outputChatBox("Sie müssen einen Benutzernamen angeben!")
				return 1
			end
			triggerServerEvent("KontoCheck",getLocalPlayer(),getLocalPlayer(), guiGetText(edt_kfinder_name))
		end
	end
,false)

	addEventHandler("onClientGUIClick",btn_kfinder_close,
	function(button)
		if(button == "left") then
			bistate = 0
			guiSetVisible(wdw_kfinder,false)
			showCursor(false)
			guiSetInputEnabled(false)
		end
	end
,false)

	addEventHandler("onClientGUIClick",btn_kfinder_back,
	function(button)
		if(button == "left") then
			guiSetVisible(wdw_kfinder,false)
			showCursor(false)
			guiSetInputEnabled(false)
			showBinfo()
		end
	end
,false)

	addEventHandler("onClientGUIChanged", edt_kfinder_name,
	function(element)
	local text = guiGetText(element) -- text aus der editBox auslesen
	local int = string.gsub(text, " ", "") -- alle nicht numerischen zeichen lÃ¶schen
	if text ~= int then -- falls der int wert vom text abweicht
		guiSetText(element, int) -- den int wert als text der editBox setzen
	end
	local int = string.gsub(text, "#", "") -- alle nicht numerischen zeichen lÃ¶schen
	if text ~= int then -- falls der int wert vom text abweicht
		guiSetText(element, int) -- den int wert als text der editBox setzen
	end
	end
	
	)

end

function createAll()
	if(loaded1 ~= 1) then
		createGrid()
		createBinfo()
		createAinfo()
		createKinfo()
		createKfinder()
		createFriedhofW()
		loaded1 = 1
	end

end
addEventHandler("onClientPlayerSpawn", getLocalPlayer(),createAll)

function showAinfo()
	guiSetVisible(wdw_ainfo,true)
	showCursor(true)
	guiSetInputEnabled(true)
end
function showBinfo()
	guiSetVisible(wdw_binfo,true)
	showCursor(true)
	guiSetInputEnabled(true)
end

function showTinfo()
	guiSetVisible(wdw_bankinfo,true)
	showCursor(true)
	guiSetInputEnabled(true)
	triggerServerEvent("holeDatenTrans",getLocalPlayer(),getLocalPlayer())
end

function showKfinder()
	guiSetVisible(wdw_kfinder,true)
	showCursor(true)
	guiSetInputEnabled(true)
end


function showKinfo()
	guiSetVisible(wdw_kinfo,true)
	showCursor(true)
	guiSetInputEnabled(true)
end

function cl(name,betrag,datum,zeit,vz)
    local row = guiGridListAddRow ( grid_list )
    guiGridListSetItemText ( grid_list, row, sender, tostring(name), false, false )
    
    guiGridListSetItemText ( grid_list, row, money, tostring(betrag).." $", false, false )
    
    guiGridListSetItemText ( grid_list, row, date, tostring(datum), false, false )
    
    guiGridListSetItemText ( grid_list, row, time, tostring(zeit), false, false )

    guiGridListSetItemText ( grid_list, row, vwz, tostring(vz), false, false )
    

end
addEvent("createLine",true)
addEventHandler("createLine",getRootElement(),cl)

function setEdt(kn)
	guiSetText ( edt_kfinder_kn, tostring(kn) )
end
addEvent("setzeKN",true)
addEventHandler("setzeKN",getRootElement(),setEdt)

local function hideAll()
	if(bistate == 1) then
		guiSetVisible(wdw_ainfo,false)
		guiSetVisible(wdw_binfo,false)
		guiSetVisible(wdw_bankinfo,false)
		guiSetVisible(wdw_kfinder,false)
		guiSetVisible(wdw_kinfo,false)
	end	
end
addEventHandler("onClientPlayerWasted",getRootElement(),hideAll)

local function onDamage()
if(bistate == 1) then
	if(source == getLocalPlayer()) then
		local x,y,z = getElementPosition(getLocalPlayer())
		if(getDistanceBetweenPoints3D(x,y,z,2308.8696289063,-13.408550262451,26.7421875) > 1.5) then
			hideAll()
		end
	end
end
end
addEventHandler("onClientPlayerDamage",getRootElement(),onDamage)
