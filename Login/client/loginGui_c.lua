function ShowDialogLogin()
	xml = xmlLoadFile("loginsave.xml")
	if(xml == false) then
		xml = xmlCreateFile("loginsave.xml","Datas")
		xmlLoadFile("loginsave.xml")
		xmlNodeSetAttribute ( xml, "Name", "" )
		xmlNodeSetAttribute ( xml, "Passwort", "" )
		xmlNodeSetAttribute ( xml, "Merken", "" )
		xmlSaveFile ( xml )
		nick = ""
		kennwort = "" 
	else
		merken = xmlNodeGetAttribute ( xml, "Merken" )
		if(merken == "true") then
			nick = xmlNodeGetAttribute ( xml, "Name" )
			kennwort = xmlNodeGetAttribute ( xml, "Passwort" )
		else
			nick = ""
			kennwort = "" 
		end
	end
	showCursor(true)
	guiSetInputEnabled(true)
	GUIEditor_Label = {}
	
	--[[local x,y = guiGetScreenSize()
	local x2,y2 = 0.2758 * 1280, 0.1572 *1024
	local s,d = 0.4135*x, 0.3815*y   --0.3562*x, 0.3643*y
	wnd_login = guiCreateWindow(s,d,x2,y2,"Login",false)
	]]
	local x,y = guiGetScreenSize()
	local sx,sy = x/2 - 353/2,y/2 - 161/2
	wnd_login = guiCreateWindow(sx,sy,353,161,"Login",false)
	guiWindowSetSizable ( wnd_login, false )
	guiWindowSetMovable ( wnd_login, false )
	
	GUIEditor_Label[1] = guiCreateLabel(0.085,0.2236,0.3144,0.1304,"Benutzername: ",true,wnd_login)
	guiLabelSetColor(GUIEditor_Label[1],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[1],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[1],"left",false)
	guiSetFont(GUIEditor_Label[1],"default-bold-small")
	edt_login_nick = guiCreateEdit(0.4448,0.2174,0.4023,0.1366,tostring(nick),true,wnd_login)
	guiEditSetMaxLength(edt_login_nick,16)
	btn_login_register = guiCreateButton(0.0453,0.7391,0.2833,0.1615,"Registrieren",true,wnd_login)
	btn_login = guiCreateButton(0.6601,0.7391,0.2833,0.1615,"Login",true,wnd_login)
	check_merken = guiCreateCheckBox(0.6601,0.5714,0.2748,0.1056,"Merken",false,true,wnd_login)
	if(merken == "true") then
		guiCheckBoxSetSelected ( check_merken, true )
	else
		guiBringToFront(edt_login_nick)
	end
	edt_login_pw = guiCreateEdit(0.4448,0.3913,0.4023,0.1366,tostring(kennwort),true,wnd_login)
	guiEditSetMaxLength(edt_login_pw,16)
	guiEditSetMasked (edt_login_pw,true)
	GUIEditor_Label[2] = guiCreateLabel(0.085,0.3913,0.3144,0.1304,"Passwort: ",true,wnd_login)
	guiLabelSetColor(GUIEditor_Label[2],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[2],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[2],"left",false)
	guiSetFont(GUIEditor_Label[2],"default-bold-small")

	function NickLeerzeichenLogin(element)
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
	addEventHandler("onClientGUIChanged", edt_login_nick, NickLeerzeichenLogin)

	addEventHandler("onClientGUIClick",btn_login_register,
	function(button)
		if button == "left" then
			guiSetVisible ( wnd_login, false )
			guiSetInputEnabled(false)
			showCursor(false)
			ShowDialogRegister02()
		end
	end 
, false)
addEventHandler("onClientGUIClick",btn_login,
function(button)
	if(button == "left") then
		local name = guiGetText(edt_login_nick)
		local pw = guiGetText(edt_login_pw)
		
		if(string.find(name," ")) then
			outputChatBox("Du darfst kein Leerzeichen im Namen haben!")
			return 1
		elseif(#name < 5)then
			outputChatBox("Dein Name muss mindestens 5 Zeichen enthalten.")
			return 1
		elseif(#pw <5) then
			outputChatBox("Dein Passwort muss mind. 5 Zeichen lang sein.")
			return 1
		end


		local save = guiCheckBoxGetSelected ( check_merken )
		if(save == true) then
			xmlNodeSetAttribute ( xml, "Name", tostring(name) )
			xmlNodeSetAttribute ( xml, "Passwort", tostring(pw) )
			xmlNodeSetAttribute ( xml, "Merken", tostring(save) )
			xmlSaveFile ( xml )
		elseif(save == false) then
			xmlNodeSetAttribute ( xml, "Name", "" )
			xmlNodeSetAttribute ( xml, "Passwort", "" )
			xmlNodeSetAttribute ( xml, "Merken", "" )
			xmlSaveFile ( xml )
		end
		guiSetVisible ( wnd_login, false )
		guiSetInputEnabled(false)
		showCursor(false)
		triggerServerEvent ( "logincheck", getLocalPlayer(), getLocalPlayer(), name, pw )
	
	
	end
end
, false)


end
function ShowDialogRegister02()
	GUIEditor_Label = {}
	
	guiSetInputEnabled(true)
	local x,y = guiGetScreenSize()
	local bx,by = 500.992,232.0384
	local ax,ay = x/2 - bx/2, y/2 - by/2
	wnd_register = guiCreateWindow(ax,ay,bx,by,"Registrierung",false)
	guiBringToFront ( wnd_register )
	guiWindowSetSizable ( wnd_register, false )
	guiWindowSetMovable ( wnd_register, false )
	GUIEditor_Label[1] = guiCreateLabel(0.0419,0.1681,0.2355,0.1121,"Benutzername:",true,wnd_register)
	guiLabelSetColor(GUIEditor_Label[1],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[1],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[1],"left",false)
	guiSetFont(GUIEditor_Label[1],"default-bold-small")
	edt_nick = guiCreateEdit(0.2794,0.1552,0.2994,0.1034,"",true,wnd_register)
	
	function NickLeerzeichenRegis(element)
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
	addEventHandler("onClientGUIChanged", edt_nick, NickLeerzeichenRegis)
	
	
	
	guiEditSetMaxLength(edt_nick,16)
	
	GUIEditor_Label[2] = guiCreateLabel(0.0419,0.3448,0.2355,0.1121,"Passwort:",true,wnd_register)
	guiLabelSetColor(GUIEditor_Label[2],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[2],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[2],"left",false)
	guiSetFont(GUIEditor_Label[2],"default-bold-small")
	edt_pw = guiCreateEdit(0.2794,0.3276,0.2994,0.1034,"",true,wnd_register)
	guiEditSetMaxLength(edt_pw,16)
	guiEditSetMasked (edt_pw,true)
	GUIEditor_Label[3] = guiCreateLabel(0.0419,0.6164,0.1277,0.0905,"Geschlecht:",true,wnd_register)
	guiLabelSetColor(GUIEditor_Label[3],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[3],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[3],"left",false)
	guiSetFont(GUIEditor_Label[3],"default-bold-small")
	rad_mann = guiCreateRadioButton(0.2036,0.6207,0.1617,0.069,"Mann",true,wnd_register)
	guiRadioButtonSetSelected(rad_mann,true)
	rad_frau = guiCreateRadioButton(0.2036,0.7069,0.1617,0.069,"Frau",true,wnd_register)
	GUIEditor_Label[4] = guiCreateLabel(0.4311,0.6164,0.1717,0.0905,"Geburtsdatum:",true,wnd_register)
	guiLabelSetColor(GUIEditor_Label[4],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[4],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[4],"left",false)
	guiSetFont(GUIEditor_Label[4],"default-bold-small")
	GUIEditor_Label[5] = guiCreateLabel(0.6267,0.6207,0.0579,0.0603,"TT",true,wnd_register)
	guiLabelSetColor(GUIEditor_Label[5],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[5],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[5],"left",false)
	guiSetFont(GUIEditor_Label[5],"default-bold-small")
	GUIEditor_Label[6] = guiCreateLabel(0.7206,0.6207,0.0579,0.0603,"MM",true,wnd_register)
	guiLabelSetColor(GUIEditor_Label[6],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[6],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[6],"left",false)
	guiSetFont(GUIEditor_Label[6],"default-bold-small")
	GUIEditor_Label[7] = guiCreateLabel(0.8263,0.6207,0.0579,0.0603,"JJJJ",true,wnd_register)
	guiLabelSetColor(GUIEditor_Label[7],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[7],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[7],"left",false)
	guiSetFont(GUIEditor_Label[7],"default-bold-small")
	edt_tag = guiCreateEdit(0.6028,0.694,0.0778,0.0862,"",true,wnd_register)
	
	function forceInteger(element)
		local text = guiGetText(element) -- text aus der editBox auslesen
		local int = string.gsub(text, "[^%d]", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
		if(#text ==2) then
		guiBringToFront(edt_monat)
		end
	end
	addEventHandler("onClientGUIChanged", edt_tag, forceInteger) -- eventhandler bei Ã¤ndern des textes
	guiEditSetMaxLength(edt_tag,2)
	
	edt_monat = guiCreateEdit(0.7046,0.694,0.0778,0.0862,"",true,wnd_register)
	
	function forceIntegerM(element)
		local text = guiGetText(element) -- text aus der editBox auslesen
		local int = string.gsub(text, "[^%d]", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
		if(#text ==2) then
		guiBringToFront(edt_jahr)
		end
	end
	addEventHandler("onClientGUIChanged", edt_monat, forceIntegerM) -- eventhandler bei Ã¤ndern des textes
	
	guiEditSetMaxLength(edt_monat,2)

	
	edt_jahr = guiCreateEdit(0.8044,0.694,0.1038,0.0862,"",true,wnd_register)
	
	function forceIntegerJ(element)
		local text = guiGetText(element) -- text aus der editBox auslesen
		local int = string.gsub(text, "[^%d]", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
	end
	addEventHandler("onClientGUIChanged", edt_jahr, forceIntegerJ) -- eventhandler bei Ã¤ndern des textes
	
	guiEditSetMaxLength(edt_jahr,4)
	
	GUIEditor_Label[8] = guiCreateLabel(0.6846,0.6983,0.0399,0.0905,"/",true,wnd_register)
	guiLabelSetColor(GUIEditor_Label[8],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[8],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[8],"left",false)
	guiSetFont(GUIEditor_Label[8],"default-bold-small")
	GUIEditor_Label[9] = guiCreateLabel(0.7864,0.6983,0.0399,0.0905,"/",true,wnd_register)
	guiLabelSetColor(GUIEditor_Label[9],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[9],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[9],"left",false)
	guiSetFont(GUIEditor_Label[9],"default-bold-small")
	btn_registrieren = guiCreateButton(0.7725,0.8233,0.1956,0.1121,"Registrieren",true,wnd_register)
	btn_abbrechen = guiCreateButton(0.5369,0.8233,0.1956,0.1121,"Abbrechen",true,wnd_register)
	GUIEditor_Label[10] = guiCreateLabel(0.6168,0.1422,0.3074,0.4224,"Info: Bitte gebe unten dein richtiges Geburtsdatum und dein Geschlecht ein. Bedenke, dass du beides nichtmehr ändern kannst!",true,wnd_register)
	guiLabelSetColor(GUIEditor_Label[10],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[10],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[10],"left",true)
	guiSetFont(GUIEditor_Label[10],"default-bold-small")
	guiBringToFront(edt_nick)

	showCursor(true)







	addEventHandler("onClientGUIClick",btn_registrieren,
	function(button)
		if button == "left" then
		local name = guiGetText(edt_nick)
		local pw = guiGetText(edt_pw)
		local geburtstag = guiGetText(edt_jahr).."-"..guiGetText(edt_monat).."-"..guiGetText(edt_tag)
	
		local Jahr = tonumber(guiGetText(edt_jahr))
		local Monat = tonumber(guiGetText(edt_monat))
		local Tag = tonumber(guiGetText(edt_tag))
			if(guiRadioButtonGetSelected(rad_mann) ==true) then
				geschlecht =1
			elseif(guiRadioButtonGetSelected(rad_frau) ==true) then
				geschlecht =2
			end
			if(string.find(name," ")) then
				outputChatBox("Du darfst kein Leerzeichen im Namen haben!")
				return 1
			elseif(#name <5) then
				outputChatBox("Dein Name muss mindestens 5 Zeichen lang \nsein und darf maximal 16 Zeichen lang sein!")
				return 1
			elseif(#pw <5) then
				outputChatBox("Dein Passwort muss mindestens 5 Zeichen lang \nsein und darf maximal 16 Zeichen lang sein!")
				return 1
			elseif(not Jahr or Jahr <=1930 or Jahr >=2000 or not Monat or Monat ==0 or Monat >12 or not Tag) then
				outputChatBox("Dein Geburtsdatum hat ein falsches Format. Bitte korrigier es...")
				return 1
			end
			if(Monat ==1) then
			if(Tag >31 or Tag ==0) then
			outputChatBox("Dein Geburtsdatum hat ein falsches Format. Bitte korrigier es...")
			return 1
			end
			elseif(Monat ==2) then
			if(Tag >29 or Tag ==0) then
			outputChatBox("Dein Geburtsdatum hat ein falsches Format. Bitte korrigier es...")
			return 1		
			end
			elseif(Monat ==3) then
			if(Tag >31 or Tag ==0) then
			outputChatBox("Dein Geburtsdatum hat ein falsches Format. Bitte korrigier es...")
			return 1		
			end
			elseif(Monat ==4) then
			if(Tag >30 or Tag ==0) then
			outputChatBox("Dein Geburtsdatum hat ein falsches Format. Bitte korrigier es...")
			return 1		
			end
			elseif(Monat ==5) then
			if(Tag >31 or Tag ==0) then
			outputChatBox("Dein Geburtsdatum hat ein falsches Format. Bitte korrigier es...")
			return 1		
			end
			elseif(Monat ==6) then
			if(Tag >30 or Tag ==0) then
			outputChatBox("Dein Geburtsdatum hat ein falsches Format. Bitte korrigier es...")
			return 1		
			end
			elseif(Monat ==7) then
			if(Tag >31 or Tag ==0) then
			outputChatBox("Dein Geburtsdatum hat ein falsches Format. Bitte korrigier es...")
			return 1		
			end
			elseif(Monat ==8) then
			if(Tag >31 or Tag ==0) then
			outputChatBox("Dein Geburtsdatum hat ein falsches Format. Bitte korrigier es...")
			return 1
			end
			elseif(Monat ==9) then
			if(Tag >30 or Tag ==0) then
			outputChatBox("Dein Geburtsdatum hat ein falsches Format. Bitte korrigier es...")
			return 1		
			end
			elseif(Monat ==10) then
			if(Tag >31 or Tag ==0) then
			outputChatBox("Dein Geburtsdatum hat ein falsches Format. Bitte korrigier es...")
			return 1		
			end
			elseif(Monat ==11) then
			if(Tag >30 or Tag ==0) then
			outputChatBox("Dein Geburtsdatum hat ein falsches Format. Bitte korrigier es...")
			return 1		
			end
			elseif(Monat ==12) then
			if(Tag >31 or Tag ==0) then
			outputChatBox("Dein Geburtsdatum hat ein falsches Format. Bitte korrigier es...")
			return 1		
			end
			
			end
		guiSetVisible ( wnd_register, false )
		guiSetInputEnabled(false)
		showCursor(false)
		triggerServerEvent ( "register", getLocalPlayer(), getLocalPlayer(), name, pw, geburtstag, geschlecht ) 
		end
	end 
	, false)
	addEventHandler("onClientGUIClick",btn_abbrechen,
	function(button)
	 	if button == "left" then
		guiSetVisible ( wnd_register, false )
		guiSetInputEnabled(false)
		showCursor(false)
		ShowDialogLogin()
		end
	end 
	, false)


	end
addEvent("RegisterDialog",true)
addEventHandler("RegisterDialog",getRootElement(),ShowDialogRegister02)
addEvent("LoginDialog",true)
addEventHandler("LoginDialog",getRootElement(),ShowDialogLogin)
function OnPlayerConnect()
	local x,y = guiGetScreenSize()
	if(x < 1280) then
		outputChatBox("Deine Auflösung braucht mindestens 1280 Pixel in der Breite !")
		return 1
	end
	ShowDialogLogin()
end
addEventHandler( "onClientResourceStart",  getResourceRootElement(getThisResource()), OnPlayerConnect)



function onPSpawn()
	if(logo ~= true) then
		addEventHandler("onClientRender",root,unlimitedLogo)
		logo = true
	end
end
addEventHandler("onClientPlayerSpawn",getRootElement(),onPSpawn)



local x,y = guiGetScreenSize() 	--local bx,by = 0.14609375 * x, 0.1044921875 * y
local bx,by = 297,121   --249
local ax,ay = x - bx, y - by
function unlimitedLogo()
   	dxDrawImage(ax,ay,bx,by,"images/Unlimited-Reallife.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
end



