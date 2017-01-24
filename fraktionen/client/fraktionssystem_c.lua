local btn_close
local member
local rang 
local befDate
local joinDate
	
function createTabPanel()
	GUIEditor_Label = {}

	local fx,fy = guiGetScreenSize()
	local bx,by = 435,265
	tabpanel_leader = guiCreateTabPanel(fx/2 - bx/2,fy/2 - by/2,bx,by,false)
	
	tab_allgemein = guiCreateTab("Allgemeines",tabpanel_leader)
		btn_close = guiCreateButton(0.7661,0.8529,0.2018,0.1092,"Close",true,tab_allgemein)
		GUIEditor_Label[1] = guiCreateLabel(0.0367,0.1303,0.2156,0.1134,"Fraktion:",true,tab_allgemein)
		guiSetFont(GUIEditor_Label[1],"default-bold-small")
		GUIEditor_Label[2] = guiCreateLabel(0.0367,0.2563,0.2156,0.1134,"Kassenzuwachs:",true,tab_allgemein)
		guiSetFont(GUIEditor_Label[2],"default-bold-small")
		GUIEditor_Label[3] = guiCreateLabel(0.0367,0.3908,0.2156,0.1134,"Kassenstand:",true,tab_allgemein)
		GUIEditor_Label[4] = guiCreateLabel(0.0367,0.5253,0.2156,0.1134,"Mitglieder online:",true,tab_allgemein)
		guiSetFont(GUIEditor_Label[3],"default-bold-small")
		guiSetFont(GUIEditor_Label[4],"default-bold-small")
		fraktion = guiCreateLabel(0.2936,0.1303,0.2156,0.5134,"",true,tab_allgemein)
		zuwachs = guiCreateLabel(0.2936,0.2563,0.2156,0.7134,"0 $",true,tab_allgemein)
		kassenstand = guiCreateLabel(0.2936,0.3908,0.2156,0.7134,"0 $",true,tab_allgemein)
		mitgliederZahl = guiCreateLabel(0.2936,0.5253,0.2156,0.7134,"",true,tab_allgemein)
		btn_info = guiCreateButton(0.7661,0.7143,0.2018,0.1092,"Info",true,tab_allgemein)
	tab_einstellen = guiCreateTab("Einstellen",tabpanel_leader)
		btn_closeE = guiCreateButton(0.7661,0.8529,0.2018,0.1092,"Close",true,tab_einstellen)
		btn_einstellen = guiCreateButton(0.7661,0.7143,0.2018,0.1092,"Einstellen",true,tab_einstellen)
		GUIEditor_Label[1] = guiCreateLabel(0.0207,0.0542,0.5586,0.5333,"Bitte beachte, dass jede Fraktion ein \nMitgliederlimit hat. Dieses kannst du \nnicht überschreiten. Du solltest deine \nMitglieder mit Bedacht wählen. \nBitte stelle nur ein, die eine \nordentliche Bewerbung im Forum \ngeschrieben haben und denen man \nvertrauen kann!",true,tab_einstellen)
		guiSetFont(GUIEditor_Label[1],"clear-normal")
		GUIEditor_Label[2] = guiCreateLabel(0.0253,0.7625,0.2046,0.0958,"Mitglieder:",true,tab_einstellen)
		guiSetFont(GUIEditor_Label[2],"default-bold-small")
		GUIEditor_Label[3] = guiCreateLabel(0.0253,0.8708,0.2805,0.0958,"Maximale Mitglieder:",true,tab_einstellen)
		guiSetFont(GUIEditor_Label[3],"default-bold-small")
		label_mitglieder = guiCreateLabel(0.3379,0.7625,0.2046,0.0958,"",true,tab_einstellen)
		label_maxmitglieder = guiCreateLabel(0.3379,0.8708,0.2046,0.0958,"",true,tab_einstellen)
	tab_bef = guiCreateTab("Befördern / Degradieren",tabpanel_leader)
	
		btn_closeB = guiCreateButton(0.7661,0.8529,0.2018,0.1092,"Close",true,tab_bef)
		btn_feuern = guiCreateButton(0.7661,0.7143,0.2018,0.1092,"Entlassen",true,tab_bef)
		grid_lFraktionsList = guiCreateGridList(0.0115,0.0311,0.74,0.9378,true,tab_bef)
		guiGridListSetSelectionMode(grid_lFraktionsList,1)
		member = guiGridListAddColumn(grid_lFraktionsList,"Mitglied",0.2)
		rangID = guiGridListAddColumn(grid_lFraktionsList,"",0.05)
		rang = guiGridListAddColumn(grid_lFraktionsList,"Rang",0.2)
		befDate = guiGridListAddColumn(grid_lFraktionsList,"Letzte Beförderung",0.3)
		joinDate = guiGridListAddColumn(grid_lFraktionsList,"Fraktionseintritt",0.3)
		

		
		btn_RankUp = guiCreateButton(0.7661,0.0311,0.2018,0.1092,"Befördern",true,tab_bef)
		btn_rankDown = guiCreateButton(0.7661,0.1697,0.2018,0.1092,"Degradieren",true,tab_bef)
		
	tab_verwalten = guiCreateTab("Gehälter verwalten",tabpanel_leader)
		btn_closeV = guiCreateButton(0.7661,0.8529,0.2018,0.1092,"Close",true,tab_verwalten)
		GUIEditor_Label[1] = guiCreateLabel(0.0963,0.1653,0.2294,0.1116,"Rang 1:",true,tab_verwalten)
		guiSetFont(GUIEditor_Label[1],"default-bold-small")
		edt_rank1 = guiCreateEdit(0.2271,0.1653,0.2546,0.1074,"",true,tab_verwalten)
		minLohn = guiCreateLabel(0.6500,0.1653,0.9,0.1074,"Mindestlohn: ",true,tab_verwalten)
		maxLohn = guiCreateLabel(0.6500,0.3017,0.9,0.1074,"Maximallohn: ",true,tab_verwalten)
		guiEditSetMaxLength (  edt_rank1,  6 )
		edt_rank2 = guiCreateEdit(0.2271,0.3017,0.2546,0.1074,"",true,tab_verwalten)
		guiEditSetMaxLength (  edt_rank2,  6 )
		edt_rank3 = guiCreateEdit(0.2271,0.4381,0.2546,0.1074,"",true,tab_verwalten)
		guiEditSetMaxLength (  edt_rank3,  6 )
		edt_rank4 = guiCreateEdit(0.2271,0.5745,0.2546,0.1074,"",true,tab_verwalten)
		guiEditSetMaxLength (  edt_rank4,  6 )
		edt_rank5 = guiCreateEdit(0.2271,0.7109,0.2546,0.1074,"",true,tab_verwalten)
		guiEditSetMaxLength (  edt_rank5,  6 )
		
		GUIEditor_Label[2] = guiCreateLabel(0.0963,0.3017,0.2294,0.1116,"Rang 2:",true,tab_verwalten)
		GUIEditor_Label[3] = guiCreateLabel(0.0963,0.4381,0.2294,0.1116,"Rang 3:",true,tab_verwalten)
		GUIEditor_Label[4] = guiCreateLabel(0.0963,0.5745,0.2294,0.1116,"Rang 4:",true,tab_verwalten)
		GUIEditor_Label[5] = guiCreateLabel(0.0963,0.7109,0.2294,0.1116,"Rang 5:",true,tab_verwalten)
		guiSetFont(GUIEditor_Label[2],"default-bold-small")
		guiSetFont(GUIEditor_Label[3],"default-bold-small")
		guiSetFont(GUIEditor_Label[4],"default-bold-small")
		guiSetFont(GUIEditor_Label[5],"default-bold-small")
		btn_saveGe = guiCreateButton(0.7661,0.7143,0.2018,0.1092,"Speichern",true,tab_verwalten)
	guiSetVisible(tabpanel_leader,false)

	addEventHandler("onClientGUIClick",btn_close,
	function(button)
		if button == "left" then
		guiGridListClear ( grid_lFraktionsList )
		guiSetVisible(tabpanel_leader ,false)
		showCursor(false)
		guiSetInputEnabled(false)
		end
	end
	, false)
	addEventHandler("onClientGUIClick",btn_closeE,
	function(button)
		if button == "left" then
			guiGridListClear ( grid_lFraktionsList )
			guiSetVisible(tabpanel_leader,false)
			showCursor(false)
			guiSetInputEnabled(false)
		end
	end
	, false)
	addEventHandler("onClientGUIClick",btn_closeB,
	function(button)
		if button == "left" then
			guiGridListClear ( grid_lFraktionsList )
			guiSetVisible(tabpanel_leader,false)
			showCursor(false)
			guiSetInputEnabled(false)
		end
	end
	, false)
	addEventHandler("onClientGUIClick",btn_closeV,
	function(button)
		if button == "left" then
			guiSetVisible(tabpanel_leader ,false)
			showCursor(false)
			guiSetInputEnabled(false)
			guiGridListClear ( grid_lFraktionsList )
		end
	end
	, false)
	addEventHandler("onClientGUIClick",btn_info,
	function(button)
		if button == "left" then
			showInfoWindow()
		end
	end
	, false)
	addEventHandler("onClientGUIClick",btn_saveGe,
	function(button)
		if button == "left" then
			local g1,g2,g3,g4,g5 = guiGetText(edt_rank1),guiGetText(edt_rank2),guiGetText(edt_rank3),guiGetText(edt_rank4),guiGetText(edt_rank5)
			triggerServerEvent("saveGehalt",getLocalPlayer(),g1,g2,g3,g4,g5)
		end
	end
	, false)
	addEventHandler("onClientGUIClick",btn_einstellen,
	function(button)
		if button == "left" then
			guiGridListClear ( grid_lFraktionsList )
			guiSetVisible(tabpanel_leader ,false)
			showCursor(false)
			guiSetInputEnabled(false)
			triggerServerEvent("einstellen",getLocalPlayer())
		end
	end
	, false)
	addEventHandler("onClientGUIClick",btn_RankUp,
	function(button)
		if button == "left" then
			triggerServerEvent("rankUp",getLocalPlayer(),guiGridListGetItemText ( grid_lFraktionsList, guiGridListGetSelectedItem ( grid_lFraktionsList ), 1 ))
		end
	end
	, false)
	addEventHandler("onClientGUIClick",btn_rankDown,
	function(button)
		if button == "left" then
			triggerServerEvent("rankDown",getLocalPlayer(),guiGridListGetItemText ( grid_lFraktionsList, guiGridListGetSelectedItem ( grid_lFraktionsList ), 1 ))
		end
	end
	, false)
	addEventHandler("onClientGUIClick",btn_feuern,
	function(button)
		if button == "left" then
			triggerServerEvent("rPFF",getLocalPlayer(),guiGridListGetItemText ( grid_lFraktionsList, guiGridListGetSelectedItem ( grid_lFraktionsList ), 1 ))
		end
	end
	, false)
	
	
	addEventHandler("onClientGUIChanged", edt_rank1, 
	function(element)
		local text = guiGetText(element) -- text aus der editBox auslesen
		local int = string.gsub(text, "[^%d]", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
		if(#text ==2) then
			guiBringToFront(edt_jahr)
		end
	end
	)
	addEventHandler("onClientGUIChanged", edt_rank2, 
	function(element)
		local text = guiGetText(element) -- text aus der editBox auslesen
		local int = string.gsub(text, "[^%d]", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
		if(#text ==2) then
			guiBringToFront(edt_jahr)
		end
	end)
	addEventHandler("onClientGUIChanged", edt_rank3, 
	function(element)
		local text = guiGetText(element) -- text aus der editBox auslesen
		local int = string.gsub(text, "[^%d]", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
		if(#text ==2) then
			guiBringToFront(edt_jahr)
		end
	end)
	addEventHandler("onClientGUIChanged", edt_rank4, 
	function(element)
		local text = guiGetText(element) -- text aus der editBox auslesen
		local int = string.gsub(text, "[^%d]", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
		if(#text ==2) then
			guiBringToFront(edt_jahr)
		end
	end)
	addEventHandler("onClientGUIChanged", edt_rank5, 
	function(element)
		local text = guiGetText(element) -- text aus der editBox auslesen
		local int = string.gsub(text, "[^%d]", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
		if(#text ==2) then
			guiBringToFront(edt_jahr)
		end
	end)
	
end

local listedMember = {}
local function createLineFL(Name,Rang,RangID,rangDate,joinDatum,offline,r,g,b)
	listedMember[tostring(Name)] = guiGridListAddRow ( grid_lFraktionsList )
	local timeJMonthday
	local timeJMonth
	local timeRMonthday
	local timeRMonth
	local timeJ = getRealTime(joinDatum)
	if(timeJ.monthday < 10) then  timeJMonthday = "0"..timeJ.monthday else  timeJMonthday = timeJ.monthday end
	if(timeJ.month < 10) then  timeJMonth = "0"..timeJ.month else timeJMonth = timeJ.month end
	local joinDatumF = timeJMonthday.."."..timeJMonth.."."..timeJ.year + 1900 
	local timeR = getRealTime(rangDate)
	if(timeR.monthday < 10) then  timeRMonthday = "0"..timeR.monthday else  timeRMonthday = timeR.monthday end
	if(timeR.month < 10) then  timeRMonth = "0"..timeR.month else  timeRMonth = timeR.month end
	local rankDateF = timeRMonthday.."."..timeRMonth.."."..timeR.year + 1900 
	if(offline == true) then
		guiGridListSetItemText ( grid_lFraktionsList, listedMember[tostring(Name)], member, tostring(Name), false, false )
		guiGridListSetItemColor ( grid_lFraktionsList , listedMember[tostring(Name)], member,  170, 170, 170 )
		guiGridListSetItemText ( grid_lFraktionsList, listedMember[tostring(Name)], rang, tostring(Rang), false, false )
		guiGridListSetItemColor ( grid_lFraktionsList , listedMember[tostring(Name)], rang, 170, 170, 170)
		guiGridListSetItemText ( grid_lFraktionsList, listedMember[tostring(Name)], rangID, tostring(RangID), false, false )
		guiGridListSetItemColor ( grid_lFraktionsList , listedMember[tostring(Name)], rangID, 170, 170, 170)
		guiGridListSetItemText ( grid_lFraktionsList, listedMember[tostring(Name)], befDate, tostring(rankDateF), false, false )
		guiGridListSetItemColor ( grid_lFraktionsList , listedMember[tostring(Name)], befDate, 170, 170, 170)
		guiGridListSetItemText ( grid_lFraktionsList, listedMember[tostring(Name)], joinDate, tostring(joinDatumF), false, false )
		guiGridListSetItemColor ( grid_lFraktionsList , listedMember[tostring(Name)], joinDate, 170, 170, 170)
	else
		guiGridListSetItemText ( grid_lFraktionsList, listedMember[tostring(Name)], member, tostring(Name), false, false )
		guiGridListSetItemColor ( grid_lFraktionsList , listedMember[tostring(Name)], member, r, g, b )
		guiGridListSetItemText ( grid_lFraktionsList, listedMember[tostring(Name)], rang, tostring(Rang), false, false )
		guiGridListSetItemColor ( grid_lFraktionsList , listedMember[tostring(Name)], rang, r, g, b )
		guiGridListSetItemText ( grid_lFraktionsList, listedMember[tostring(Name)], rangID, tostring(RangID), false, false )
		guiGridListSetItemColor ( grid_lFraktionsList , listedMember[tostring(Name)], rangID, r, g, b)
		guiGridListSetItemText ( grid_lFraktionsList, listedMember[tostring(Name)], befDate, tostring(rankDateF), false, false )
		guiGridListSetItemColor ( grid_lFraktionsList , listedMember[tostring(Name)], befDate, r, g, b )
		guiGridListSetItemText ( grid_lFraktionsList, listedMember[tostring(Name)], joinDate, tostring(joinDatumF), false, false )
		guiGridListSetItemColor ( grid_lFraktionsList , listedMember[tostring(Name)], joinDate, r, g, b )
	end
	
		
end
addEvent("createLineFL",true)
addEventHandler("createLineFL",getRootElement(),createLineFL)

local function removeRow(playern)
	guiGridListRemoveRow ( grid_lFraktionsList , listedMember[tostring(playern)])
end
addEvent("removeRowL",true)
addEventHandler("removeRowL",getRootElement(),removeRow)

local function setListedRank(Name,Rang,RangID)
	local timeR = getRealTime()
	local timeRMonthday
	local timeRMonth
	if(timeR.monthday < 10) then  timeRMonthday = "0"..timeR.monthday else  timeRMonthday = timeR.monthday end
	if(timeR.month < 10) then  timeRMonth = "0"..timeR.month else  timeRMonth = timeR.month end
	local rankDateF = timeRMonthday.."."..timeRMonth.."."..timeR.year + 1900 
	guiGridListSetItemText( grid_lFraktionsList, listedMember[tostring(Name)],rang,tostring(Rang),false,false)
	guiGridListSetItemText( grid_lFraktionsList, listedMember[tostring(Name)],rangID,tostring(RangID),false,false)
	guiGridListSetItemText ( grid_lFraktionsList, listedMember[tostring(Name)], befDate, tostring(rankDateF), false, false )
end
addEvent("setListedRank",true)
addEventHandler("setListedRank",getRootElement(),setListedRank)
local function onPlayerSpawn()
	if(spawned ~= 1) then
		createTabPanel()
		createInfoWindow()
		createInviteFraktion()
		spawned = 1
	end
end
addEventHandler("onClientPlayerSpawn",getRootElement(),onPlayerSpawn)

function createInviteFraktion()
	GUIEditor_Label = {}
	GUIEditor_Edit = {}
	local fx,fy = guiGetScreenSize()
	local bx,by = 383,178
	wdw_invite_fraktion = guiCreateWindow(fx/2 -bx/2,fy/2-by/2,bx,by,"Arbeitsvertrag",false)
	guiWindowSetMovable(wdw_invite_fraktion,false)
	guiWindowSetSizable(wdw_invite_fraktion,false)
	GUIEditor_Label[1] = guiCreateLabel(0.0418,0.2472,0.3655,0.1742,"Arbeitsgeber:",true,wdw_invite_fraktion)
	guiSetFont(GUIEditor_Label[1],"default-bold-small")
	GUIEditor_Label[2] = guiCreateLabel(0.0418,0.4045,0.3655,0.1742,"Fraktion:",true,wdw_invite_fraktion)
	guiSetFont(GUIEditor_Label[2],"default-bold-small")
	leader = guiCreateLabel(0.329,0.2472,0.3655,0.1742,"Tockra",true,wdw_invite_fraktion)
	label_fraktion = guiCreateLabel(0.329,0.4045,0.3655,0.1742,"Medic",true,wdw_invite_fraktion)
	GUIEditor_Edit[1] = guiCreateEdit(0.0339,0.5843,0.9347,0.3652,"",true,wdw_invite_fraktion)
	guiEditSetReadOnly(GUIEditor_Edit[1],true)
	GUIEditor_Label[3] = guiCreateLabel(0.0444,0.5955,0.9478,0.3371,"Du wurdest soeben in eine Fraktion eingeladen!\nIn Fraktionen verdienst du mehr Geld als als nomaler Spieler \nund du hast mehr zu tun!",true,wdw_invite_fraktion)
	guiLabelSetColor(GUIEditor_Label[3],0,0,0)
	guiSetFont(GUIEditor_Label[3],"default-bold-small")
	btn_accept_fraktion = guiCreateButton(0.7258,0.2135,0.235,0.1517,"Aktzeptieren",true,wdw_invite_fraktion)
	btn_denied_fraktion = guiCreateButton(0.7258,0.4157,0.235,0.1517,"Ablehnen",true,wdw_invite_fraktion)
	guiSetVisible(wdw_invite_fraktion,false)
	
	addEventHandler("onClientGUIClick",btn_accept_fraktion,
	function(button)
		if button == "left" then
			triggerServerEvent("FraktionInviteAccept",getLocalPlayer())
			guiSetVisible(wdw_invite_fraktion ,false)
			showCursor(false)
			guiSetInputEnabled(false)
		end
	end
	, false)
	
	addEventHandler("onClientGUIClick",btn_denied_fraktion,
	function(button)
		if button == "left" then
			triggerServerEvent("FraktionInviteCancel",getLocalPlayer())
			guiSetVisible(wdw_invite_fraktion ,false)
			showCursor(false)
			guiSetInputEnabled(false)
		end
	end
	, false)

end

local function showInviteFraktion(Leader,Fraktion)
	guiSetText(leader,tostring(Leader))
	guiSetText(label_fraktion,tostring(Fraktion))
	guiSetVisible(wdw_invite_fraktion,true)
	guiBringToFront ( wdw_invite_fraktion )
	showCursor(true)
	guiSetInputEnabled(true)
end
addEvent("showInviteFraktion",true)
addEventHandler("showInviteFraktion",getRootElement(),showInviteFraktion)
function createInfoWindow()
	GUIEditor_Label = {}
	local fx,fy = guiGetScreenSize()
	local bx,by = 469,233
	wdw_info = guiCreateWindow(fx/2 - bx/2,fy/2 - by/2,bx,by,"Info",false)
	guiSetAlpha(wdw_info,1)
	guiWindowSetMovable(wdw_info,false)
	guiWindowSetSizable(wdw_info,false)
	GUIEditor_Label[1] = guiCreateLabel(0.0426,0.1245,0.8699,0.7082,"Kassenstand: \nDer Kassenstand zeigt dir an, wie viel Geld noch in der Fraktionskasse ist. \nAus der Fraktionskasse werden alle Gehälter gezahlt und wenn in der \nKasse nicht mehr genug Geld ist dann musst du die Gehälter von deinem \neigenen Geld zahlen! \n\nKassenzuwachs:\nDer Kassenzuwachs gibt an, wieviel Geld ein Fraktionsmitglied \nder Fraktion an einem Payday einbringt. Hier gilt die Regel\nZuwachs * Rank. Die Kasse kann aber auch durch sonstige ereignisse \ngefüllt werden!",true,wdw_info)
	guiSetFont(GUIEditor_Label[1],"clear-normal")
	local bx,by = 0.2452,0.1245
	btn_closeInfo = guiCreateButton(0.5 - bx/2,1-by,bx,by,"Schließen",true,wdw_info)
	guiSetVisible(wdw_info,false)

	addEventHandler("onClientGUIClick",btn_closeInfo,
	function(button)
		if button == "left" then
			guiSetVisible(wdw_info,false)
		end
	end
	, false)
end
function showLeaderPanel(Fraktion,Kassenzuwachs,Kassenstand,g1,g2,g3,g4,g5,minlo,maxlo,zahl,maxzahl,online)
	guiSetText(fraktion,tostring(Fraktion))
	guiSetText(zuwachs,tostring(Kassenzuwachs).." $")
	guiSetText(kassenstand,tostring(Kassenstand).." $")
	guiSetText(edt_rank1,tostring(g1))
	guiSetText(edt_rank2,tostring(g2))
	guiSetText(edt_rank3,tostring(g3))
	guiSetText(edt_rank4,tostring(g4))
	guiSetText(edt_rank5,tostring(g5))
	guiSetText(minLohn,"Mindestlohn: "..tostring(minlo).." $")
	guiSetText(maxLohn,"Maximallohn: "..tostring(maxlo).." $")
	guiSetText(mitgliederZahl,tostring(online).." / "..tostring(zahl))
	guiSetText(label_mitglieder,tostring(zahl))
	guiSetText(label_maxmitglieder,tostring(maxzahl))
	guiSetVisible(tabpanel_leader,true)
	showCursor(true)
	guiSetInputEnabled(true)
end
addEvent("showLeaderPanel",true)
addEventHandler("showLeaderPanel",getRootElement(),showLeaderPanel)

function showInfoWindow()
	guiSetVisible(wdw_info,true)
	guiBringToFront ( wdw_info )
end


