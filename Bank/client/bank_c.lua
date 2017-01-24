
function playerConnect()
	if(loaded2 ~=1) then
		createTimePanel()
		createBankSelection()
		createKcrSel()
		createKcr1()
		createKcr2()
		createFrageSparbuch()
		createFrageGiroKonto()
		createEditBank()
		createZugriffSelSB()
		createZugriffSelGK()
		loaded2 = 1
	end
end
addEventHandler("onClientPlayerSpawn",getLocalPlayer(),playerConnect)

function createBankSelection()
	GUIEditor_Label = {}
	local x,y = guiGetScreenSize()
	local bx,by = 295,115
	local ax,ay = (x/2 - 1280/2) + 503, (y/2 - 1024/2) + 820
	wdw_bsc = guiCreateWindow(ax,ay,bx,by,"Bank",false)
	
	guiWindowSetMovable(wdw_bsc,false)
	guiWindowSetSizable(wdw_bsc,false)
	
	GUIEditor_Label[1] = guiCreateLabel(0.099,0.2308,0.314,0.1624,"Konto Optionen",true,wdw_bsc)
	guiLabelSetColor(GUIEditor_Label[1],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[1],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[1],"left",false)
	guiSetFont(GUIEditor_Label[1],"default-bold-small")
	GUIEditor_Label[2] = guiCreateLabel(0.6451,0.2308,0.314,0.1624,"Konto erstellen",true,wdw_bsc)
	guiLabelSetColor(GUIEditor_Label[2],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[2],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[2],"left",false)
	guiSetFont(GUIEditor_Label[2],"default-bold-small")
	btn_bankOp = guiCreateButton(0.0956,0.4017,0.2765,0.5214,"",true,wdw_bsc)
	guiSetAlpha(btn_bankOp,0)
	btn_bankCreate = guiCreateButton(0.6382,0.4017,0.2526,0.5214,"",true,wdw_bsc)
	guiSetAlpha(btn_bankCreate,0)
	
	guiSetVisible (wdw_bsc , false )
	addEventHandler("onClientGUIClick",btn_bankCreate,
	function(button)
		if(button == "left") then
			hideBsc()
			showKcrSel()
		end
	end
	, false)
	
	addEventHandler("onClientGUIClick",btn_bankOp,
	function(button)
		if(button == "left") then
			hideBsc()
			showEditBank()
		end
	end
	, false)
	

	
	
	
end -- Create Bank Selection ( Das erste Bank MenÃ¼ )

function showBsc()
	showCursor(true)
	guiSetInputEnabled(true)
	guiBringToFront ( wdw_bsc )
	guiSetVisible (wdw_bsc , true )
	addEventHandler("onClientRender", getRootElement() , Chatbubble1)
	btn_sgtD = false
	btn_skD = false
	addEventHandler("onClientRender", getRootElement(), btn_BscSel)

end -- Show Bank Selection ( Das erste Bank MenÃ¼ )

function hideBsc()
	removeEventHandler("onClientRender", getRootElement() , Chatbubble1)
	removeEventHandler("onClientRender", getRootElement() , Chatbubble31)
	removeEventHandler("onClientRender", getRootElement() , Chatbubble32)
	removeEventHandler("onClientRender", getRootElement() , Chatbubble41)
	removeEventHandler("onClientRender", getRootElement() , Chatbubble42)
	removeEventHandler("onClientRender", getRootElement() , Chatbubble61)
	removeEventHandler("onClientRender", getRootElement() , Chatbubble62)
	removeEventHandler("onClientRender", getRootElement(), btn_BscSel)
	guiSetVisible (wdw_bsc , false )
end -- Hide Bank Selection ( Das erste Bank MenÃ¼ )

function btn_BscSel()
	local x,y = guiGetScreenSize()
	local ax,ay = fx + 532,fy + 870
	local bx,by = 79, 56.710172744721689059500959692898
	--dxDrawImage(532.0,870.0,79.0,58.0,"images/Bank/SGT.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	if(btn_sgtD == false) then
		dxDrawImage(ax,ay,bx,by,"images/Bank/SGT.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	elseif(btn_sgtD == true) then
		dxDrawImage(ax,ay,bx,by,"images/Bank/SGTS.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	end
    local ax,ay = fx + 670, fy + 842
    local bx,by = 145, 104.08829174664107485604606525912
    --dxDrawImage(670.0,842.0,145.0,111.0,"images/Bank/SK.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
    if(btn_skD == false) then
    	dxDrawImage(ax,ay,bx,by,"images/Bank/SK.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
    elseif(btn_skD == true) then
    	dxDrawImage(ax,ay,bx,by,"images/Bank/SKS.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
    end

end -- Render  btn bsc

function Chatbubble1()
	local x,y = guiGetScreenSize()
	local ax,ay,bx,by = fx + 0.5046875 * 1280,fy + 0.205078125 * 1024,0.21171875 * 1280,0.1845703125 * 1024    
	dxDrawImage(ax,ay,bx,by,"images/Bank/Sprechblase1.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
end -- Chatbubble 1

function Chatbubble2()
	local x,y = guiGetScreenSize()
	local ax,ay,bx,by = fx + 0.5046875 * 1280,fy + 0.205078125 * 1024,0.21171875 * 1280,0.1845703125 * 1024      
	dxDrawImage(ax,ay,bx,by,"images/Bank/Sprechblase2.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
end -- Chatbubble 2

function Chatbubble31()
	local x,y = guiGetScreenSize()
	local ax,ay,bx,by = fx + 0.5046875 * 1280,fy + 0.205078125 * 1024,0.21171875 * 1280,0.1845703125 * 1024    
	dxDrawImage(ax,ay,bx,by,"images/Bank/Sprechblase3-1.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
end -- Chatbubble 3-1

function Chatbubble32()
	local x,y = guiGetScreenSize()
	local ax,ay,bx,by = fx + 0.5046875 * 1280,fy + 0.205078125 * 1024,0.21171875 * 1280,0.1845703125 * 1024    
	dxDrawImage(ax,ay,bx,by,"images/Bank/Sprechblase3-2.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
end -- Chatbubble 3-2

function Chatbubble41()
	local x,y = guiGetScreenSize()
	local ax,ay,bx,by = fx + 0.5046875 * 1280,fy + 0.205078125 * 1024,0.21171875 * 1280,0.1845703125 * 1024    
	dxDrawImage(ax,ay,bx,by,"images/Bank/Sprechblase4-1.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
end -- Chatbubble 4-1

function Chatbubble42()
	local x,y = guiGetScreenSize()
	local ax,ay,bx,by = fx + 0.5046875 * 1280,fy + 0.205078125 * 1024,0.21171875 * 1280,0.1845703125 * 1024    
	dxDrawImage(ax,ay,bx,by,"images/Bank/Sprechblase4-2.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
end -- Chatbubble 4-2

function Chatbubble5()
	local x,y = guiGetScreenSize()
	local ax,ay,bx,by = fx + 0.5046875 * 1280,fy + 0.205078125 * 1024,0.21171875 * 1280,0.1845703125 * 1024    
	dxDrawImage(ax,ay,bx,by,"images/Bank/Sprechblase5.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
end -- Chatbubble 5

function Chatbubble61()
	local x,y = guiGetScreenSize()
	local ax,ay,bx,by = fx + 0.5046875 * 1280,fy + 0.205078125 * 1024,0.21171875 * 1280,0.1845703125 * 1024    
	dxDrawImage(ax,ay,bx,by,"images/Bank/Sprechblase6-1.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
end -- Chatbubble 6-1

function Chatbubble62()
	local x,y = guiGetScreenSize()
	local ax,ay,bx,by = fx + 0.5046875 * 1280,fy + 0.205078125 * 1024,0.21171875 * 1280,0.1845703125 * 1024    
	dxDrawImage(ax,ay,bx,by,"images/Bank/Sprechblase6-2.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
end -- Chatbubble 6-2

function Chatbubble7()
	local x,y = guiGetScreenSize()
	local ax,ay,bx,by = fx + 0.5046875 * 1280,fy + 0.205078125 * 1024,0.21171875 * 1280,0.1845703125 * 1024    
	dxDrawImage(ax,ay,bx,by,"images/Bank/Sprechblase7.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
end -- Chatbubble 7

function banksets()
	showMenu()
	showBsc()	
end -- Bank Sets wird ausgefÃ¼hrt, wenn man das Objekt anklickt...
addEvent("openBank",true)
addEventHandler("openBank",getRootElement(),banksets)
function bankC()
	showMenuC()
end
addEvent("closeBank",true)
addEventHandler("closeBank",getRootElement(),bankC)

function createKcr1()
	GUIEditor_Label = {}
	GUIEditor_Edit = {}
	GUIEditor_Image = {}
	
	wdw_kcr1 = guiCreateWindow(423,212,398,436,"Konto erstellen",false)
	guiWindowSetMovable(wdw_kcr1,false)
	guiWindowSetSizable(wdw_kcr1,false)
	GUIEditor_Image[1] = guiCreateStaticImage(18,32,41,43,"images/sparkasse.png",false,wdw_kcr1)
	GUIEditor_Label[1] = guiCreateLabel(74,60,104,24,"Name: ",false,wdw_kcr1)
	guiLabelSetColor(GUIEditor_Label[1],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[1],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[1],"left",false)
	guiSetFont(GUIEditor_Label[1],"default-bold-small")
	GUIEditor_Label[2] = guiCreateLabel(74,170,104,24,"Kontonummer:",false,wdw_kcr1)
	guiLabelSetColor(GUIEditor_Label[2],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[2],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[2],"left",false)
	guiSetFont(GUIEditor_Label[2],"default-bold-small")
	GUIEditor_Label[3] = guiCreateLabel(74,224,104,24,"Pin:",false,wdw_kcr1)
	guiLabelSetColor(GUIEditor_Label[3],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[3],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[3],"left",false)
	guiSetFont(GUIEditor_Label[3],"default-bold-small")
	GUIEditor_Label[4] = guiCreateLabel(74,114,104,24,"Kontotyp:",false,wdw_kcr1)
	guiLabelSetColor(GUIEditor_Label[4],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[4],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[4],"left",false)
	guiSetFont(GUIEditor_Label[4],"default-bold-small")
	edt_kcr1_Name = guiCreateEdit(186,59,140,19,""..getPlayerName(getLocalPlayer()),false,wdw_kcr1)
	guiEditSetReadOnly(edt_kcr1_Name,true)
	GUIEditor_Edit[1] = guiCreateEdit(186,113,140,19,"Sparbuch",false,wdw_kcr1)
	guiEditSetReadOnly(GUIEditor_Edit[1],true)
	edt_kcr1_kontotyp = guiCreateEdit(186,167,140,19,"XXXXXX",false,wdw_kcr1)
	guiEditSetReadOnly(edt_kcr1_kontotyp,true)
	edt_kcr1_pin = guiCreateEdit(186,221,61,19,"Code",false,wdw_kcr1)

	
	
	GUIEditor_Label[5] = guiCreateLabel(74,278,104,24,"Zinssatz:",false,wdw_kcr1)
	guiLabelSetColor(GUIEditor_Label[5],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[5],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[5],"left",false)
	guiSetFont(GUIEditor_Label[5],"default-bold-small")
	GUIEditor_Edit[2] = guiCreateEdit(186,275,42,19,"0.5%",false,wdw_kcr1)  --Zinssatz
	guiEditSetReadOnly(GUIEditor_Edit[2],true)
	GUIEditor_Label[6] = guiCreateLabel(74,332,104,24,"Preis:",false,wdw_kcr1)
	guiLabelSetColor(GUIEditor_Label[6],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[6],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[6],"left",false)
	guiSetFont(GUIEditor_Label[6],"default-bold-small")
	GUIEditor_Edit[3] = guiCreateEdit(186,329,55,19,"400$",false,wdw_kcr1)
	guiEditSetReadOnly(GUIEditor_Edit[3],true)
	btn_kcr1_erstellen = guiCreateButton(262,377,104,33,"Erstellen",false,wdw_kcr1)
	btn_kcr1_cancel = guiCreateButton(114,377,104,33,"Abbrechen",false,wdw_kcr1)
	guiSetVisible(wdw_kcr1,false)

	addEventHandler("onClientGUIClick",btn_kcr1_erstellen,
	function(button)
		if button == "left" then
		guiSetVisible(wdw_kcr1,false)
		showCursor(false)
		guiSetInputEnabled(false)
		
		triggerServerEvent("CreateSB", getLocalPlayer(), getLocalPlayer())
		end
	end
	, false)
	
	addEventHandler("onClientGUIClick",btn_kcr1_cancel,
	function(button)
		if button == "left" then
			guiSetVisible(wdw_kcr1,false)
			showCursor(false)
			guiSetInputEnabled(false)
			showBsc()
		end
	end
	, false)




end -- createKcr1   Erstellen eines Sparbuches

function createKcr2()
	GUIEditor_Label = {}
	GUIEditor_Edit = {}
	GUIEditor_Image = {}
	
	wdw_kcr2 = guiCreateWindow(423,212,398,436,"Konto erstellen",false)
	guiWindowSetMovable(wdw_kcr2,false)
	guiWindowSetSizable(wdw_kcr2,false)
	GUIEditor_Image[1] = guiCreateStaticImage(18,32,41,43,"images/sparkasse.png",false,wdw_kcr2)
	GUIEditor_Label[1] = guiCreateLabel(74,60,104,24,"Name: ",false,wdw_kcr2)
	guiLabelSetColor(GUIEditor_Label[1],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[1],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[1],"left",false)
	guiSetFont(GUIEditor_Label[1],"default-bold-small")
	GUIEditor_Label[2] = guiCreateLabel(74,170,104,24,"Kontonummer:",false,wdw_kcr2)
	guiLabelSetColor(GUIEditor_Label[2],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[2],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[2],"left",false)
	guiSetFont(GUIEditor_Label[2],"default-bold-small")
	GUIEditor_Label[3] = guiCreateLabel(74,224,104,24,"Pin:",false,wdw_kcr2)
	guiLabelSetColor(GUIEditor_Label[3],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[3],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[3],"left",false)
	guiSetFont(GUIEditor_Label[3],"default-bold-small")
	GUIEditor_Label[4] = guiCreateLabel(74,114,104,24,"Kontotyp:",false,wdw_kcr2)
	guiLabelSetColor(GUIEditor_Label[4],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[4],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[4],"left",false)
	guiSetFont(GUIEditor_Label[4],"default-bold-small")
	edt_kcr2_Name = guiCreateEdit(186,59,140,19,""..getPlayerName(getLocalPlayer()),false,wdw_kcr2)
	guiEditSetReadOnly(edt_kcr2_Name,true)
	GUIEditor_Edit[1] = guiCreateEdit(186,113,140,19,"Girokonto",false,wdw_kcr2)
	guiEditSetReadOnly(GUIEditor_Edit[1],true)
	edt_kcr2_kontotyp = guiCreateEdit(186,167,140,19,"XXXXXX",false,wdw_kcr2)
	guiEditSetReadOnly(edt_kcr2_kontotyp,true)
	edt_kcr2_pin = guiCreateEdit(186,221,61,19,"Code",false,wdw_kcr2)

	addEventHandler("onClientGUIChanged", edt_kcr2_pin, 
	function(element)
	local text = guiGetText(element) -- text aus der editBox auslesen
	local int = string.gsub(text, "[^%d]", "") -- alle nicht numerischen zeichen lÃ¶schen
	if text ~= int then -- falls der int wert vom text abweicht
		guiSetText(element, int) -- den int wert als text der editBox setzen
	end

	end
	) 
	guiEditSetMaxLength(edt_kcr2_pin,4)-- eventhandler bei Ã¤ndern des textes
	
	GUIEditor_Label[5] = guiCreateLabel(74,278,104,24,"Zinssatz:",false,wdw_kcr2)
	guiLabelSetColor(GUIEditor_Label[5],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[5],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[5],"left",false)
	guiSetFont(GUIEditor_Label[5],"default-bold-small")
	GUIEditor_Edit[2] = guiCreateEdit(186,275,42,19,"0%",false,wdw_kcr2)  --Zinssatz
	guiEditSetReadOnly(GUIEditor_Edit[2],true)
	GUIEditor_Label[6] = guiCreateLabel(74,332,104,24,"Preis:",false,wdw_kcr2)
	guiLabelSetColor(GUIEditor_Label[6],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[6],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[6],"left",false)
	guiSetFont(GUIEditor_Label[6],"default-bold-small")
	GUIEditor_Edit[3] = guiCreateEdit(186,329,55,19,"100$",false,wdw_kcr2)
	guiEditSetReadOnly(GUIEditor_Edit[3],true)
	btn_kcr2_erstellen = guiCreateButton(262,377,104,33,"Erstellen",false,wdw_kcr2)
	btn_kcr2_cancel = guiCreateButton(114,377,104,33,"Abbrechen",false,wdw_kcr2)
	guiSetVisible(wdw_kcr2,false)

	addEventHandler("onClientGUIClick",btn_kcr2_erstellen,
	function(button)
		if button == "left" then
			if(#guiGetText(edt_kcr2_pin) ~= 4) then
				return outputChatBox("Dein Pin muss mindestens 4 Zahlen lang sein.")
			end
			
			if(tonumber(guiGetText(edt_kcr2_pin)) == nil) then
				outputChatBox("Du musst deinen eigenen Pin aussuchen!")
				return 1
			end

			guiSetVisible(wdw_kcr2,false)
			showCursor(false)
			guiSetInputEnabled(false)
			
			triggerServerEvent("CreateGiro", getLocalPlayer(), getLocalPlayer(), guiGetText(edt_kcr2_pin))
			
			
		end
	end
	, false)
	
	addEventHandler("onClientGUIClick",btn_kcr2_cancel,
	function(button)
		if button == "left" then
			guiSetVisible(wdw_kcr2,false)
			showCursor(false)
			guiSetInputEnabled(false)
			showBsc()
		end
	end
	, false)




end -- createKcr2   Erstellen eines Giro Kontos

function showKcr1()
	showCursor(true)
	guiSetInputEnabled(true)
	guiSetVisible (wdw_kcr1 , true )
end -- showKcr1

function showKcr2()
	showCursor(true)
	guiSetInputEnabled(true)
	guiSetVisible (wdw_kcr2 , true )
end -- ShowKcr2

function showKcrSel()
	addEventHandler("onClientRender",getRootElement(),Chatbubble2)
	guiSetVisible(wdw_kcr_sel, true )
	SBDown = false
	GKDown = false
	addEventHandler("onClientRender",getRootElement(),iconSBGK)
end -- showKcrSelection   Hier wird ausgewÃ¤hlt, welches Konto man erstellen mÃ¶chte.

function hideKcrSelection()
	removeEventHandler("onClientRender",getRootElement(),Chatbubble2)
	guiSetVisible(wdw_kcr_sel, false )
	removeEventHandler("onClientRender",getRootElement(),iconSBGK)
end -- hideKcrSelection  

function iconSBGK()
		--dxDrawImage(548.0,863.0,49.0,60.0,"images/sparbuch.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
        --dxDrawImage(684.0,885.0,63.0,39.0,"images/sparkassenKarte.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)

	local x,y = guiGetScreenSize()
	local ax1,ay1 = fx + 548,fy + 863
	local bx1,by1 = 45.685279187817258883248730964467,60.0
	if(SBDown == false) then
		dxDrawImage(ax1,ay1,bx1,by1,"images/sparbuch.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	elseif(SBDown == true) then
		dxDrawImage(ax1,ay1,bx1,by1,"images/sparbuchS.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	end
	local bx2,by2 = 63,39.9
	local ax2,ay2 = fx + (0.534375 * 1280), ay1 + by1 - by2
	if(GKDown == false) then
		dxDrawImage(ax2,ay2,bx2,by2,"images/sparkassenKarte.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	elseif(GKDown == true) then
		dxDrawImage(ax2,ay2,bx2,by2,"images/sparkassenKarteS.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	end
	
end -- iconSBGK wird gerendert um die Bilder in showKcrSelection dazustellen

function createKcrSel()
	GUIEditor_Label = {}

	local x,y = guiGetScreenSize()
	local bx,by = 295,115
	local ax,ay = (x/2 - 1280/2) + 503, (y/2 - 1024/2) + 820

	wdw_kcr_sel = guiCreateWindow(ax,ay,bx,by,"Konto erstellen",false)
	guiWindowSetMovable(wdw_kcr_sel,false)
	guiWindowSetSizable(wdw_kcr_sel,false)
	--img_sparbuch = guiCreateStaticImage(0.1628,0.374,0.1561,0.5041,"images/sparbuch.png",true,wdw_kcr_sel)
	--img_karte = guiCreateStaticImage(0.6146,0.561,0.2027,0.3008,"images/sparkassenKarte.png",true,wdw_kcr_sel)
	GUIEditor_Label[1] = guiCreateLabel(0.1495,0.187,0.186,0.1707,"Sparbuch",true,wdw_kcr_sel)
	guiLabelSetColor(GUIEditor_Label[1],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[1],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[1],"left",false)
	guiSetFont(GUIEditor_Label[1],"default-bold-small")
	btn_frage_sb = guiCreateButton(0.3422,0.1626,0.0698,0.1707,"?",true,wdw_kcr_sel)
	GUIEditor_Label[2] = guiCreateLabel(0.608,0.187,0.186,0.1707,"Girokonto",true,wdw_kcr_sel)
	guiLabelSetColor(GUIEditor_Label[2],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[2],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[2],"left",false)
	guiSetFont(GUIEditor_Label[2],"default-bold-small")
	btn_frage_gk = guiCreateButton(0.8007,0.1626,0.0698,0.1707,"?",true,wdw_kcr_sel)
	btn_sparbuch = guiCreateButton(0.1462,0.3577,0.1894,0.5366,"",true,wdw_kcr_sel)
	guiSetAlpha(btn_sparbuch,0)
	btn_giro = guiCreateButton(0.6047,0.5285,0.2259,0.374,"",true,wdw_kcr_sel)
	guiSetAlpha(btn_giro,0)
	
	
	guiSetVisible(wdw_kcr_sel,false)

	addEventHandler("onClientGUIClick",btn_frage_sb,
		function(button)
			if button == "left" then
				hideKcrSelection()
				showFrageSparbuch()
			end
		end
		, false)
	
	addEventHandler("onClientGUIClick",btn_frage_gk,
		function(button)
			if button == "left" then
				hideKcrSelection()
				showFrageGiroKonto()
			end
		end
		, false)
	
	
	addEventHandler("onClientGUIClick",btn_giro,
		function(button)
			if button == "left" then
				hideKcrSelection()
				if(getElementData(getLocalPlayer() ,"KNG") ~= false and getElementData(getLocalPlayer() ,"KNG") ~= 0 ) then
					showBsc()
					removeEventHandler("onClientRender", getRootElement() , Chatbubble1)
					addEventHandler("onClientRender", getRootElement() , Chatbubble42)
					
					return 1
				end
				animID = 1
				animTyp = 1
				openCloseAnim1()
				showCursor(true)
				guiSetInputEnabled(true)
			end
		end
		, false)
	
	addEventHandler("onClientGUIClick",btn_sparbuch,
		function(button)
			if button == "left" then
				removeEventHandler("onClientRender", getRootElement() , Chatbubble2)
				removeEventHandler("onClientRender",getRootElement(),iconSBGK) 
				showCursor(false)
				guiSetInputEnabled(false)
				guiSetVisible (wdw_kcr_sel , false )
				if(getElementData(getLocalPlayer(),"KNS") ~= false and getElementData(getLocalPlayer(),"KNS") ~= 0) then
					showBsc()
					removeEventHandler("onClientRender", getRootElement() , Chatbubble1)
					addEventHandler("onClientRender", getRootElement() , Chatbubble41)
					return 1
				end
				animID = 1
				animTyp = 2
				openCloseAnim1()
				showCursor(true)
				guiSetInputEnabled(true)
			end
		end
		, false)


end -- createKcrSelection  Hier wird das KcrSelection Fenster erstellt

function createFrageSparbuch()
	GUIEditor_Label = {}
	GUIEditor_Image = {}
	local x,y = guiGetScreenSize()
	local bx,by = 365.056, 438.9888
	local ax,ay = x/2 - bx/2,y/2 - by/2
	
	wdw_frageSB = guiCreateWindow(ax,ay,bx,by,"Info Sparbuch",false)
	guiWindowSetMovable(wdw_frageSB,false)
	guiWindowSetSizable(wdw_frageSB,false)
	GUIEditor_Image[1] = guiCreateStaticImage(0.0712,0.0934,0.3452,0.3804,"images/sparbuch.png",true,wdw_frageSB)
	GUIEditor_Label[1] = guiCreateLabel(0.0712,0.5467,0.6877,0.262,"Vorteile: \n - Hohe Zinsen \n\nNachteile: \n - Geld ist nur in der Bank abbuchbar \n\n - Wenn die Bank geschlossen hat, kommt man nicht an sein Geld \n ",true,wdw_frageSB)
	guiLabelSetColor(GUIEditor_Label[1],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[1],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[1],"left",true)
--	guiSetFont(GUIEditor_Label[1],"default-bold-small")
	guiSetFont(GUIEditor_Label[1],"clear-normal")
	GUIEditor_Label[2] = guiCreateLabel(0.4685,0.0934,0.4274,0.3941,"Ein Sparbuch ist die beste Variante sein hart verdientes Geld anzulegen. Die Zinsen bei einem Sparbuch sind höher als bei einem Girokonto. \nTrotzdem sollten Sie nicht all Ihr Geld auf das Sparbuch legen, da sie nur während der Öffnungzeiten der Bank abbuchen können !",true,wdw_frageSB)
	guiLabelSetColor(GUIEditor_Label[2],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[2],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[2],"left",true)
	
	guiSetVisible(wdw_frageSB,false)

end -- createFrageSparbuch

function showFrageSparbuch()
	guiSetVisible (wdw_frageSB , true )
end -- showFrageSparbuch

function hideFrageSparbuch()
	guiSetVisible (wdw_frageSB , false )
end -- hideFrageSparbuch

function createFrageGiroKonto()
	GUIEditor_Label = {}
	GUIEditor_Image = {}
	
	local x,y = guiGetScreenSize()
	local bx,by = 365.056,438,9888
	local ax,ay = x/2 - bx/2,y/2 - by/2 -- x/2 - bx/2,y/2 - by
	wdw_frageGK = guiCreateWindow(ax,ay,bx,by,"Info Girokonto",false)
	guiWindowSetMovable(wdw_frageGK,false)
	guiWindowSetSizable(wdw_frageGK,false)
	GUIEditor_Label[1] = guiCreateLabel(0.0685,0.4738,0.6877,0.4852,"Vorteile: \n - Geld immer verfügbar, wenn ein Bankautomat in der Nähe ist \n\n - man kann Geld überwiesen bekommen oder anderen Spielern Geld überweisen, auch wenn sie nicht in der Nähe sind \n\n Nachteile: \n - Geld kann man nur in der Bank einzahlen \n\n - niedrige Zinsen  ",true,wdw_frageGK)
	guiLabelSetColor(GUIEditor_Label[1],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[1],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[1],"left",true)
	guiSetFont(GUIEditor_Label[1],"clear-normal")
	GUIEditor_Label[2] = guiCreateLabel(0.4329,0.0934,0.5507,0.3827,"Ein Girokonto ist eine gute Variante, um sein Geld anzulegen, auf das man immer zugreifen möchte. Man kann das Geld an jedem Bankautomaten, zu jeder Zeit abheben. Sie können, auch Geld von einem Girokonto auf ein anderes Ueberweisen. Sie brauchen ausserdem ein Girokonto um einen Job anzunehmen, damit sie ihr Gehalt erhalten können.",true,wdw_frageGK)
	guiLabelSetColor(GUIEditor_Label[2],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[2],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[2],"left",true)

	GUIEditor_Image[1] = guiCreateStaticImage(0.0685,0.1025,0.3288,0.1617,"images/sparkassenKarte.png",true,wdw_frageGK)
	
	guiSetVisible(wdw_frageGK,false)
end -- createFrageGiroKonto

function showFrageGiroKonto()
	guiSetVisible (wdw_frageGK , true )
end -- showFrageGiroKonto

function hideFrageGiroKonto()
	guiSetVisible (wdw_frageGK , false )
end -- hideFrageGiroKonto

function createEditBank()
	GUIEditor_Label = {}

	local x,y = guiGetScreenSize()
	local bx,by = 295,115
	local ax,ay = (x/2 - 1280/2) + 503, (y/2 - 1024/2) + 820

	wdw_EditBank = guiCreateWindow(ax,ay,bx,by,"Konto Zugreifen",false)
	guiWindowSetMovable(wdw_EditBank,false)
	guiWindowSetSizable(wdw_EditBank,false)
	
	GUIEditor_Label[1] = guiCreateLabel(0.1495,0.187,0.186,0.1707,"Sparbuch",true,wdw_EditBank)
	guiLabelSetColor(GUIEditor_Label[1],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[1],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[1],"left",false)
	guiSetFont(GUIEditor_Label[1],"default-bold-small")
	GUIEditor_Label[2] = guiCreateLabel(0.608,0.187,0.186,0.1707,"Girokonto",true,wdw_EditBank)
	guiLabelSetColor(GUIEditor_Label[2],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[2],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[2],"left",false)
	guiSetFont(GUIEditor_Label[2],"default-bold-small")
	btn_sparbuchEdt = guiCreateButton(0.1462,0.3577,0.1894,0.5366,"",true,wdw_EditBank)
	guiSetAlpha(btn_sparbuchEdt,0)
	btn_giroEdt = guiCreateButton(0.6047,0.5285,0.2259,0.374,"",true,wdw_EditBank)
	guiSetAlpha(btn_giroEdt,0)
	
	
	guiSetVisible(wdw_EditBank,false)

	
	
	addEventHandler("onClientGUIClick",btn_giroEdt,
		function(button)
			if button == "left" then
				hideEditBank()
				if(getElementData(getLocalPlayer() ,"KNG") == false or getElementData(getLocalPlayer() ,"KNG") == 0) then
					showBsc()
					removeEventHandler("onClientRender", getRootElement() , Chatbubble1) -- Ãndern !!!
					addEventHandler("onClientRender", getRootElement() , Chatbubble62)
					
					return 1
				end
				giroSel = true
				showZugriffSel()
			end
		end
		, false)
	
	addEventHandler("onClientGUIClick",btn_sparbuchEdt,
		function(button)
			if button == "left" then 
				hideEditBank()

				if(getElementData(getLocalPlayer(),"KNS") == false or getElementData(getLocalPlayer(),"KNS") == 0 ) then
					showBsc()
					removeEventHandler("onClientRender", getRootElement() , Chatbubble1) -- Ãndern !!
					addEventHandler("onClientRender", getRootElement() , Chatbubble61)
					return 1
				end
				sparSel = true
				showZugriffSel()
			end
		end
		, false)


end -- createEditBank  

function showEditBank()
	addEventHandler("onClientRender",getRootElement(),Chatbubble5)
	guiSetVisible(wdw_EditBank, true )
	SBDown = false
	GKDown = false
	sparSel = false
	giroSel = false
	addEventHandler("onClientRender",getRootElement(),iconSBGK)
end -- showEditBank

function hideEditBank()
	removeEventHandler("onClientRender",getRootElement(),iconSBGK)
	removeEventHandler("onClientRender",getRootElement(),Chatbubble5)
	SBDown = false
	GKDown = false
	guiSetVisible(wdw_EditBank, false)
	
end -- hideEditBank

function createZugriffSelGK()
	GUIEditor_Label = {}

	local x,y = guiGetScreenSize()
	local bx,by = 295,115
	local ax,ay = (x/2 - 1280/2) + 503, (y/2 - 1024/2) + 820

	wdw_zuSelGK = guiCreateWindow(ax,ay,bx,by,"Girokontoptionen",false)
	guiWindowSetMovable(wdw_zuSelGK,false)
	guiWindowSetSizable(wdw_zuSelGK,false)
	
	btn_einzahlen = guiCreateButton(0.0644,0.469,0.1831,0.3805,"",true,wdw_zuSelGK)
	guiSetAlpha(btn_einzahlen,0)
	btn_abbuchen = guiCreateButton(0.3186,0.469,0.2034,0.3805,"",true,wdw_zuSelGK)
	guiSetAlpha(btn_abbuchen,0)
	btn_transaction = guiCreateButton(0.6542,0.3894,0.2407,0.469,"",true,wdw_zuSelGK)
	guiSetAlpha(btn_transaction,0)
	GUIEditor_Label[1] = guiCreateLabel(0.0678,0.2743,0.4576,0.1858,"Einzahlen   /  Abbuchen",true,wdw_zuSelGK)
	guiSetAlpha(GUIEditor_Label[1],1)
	guiLabelSetColor(GUIEditor_Label[1],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[1],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[1],"left",true)
	guiSetFont(GUIEditor_Label[1],"default-bold-small")
	GUIEditor_Label[2] = guiCreateLabel(0.6576,0.2212,0.2542,0.1416,"Transaktion",true,wdw_zuSelGK)
	guiSetAlpha(GUIEditor_Label[2],1)
	guiLabelSetColor(GUIEditor_Label[2],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[2],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[2],"left",false)
	guiSetFont(GUIEditor_Label[2],"default-bold-small")
	

	
	guiSetVisible(wdw_zuSelGK,false)
	
	addEventHandler("onClientGUIClick",btn_einzahlen,
	function(button)
	 	if button == "left" then
			hideZugriffSel()
			dataID = 1
			animID = 1
			openCloseAnim2()
		end
	end 
	, false)

	addEventHandler("onClientGUIClick",btn_abbuchen,
	function(button)
	 	if button == "left" then
			hideZugriffSel()
			dataID = 2
			animID = 1
			openCloseAnim2()
		end
	end 
	, false)
	
	addEventHandler("onClientGUIClick",btn_transaction,
	function(button)
	 	if button == "left" then
			hideZugriffSel()
			dataID = 3
			animID = 1
			openCloseAnim2()
		end
	end 
	, false)
	
	
	
end -- createZugriffSelGK

function createZugriffSelSB()
	GUIEditor_Label = {}

	local x,y = guiGetScreenSize()
	local bx,by = 295,115
	local ax,ay = (x/2 - 1280/2) + 503, (y/2 - 1024/2) + 820

	wdw_zuSelSB = guiCreateWindow(ax,ay,bx,by,"Sparbuchoptionen",false)
	guiWindowSetMovable(wdw_zuSelSB,false)
	guiWindowSetSizable(wdw_zuSelSB,false)
	
	GUIEditor_Label[1] = guiCreateLabel(0.2041,0.0783,0.017,0.0435,"",true,wdw_zuSelSB)
	guiLabelSetColor(GUIEditor_Label[1],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[1],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[1],"left",false)
	GUIEditor_Label[2] = guiCreateLabel(111,-306,5,5,"",false,wdw_zuSelSB)
	guiLabelSetColor(GUIEditor_Label[2],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[2],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[2],"left",false)
	GUIEditor_Label[3] = guiCreateLabel(0.1769,0.2435,0.2517,0.1652,"Einzahlen",true,wdw_zuSelSB)
	guiLabelSetColor(GUIEditor_Label[3],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[3],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[3],"left",false)
	guiSetFont(GUIEditor_Label[3],"default-bold-small")
	GUIEditor_Label[4] = guiCreateLabel(0.483,0.2435,0.085,0.1652,"/",true,wdw_zuSelSB)
	guiLabelSetColor(GUIEditor_Label[4],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[4],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[4],"left",false)
	guiSetFont(GUIEditor_Label[4],"default-bold-small")
	GUIEditor_Label[5] = guiCreateLabel(0.5646,0.2435,0.2517,0.1652,"Abbuchen",true,wdw_zuSelSB)
	guiLabelSetColor(GUIEditor_Label[5],255,255,255)
	guiLabelSetVerticalAlign(GUIEditor_Label[5],"top")
	guiLabelSetHorizontalAlign(GUIEditor_Label[5],"left",false)
	guiSetFont(GUIEditor_Label[5],"default-bold-small")
	btn_einzahlenSB = guiCreateButton(0.1701,0.4174,0.2755,0.4783,"",true,wdw_zuSelSB)
	guiSetAlpha(btn_einzahlenSB,0)
	btn_abbuchenSB = guiCreateButton(0.5544,0.4261,0.2789,0.4783,"",true,wdw_zuSelSB)
	guiSetAlpha(btn_abbuchenSB,0)






	
	guiSetVisible(wdw_zuSelSB,false)

	addEventHandler("onClientGUIClick",btn_einzahlenSB,
	function(button)
	 	if button == "left" then
			hideZugriffSel()
			dataID = 1
			animID = 1
			openCloseAnim2()
		end
	end 
	, false)
	
	addEventHandler("onClientGUIClick",	btn_abbuchenSB,
	function(button)
	 	if button == "left" then
			hideZugriffSel()
			dataID = 2
			animID = 1
			openCloseAnim2()		
		end
	end 
	, false)
	
	
	
end -- createZugriffSelSB

function showZugriffSel()
	addEventHandler("onClientRender",getRootElement(),Chatbubble7)
	transIco = false
	einzIco = false
	abbIco = false
	if(giroSel == true) then
		guiSetVisible(wdw_zuSelGK, true )	
		addEventHandler("onClientRender",getRootElement(),optionIcoGK)
	elseif(sparSel == true) then
		guiSetVisible(wdw_zuSelSB, true )	
		addEventHandler("onClientRender",getRootElement(),optionIcoSB)
	end

end -- showZugriffSel

function hideZugriffSel()
	removeEventHandler("onClientRender",getRootElement(),Chatbubble7)
	
	if(giroSel == true) then
		removeEventHandler("onClientRender",getRootElement(),optionIcoGK)
		guiSetVisible(wdw_zuSelGK, false )
	elseif(sparSel == true) then
		removeEventHandler("onClientRender",getRootElement(),optionIcoSB)
		guiSetVisible(wdw_zuSelSB, false )
	end
end -- hideZugriffSel

function optionIcoGK()

	local bx,by = 69.169329073482428115015974440895,50
	local ax,ay = fx + 697, fy + 866
	if(transIco == false) then
		dxDrawImage(ax,ay,bx,by,"images/transaction.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	elseif(transIco == true) then
		dxDrawImage(ax,ay,bx,by,"images/Bank/transactionS.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	end
	
	local bx,by = 51.728333333333333333333333,41
	local ax,ay = fx + 523, fy + 875
	if(einzIco == false) then
		dxDrawImage(ax,ay,bx,by,"images/KontoEinzahlen.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	elseif(einzIco == true) then
		dxDrawImage(ax,ay,bx,by,"images/Bank/KontoEinzahlenS.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	end
	
	local bx,by = 57.189406099518459069020866773676,41
	local ax,ay = fx + 598, fy + 875
	if(abbIco == false) then
		dxDrawImage(ax,ay,bx,by,"images/abbuchen.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	elseif(abbIco == true) then
		dxDrawImage(ax,ay,bx,by,"images/Bank/abbuchenS.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	end
	
end -- (render) optioIconGK

function optionIcoSB()

	local bx,by = 75.542662116040955631399317406143,51
	local ax,ay = fx + 555, fy + 870
	if(einzIco == false) then
		dxDrawImage(ax,ay,bx,by,"images/KontoEinzahlen.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	elseif(einzIco == true) then
		dxDrawImage(ax,ay,bx,by,"images/Bank/KontoEinzahlenS.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	end
	
	local ax,ay = fx + 669, fy + 870
	local bx,by = 75.542662116040955631399317406143,51
	if(abbIco == false) then
		dxDrawImage(ax,ay,bx,by,"images/abbuchen.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	elseif(abbIco == true) then
		dxDrawImage(ax,ay,bx,by,"images/Bank/abbuchenS.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	end
end -- (render) optioIconSB

function showMenu()
	bDoorStatus = "close"
	bmstate = 1
	addEventHandler("onClientRender",getRootElement(), bankMenuS)
	addEventHandler("onClientRender",getRootElement(),drawBankSchalter)
	addEventHandler("onClientRender",getRootElement(),backExit)
	local x,y = guiGetScreenSize()
	local ax,ay = (x/2 - 1280/2) + 427.0,(y/2 - 1024/2) + 849.0
	local bx,by = 35,35
	btn_BMcancel = guiCreateButton(ax,ay,bx,by,"",false)
	guiSetAlpha(btn_BMcancel,0)
	local ay = (y/2 - 1024/2) + 893.0
	btn_BMback = guiCreateButton(ax,ay,bx,by,"",false)
	guiSetAlpha(btn_BMback,0)
	btn_BMbackDown = false
	btn_BMcancelDown = false
	addEventHandler("onClientGUIClick",btn_BMback,
	function(button)
		if button == "left" then
			
			if(guiGetVisible(wdw_frageSB) == true or guiGetVisible(wdw_frageGK) == true ) then
				hideFrageGiroKonto()
				hideFrageSparbuch()
				showKcrSel()
			elseif(guiGetVisible(wdw_kcr_sel) == true) then
				hideKcrSelection()
				showBsc()
			elseif(SBCrActive == true) then
				removeEventHandler("onClientRender",getRootElement(),endBlatt)
				hideSBCr()
				showKcrSel()
			elseif(GKCrActive == true) then
				removeEventHandler("onClientRender",getRootElement(),endBlatt)
				hideGKCr()
				showKcrSel()
			elseif(guiGetVisible(wdw_EditBank) == true) then
				hideEditBank()
				showBsc()
			elseif(guiGetVisible(wdw_zuSelGK) == true or guiGetVisible(wdw_zuSelSB) == true) then
				hideZugriffSel()
				showEditBank()
			elseif(kontoeinzshow == true) then
				removeEventHandler("onClientRender",getRootElement(),endData)
				hideBankEinzahlen()
				showZugriffSel()
			elseif(kontoabbshow == true) then
				removeEventHandler("onClientRender",getRootElement(),endData)
				hideBankAbbuchen()
				showZugriffSel()
			elseif(showedTransaction == true) then
				removeEventHandler("onClientRender",getRootElement(),endData)
				hideBankTransaction()
				showZugriffSel()
			end
		end
	end
	,false)
	
	addEventHandler("onClientGUIClick",btn_BMcancel,
	function(button)
		if button == "left" then
			if(toggClose == false or toggClose == nil) then
				removeEventHandler("onClientRender",getRootElement(),endBlatt)
				removeEventHandler("onClientRender",getRootElement(),endData)
				hideFrageSparbuch()
				hideFrageGiroKonto()
				hideMenu()
				hideBsc()
				hideKcrSelection()
				hideEditBank()
				hideZugriffSel()
				hideBankEinzahlen()
				hideBankAbbuchen()
				hideBankTransaction()
				if(GKCrActive == true) then
					hideGKCr()
				elseif(SBCrActive == true) then
					hideSBCr()
				end
			end
			
		end
	end
	,false)
end -- showMenu   Zeigt das MenÃ¼ der Bank an, ohne Fenster


function showMenuC()
	guiSetInputEnabled(true)
	addEventHandler("onClientRender",getRootElement(),closed)
	local x,y = guiGetScreenSize()
	local ax,ay = (x/2 - 1280/2) + 427.0,(y/2 - 1024/2) + 849.0
	local bx,by = 35,35
	setTimer(
	function()
		removeEventHandler("onClientRender",getRootElement(),closed)
		guiSetInputEnabled(false)
	end,4250,1)
	
	
end -- showMenu   Zeigt das MenÃ¼ der Bank an, ohne Fenster


function closed()
	local x,y = guiGetScreenSize()
	fx,fy = x/2 - 1280/2, y/2 - 1024/2
	dxDrawImage(fx,fy,1280,1024,"images/Bank/bankgeschlossen.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)

end

function hideMenu()
	bmstate = 0
	destroyElement(btn_BMcancel)
	destroyElement(btn_BMback)
	guiSetInputEnabled(false)
	showCursor(false)
	removeEventHandler("onClientRender",getRootElement(),fullClosed)
	removeEventHandler("onClientRender",getRootElement(), bankMenuS)
	removeEventHandler("onClientRender",getRootElement(), drawBankSchalter)
	removeEventHandler("onClientRender",getRootElement(), backExit)
	removeEventHandler("onClientRender", getRootElement() , Chatbubble1)
	removeEventHandler("onClientRender", getRootElement() , Chatbubble2)
	removeEventHandler("onClientRender", getRootElement() , Chatbubble31)
	removeEventHandler("onClientRender", getRootElement() , Chatbubble32)
	removeEventHandler("onClientRender", getRootElement() , Chatbubble41)
	removeEventHandler("onClientRender", getRootElement() , Chatbubble42)
	removeEventHandler("onClientRender", getRootElement() , Chatbubble5)
	removeEventHandler("onClientRender", getRootElement() , Chatbubble61)
	removeEventHandler("onClientRender", getRootElement() , Chatbubble62)
	removeEventHandler("onClientRender", getRootElement() , Chatbubble7)
end -- hideMenu   ZerstÃ¶rt das MenÃ¼ der Bank

function backExit()
	--[[dxDrawImage(427.0,893.0,52.0,52.0,"images/Bank/btn_back.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
        dxDrawImage(427.0,849.0,52.0,52.0,"images/Bank/btn_back.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)]]


	--dxDrawImage(422.0,864.0,65.0,48.0,"images/Bank/btn_exit.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	local x,y = guiGetScreenSize()
	local ax,ay = fx + 427.0,fy + 849.0
	local bx,by = 35,35
	if(btn_BMcancelDown == false) then
		dxDrawImage(ax,ay,bx,by,"images/Bank/btn_exit.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	elseif(btn_BMcancelDown == true) then
		dxDrawImage(ax,ay,bx,by,"images/Bank/btn_exitS.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	end
	local ay = fy + 893.0
	local bx,by = 35,35
	if(btn_BMbackDown == false) then
		dxDrawImage(ax,ay,bx,by,"images/Bank/btn_back.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	elseif(btn_BMbackDown == true) then
		dxDrawImage(ax,ay,bx,by,"images/Bank/btn_backS.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	end
end -- backExit Hier wird der zurÃ¼ck und der cancel button gerendert

addEventHandler( "onClientMouseEnter", getRootElement(), 
    function(aX, aY)
    	if(source == btn_BMcancel) then
        	btn_BMcancelDown = true
        elseif(source == btn_BMback) then
        	btn_BMbackDown = true
        elseif(source == btn_sparbuch or source == btn_sparbuchEdt) then
        	SBDown = true
        elseif(source == btn_giro or source == btn_giroEdt) then
			GKDown = true
		elseif(source == btn_bankCreate) then	
			btn_skD = true
		elseif(source == btn_bankOp) then
			btn_sgtD = true
		elseif(source == btn_einzahlen or source == btn_einzahlenSB) then
			einzIco = true
		elseif(source == btn_abbuchen or source == btn_abbuchenSB) then
			abbIco = true
		elseif(source == btn_transaction) then
			transIco = true
        end
        
    end
)

addEventHandler("onClientMouseLeave", getRootElement(), 
	function(aX, aY)
	    if(source == btn_BMcancel) then
	    	btn_BMcancelDown = false
	    elseif(source == btn_BMback) then
	    	btn_BMbackDown = false
	    elseif(source == btn_sparbuch or source == btn_sparbuchEdt) then
	    	SBDown = false
	    elseif(source == btn_giro or source == btn_giroEdt) then
			GKDown = false
		elseif(source == btn_bankCreate) then
			btn_skD = false
		elseif(source == btn_bankOp) then
			btn_sgtD = false
		elseif(source == btn_einzahlen or source == btn_einzahlenSB) then		
			einzIco = false
		elseif(source == btn_abbuchen or source == btn_abbuchenSB) then
			abbIco = false
		elseif(source == btn_transaction) then
			transIco = false
	    end

	end
)

function openClose()
	if(bDoorStatus == "close") then
		removeEventHandler("onClientRender",getRootElement(), drawBankSchalter)
		removeEventHandler("onClientRender",getRootElement(), BdoorClose)
		tx1 = 0.3625
		addEventHandler("onClientRender",getRootElement(), BdoorOpen)
		
		bDoorStatus = "open"
	elseif(bDoorStatus == "open") then
		removeEventHandler("onClientRender",getRootElement(), BdoorOpen)
		tx1 = 0.55390625
		addEventHandler("onClientRender",getRootElement(), BdoorClose)
	
		bDoorStatus = "close"
	end
end -- openClose  Die Bankschalter TÃ¼r kann man mit diesem Befehl Ã¶ffnen und schlieÃen

function drawBankSchalter()
		local x,y = guiGetScreenSize()
		local bx,by = 398.000, 399.0000
		local ax,ay = ((1280/2 + fx) - bx/2) + 22.5, ((1024/2 + fy) - by/2) + 146.5 --+245
		--0.3625*x,0.4482421875*y             464.0000,459.0000
        --dxDrawImage(464.0000,459.0000,398.000,399.0000,"images/Tur.png",0.0,0.0,0.0,tocolor(255,255,255,255),true) 
        dxDrawImage(ax,ay,bx,by,"images/Tur.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)         
end -- drawBankSchalter  Hier wird nur die TÃ¼r des Bankschalters dagestellt...

function bankMenuS()
	local x,y = guiGetScreenSize()
	fx,fy = x/2 - 1280/2, y/2 - 1024/2
	dxDrawImage(fx,fy,1280,1024,"images/Schreibtisch3.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
end -- BankMenuS Wird gerendert um das Bank MenÃ¼ dazustellen

-- XX
function openCloseAnim1()
	if(bDoorStatus == "close") then
		removeEventHandler("onClientRender",getRootElement(), drawBankSchalter)
		removeEventHandler("onClientRender",getRootElement(), fullClosed)
		toggClose = true
		tx1 = ((1280/2 + fx) - 398.000/2) + 22.5
		if(animID == 1) then
			addEventHandler("onClientRender",getRootElement(), startBlatt)
		elseif(animID ==2) then
		
		end
		addEventHandler("onClientRender",getRootElement(), BdoorOpenAnim1)
		
		bDoorStatus = "open"
	elseif(bDoorStatus == "open") then
		toggClose = true
		removeEventHandler("onClientRender",getRootElement(), fullOpened)
		tx1 = ((1280/2 + fx) - 398.000/2) + 22.5 + 245
		addEventHandler("onClientRender",getRootElement(), BdoorCloseAnim1)
		bDoorStatus = "close"
	end
end -- openCloseAnim1  Die Bankschalter TÃ¼r kann man mit diesem Befehl Ã¶ffnen und schlieÃen

function BdoorOpenAnim1()
	if(tx1 < ((1280/2 + fx) - 398.000/2) + 22.5 + 245) then
		local x,y = guiGetScreenSize()
		local ax,ay = tx1, ((1024/2 + fy) - 399.0000/2) + 146.5
		local bx,by = 398.000, 399.0000
		dxDrawImage(ax,ay,bx,by,"images/Tur.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
		tx1 = tx1 + 3.8

	else
		removeEventHandler("onClientRender",getRootElement(), BdoorOpenAnim1)
		removeEventHandler("onClientRender",getRootElement(), startBlatt)
		removeEventHandler("onClientRender",getRootElement(), endBlatt)
		addEventHandler("onClientRender", getRootElement(),fullOpened)
		if(animID == 1) then
			startY = 0.6806640625
		elseif(animID == 2) then
			startY = 0.794921875
		end
		addEventHandler("onClientRender", getRootElement(),moveBlatt)
		
	end
end -- BdoorOpen  Bank TÃ¼r wird geÃ¶ffnet (Schalter)

function fullOpened()
	local x,y = guiGetScreenSize()
	local bx,by = 398.000, 399.0000 
	local ax,ay = ((1280/2 + fx) - bx/2) + 22.5 + 245, ((1024/2 + fy) - by/2) + 146.5 --709  -> 464
	dxDrawImage(ax,ay,bx,by,"images/Tur.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)  
end -- fullOpened

function BdoorCloseAnim1()
	if(tx1 > ((1280/2 + fx) - 398.000/2) + 22.5) then
		local x,y = guiGetScreenSize()
		local ax,ay = tx1, ((1024/2 + fy) - 399.0000/2) + 146.5
		local bx,by = 398.000, 399.0000
		dxDrawImage(ax,ay,bx,by,"images/Tur.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
		tx1 = tx1  - 3.8
	else
		removeEventHandler("onClientRender",getRootElement(),BdoorCloseAnim1)
		addEventHandler("onClientRender",getRootElement(),fullClosed)
		if(animTyp == 1) then
			if(animID == 2) then
				showBsc()
				toggClose = false
				removeEventHandler("onClientRender", getRootElement() , Chatbubble1)
				removeEventHandler("onClientRender", getRootElement() , startBlatt)
				addEventHandler("onClientRender", getRootElement(), Chatbubble31)
			elseif(animID == 1) then
				toggClose = false
				showGkCr()
			end
		elseif(animTyp == 2) then
			if(animID == 2) then
				showBsc()
				toggClose = false
				removeEventHandler("onClientRender",getRootElement(), startBlatt)
				removeEventHandler("onClientRender", getRootElement() , Chatbubble1)
				addEventHandler("onClientRender", getRootElement(), Chatbubble32)
			elseif(animID == 1) then
				toggClose = false
				showSBCr()
			end
		end
	end
end -- BdoorClose  Bank TÃ¼r wird geschlossen (Schalter)

function fullClosed()
		local x,y = guiGetScreenSize()
		local bx,by = 398.000, 399.0000
		local ax,ay = ((1280/2 + fx) - bx/2) + 22.5, ((1024/2 + fy) - by/2) + 146.5 
		--dxDrawImage(464.0000,459.0000,398.000,399.0000,"images/Tur.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
		dxDrawImage(ax,ay,bx,by,"images/Tur.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)  
end -- fullClosed

function startBlatt()
	local x,y = guiGetScreenSize()
	local ax,ay = 0.44453125 * x, 0.6806640625 * y
	local bx,by =  0.1234375 * x, 0.1259765625 * y
	--dxDrawImage(569.0,697.0,158.0,129.0,"images/Bank/blattAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	dxDrawImage(ax,ay,bx,by,"images/Bank/blattAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
end -- startBlatt

function endBlatt()
	local x,y = guiGetScreenSize()
	local ax,ay = 0.44453125 * x, 0.794921875 * y
	local bx,by =  0.1234375 * x, 0.1259765625 * y
	--dxDrawImage(569.0,814.0,158.0,129.0,"images/Bank/blattAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	dxDrawImage(ax,ay,bx,by,"images/Bank/blattAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
end -- endBlatt

function moveBlatt()
	local x,y = guiGetScreenSize()
	local ax = 0.44453125 * x
	local bx,by =  0.1234375 * x, 0.1259765625 * y
	if(animID == 1) then
		if(startY < 0.794921875) then
			local sY = startY * y
			dxDrawImage(ax,sY,bx,by,"images/Bank/blattAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
			startY = startY + 0.003034375
		elseif(startY >= 0.794921875) then
			removeEventHandler("onClientRender",getRootElement(), moveBlatt)
			if(animID == 1) then
				addEventHandler("onClientRender",getRootElement(), endBlatt)
			elseif(animID == 2) then
				addEventHandler("onClientRender",getRootElement(), startBlatt)	
			end
			openCloseAnim1()
		end
	elseif(animID == 2) then
		if(startY > 0.6806640625) then
			local sY = startY * y
			dxDrawImage(ax,sY,bx,by,"images/Bank/blattAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
			startY = startY - 0.003034375
		elseif(startY <=0.6806640625) then
			removeEventHandler("onClientRender",getRootElement(), moveBlatt)
			addEventHandler("onClientRender",getRootElement(), startBlatt)
			openCloseAnim1()
		end
	end
end -- moveBlatt

function showGkCr()
	GKCrActive = true
	addEventHandler("onClientRender",getRootElement(),renderGKCr)

	btn_GKcr = guiCreateButton(fx+ (0.6078 * 1280) - 10,fy + (0.7725 * 1024 ) ,0.0641 * 1280,0.0215 * 1024,"Aktzeptieren",false)
	guiSetAlpha(btn_GKcr,0.69999998807907)

	edt_pin = guiCreateEdit(fx + (0.4789 * 1280),fy + (0.5869 * 1024),0.0617*1280,0.0332*1024,"",false)
	guiEditSetMaxLength(edt_pin,4)
	guiSetAlpha(edt_pin,0)
	spielerName = getPlayerName(getLocalPlayer())
	addEventHandler("onClientRender",getRootElement(),renderGKCrLabels)
	
	function forceInteger(element)
		local text = guiGetText(element) -- text aus der editBox auslesen
		local int = string.gsub(text, "[^%d]", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
	end
	addEventHandler("onClientGUIChanged", edt_pin, forceInteger) -- eventhandler bei Ã¤ndern des textes
	
	
	function createSterneGK(element)
		local t = tostring(guiGetText(element))
		local anzahl = #t
		if(anzahl == 1) then
		sterneGK = "*"
		elseif(anzahl == 2) then
		sterneGK = "**"
		elseif(anzahl == 3) then
		sterneGK = "***"
		elseif(anzahl == 4) then
		sterneGK = "****"
		elseif(anzahl == 0) then
		sterneGK = ""
		end
		

	end
	addEventHandler("onClientGUIChanged", edt_pin, createSterneGK)
	
			addEventHandler("onClientGUIClick",btn_GKcr,
			function(button)
				if button == "left" then
				
					if(#guiGetText(edt_pin) ~= 4) then
						return outputChatBox("Dein Pin muss mindestens 4 Zahlen lang sein.")
					end
					
					if(tonumber(guiGetText(edt_pin)) == nil) then
						outputChatBox("Du musst deinen eigenen Pin aussuchen!")
						return 1
					end
					triggerServerEvent("CreateGiro", getLocalPlayer(), getLocalPlayer(), guiGetText(edt_pin))
					
					hideGKCr()
					animID = 2
					openCloseAnim1()
				end
			end
			, false)
	
	
end -- showGKCr

function hideGKCr()
	GKCrActive = false
	removeEventHandler("onClientRender",getRootElement(),renderGKCr)
	destroyElement(btn_GKcr)
	destroyElement(edt_pin)
	removeEventHandler("onClientRender",getRootElement(),renderGKCrLabels)
	
end -- hideGKCr

function renderGKCr()
	local x,y = guiGetScreenSize()
	local bx, by = 434,613.9
	local ax,ay = x/2 - bx/2, y/2 - by/2
	--dxDrawImage(434.0,221.0,434.0,597.0,"images/Bank/GiroCr.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
	dxDrawImage(ax,ay,bx,by,"images/Bank/GiroCr.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
end -- renderGKCr

function renderGKCrLabels()
	local x,y = guiGetScreenSize()

	if(sterneGK == nil) then
		sterneGK = " "
	end
	local ax,ay = fx + (0.475 * 1280) - 10, fy + (0.583984375 * 1024) - 10 
	local bx,by = 0.54140625 * x, 0.6220703125 * y
    --dxDrawText(tostring(sterneGK),608.0,598.0,693.0,637.0,tocolor(0,0,0,255),4.4,"arial","left","top",false,false,true)
	dxDrawText(tostring(sterneGK),ax,ay,bx,by,tocolor(0,0,0,255),4.0,"arial","left","top",false,false,true)    
	local bx,by = 0.6671875 * 1280, 0.7548828125 * 1024 
	local ax,ay = fx + (0.55234375 * 1280), fy + (0.720703125 * 1024)
    dxDrawText(spielerName,ax,ay,bx,by,tocolor(0,0,0,255),0.9,"beckett","left","top",false,false,true)
   
end -- renderGKCrLabels

function showSBCr()
	SBCrActive = true
	addEventHandler("onClientRender",getRootElement(),renderSBCr)

	btn_SBcr = guiCreateButton(fx+ (0.6078 * 1280) - 10,fy + (0.7725 * 1024 ) ,0.0641 * 1280,0.0215 * 1024,"Aktzeptieren",false)
	guiSetAlpha(btn_SBcr,0.69999998807907)
	spielerName = getPlayerName(getLocalPlayer())
	addEventHandler("onClientRender",getRootElement(),renderSBCrLabels)
	
	addEventHandler("onClientGUIClick",btn_SBcr,
		function(button)
			if button == "left" then
				triggerServerEvent("CreateSB", getLocalPlayer(), getLocalPlayer())
			
				hideSBCr()
				animID = 2
				openCloseAnim1()
				end
			end
			, false)
end -- showSBCr

function hideSBCr()
	SBCrActive = false
	removeEventHandler("onClientRender",getRootElement(),renderSBCr)
	destroyElement(btn_SBcr)
	removeEventHandler("onClientRender",getRootElement(),renderSBCrLabels)
end -- hideSBCr

function renderSBCr()
	local x,y = guiGetScreenSize()
	local bx, by = 434,613.9
	local ax,ay = x/2 - bx/2, y/2 - by/2
	--dxDrawImage(434.0,221.0,434.0,597.0,"images/Bank/GiroCr.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
	dxDrawImage(ax,ay,bx,by,"images/Bank/SparCr.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
end -- renderSBCr

function renderSBCrLabels()
	local x,y = guiGetScreenSize()
	local bx,by = 0.6671875 * 1280, 0.7548828125 * 1024 
	local ax,ay = fx + (0.55234375 * 1280), fy + (0.720703125 * 1024)
	--dxDrawText(spielerName,707.0,738.0,854.0,773.0,tocolor(0,0,0,255),0.9,"beckett","left","top",false,false,true)
	dxDrawText(spielerName,ax,ay,bx,by,tocolor(0,0,0,255),0.9,"beckett","left","top",false,false,true)
end -- renderSBCrLabels

--578,678,142,142
-- 578,801,142,142,
function startData()
local bx,by = 142,142
local ax,ay = fx + 578, fy + 678
	if(dataID == 1) then
		dxDrawImage(ax,ay,bx,by,"images/Bank/einzahlenAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	elseif(dataID == 2) then
		dxDrawImage(ax,ay,bx,by,"images/Bank/abbuchenAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	elseif(dataID == 3) then
		dxDrawImage(ax,ay,bx,by,"images/Bank/transAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	elseif(dataID == 4) then
		dxDrawImage(ax,ay,bx,by,"images/Bank/geldAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	end
end -- startData (render)

function endData()
local bx,by = 142,142
local ax,ay = fx + 578, fy + 801
	if(dataID == 1) then
		dxDrawImage(ax,ay,bx,by,"images/Bank/einzahlenAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	elseif(dataID == 2) then
		dxDrawImage(ax,ay,bx,by,"images/Bank/abbuchenAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	elseif(dataID == 3) then
		dxDrawImage(ax,ay,bx,by,"images/Bank/transAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	elseif(dataID == 4) then
		dxDrawImage(ax,ay,bx,by,"images/Bank/geldAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
	end
end -- endData (render)

function moveData()
if(dataID == 1) then
	local bx,by = 142,142
	local ax = fx + 578
	if(animID == 1) then
		if(startY < 801) then
			local sY = startY + fy
			dxDrawImage(ax,sY,bx,by,"images/Bank/einzahlenAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			startY = startY + 3
		elseif(startY >= 801) then
			removeEventHandler("onClientRender",getRootElement(), moveData)
			if(animID == 1) then
				addEventHandler("onClientRender",getRootElement(), endData)
			elseif(animID == 2) then
				addEventHandler("onClientRender",getRootElement(), startData)	
			end
			openCloseAnim2()
		end
	elseif(animID == 2) then
		if(startY > 678) then
			local sY = startY + fy
			dxDrawImage(ax,sY,bx,by,"images/Bank/einzahlenAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			startY = startY - 3
		elseif(startY <= (fy + 678)) then
			removeEventHandler("onClientRender",getRootElement(), moveData)
			addEventHandler("onClientRender",getRootElement(), startData)
			openCloseAnim2()
		end
	end
elseif(dataID == 2) then
	local bx,by = 142,142
	local ax = fx + 578
	if(animID == 1) then
		if(startY < 801) then
			local sY = startY + fy
			dxDrawImage(ax,sY,bx,by,"images/Bank/abbuchenAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			startY = startY + 3
		elseif(startY >= 801) then
			removeEventHandler("onClientRender",getRootElement(), moveData)
			if(animID == 1) then
				addEventHandler("onClientRender",getRootElement(), endData)
			elseif(animID == 2) then
				addEventHandler("onClientRender",getRootElement(), startData)	
			end
			openCloseAnim2()
		end
	elseif(animID == 2) then
		if(startY > 678) then
			local sY = startY + fy
			dxDrawImage(ax,sY,bx,by,"images/Bank/abbuchenAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			startY = startY - 3
		elseif(startY <= (fy + 678)) then
			removeEventHandler("onClientRender",getRootElement(), moveData)
			addEventHandler("onClientRender",getRootElement(), startData)
			openCloseAnim2()
		end
	end
elseif(dataID == 3) then
	local bx,by = 142,142
	local ax = fx + 578
	if(animID == 1) then
		if(startY < 801) then
			local sY = startY + fy
			dxDrawImage(ax,sY,bx,by,"images/Bank/transAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			startY = startY + 3
		elseif(startY >= 801) then
			removeEventHandler("onClientRender",getRootElement(), moveData)
			if(animID == 1) then
				addEventHandler("onClientRender",getRootElement(), endData)
			elseif(animID == 2) then
				addEventHandler("onClientRender",getRootElement(), startData)	
			end
			openCloseAnim2()
		end
	elseif(animID == 2) then
		if(startY > 678) then
			local sY = startY + fy
			dxDrawImage(ax,sY,bx,by,"images/Bank/transAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			startY = startY - 3
		elseif(startY <= (fy + 678)) then
			removeEventHandler("onClientRender",getRootElement(), moveData)
			addEventHandler("onClientRender",getRootElement(), startData)
			openCloseAnim2()
		end
	end	
elseif(dataID == 4) then
	local bx,by = 142,142
	local ax = fx + 578
	if(animID == 1) then
		if(startY < 801) then
			local sY = startY + fy
			dxDrawImage(ax,sY,bx,by,"images/Bank/geldAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			startY = startY + 3
		elseif(startY >= 801) then
			removeEventHandler("onClientRender",getRootElement(), moveData)
			addEventHandler("onClientRender",getRootElement(), endData)
		
			openCloseAnim2()
		end
	elseif(animID == 2) then
		if(startY > 678) then
			local sY = startY + fy
			dxDrawImage(ax,sY,bx,by,"images/Bank/geldAnim.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			startY = startY - 3
		elseif(startY <= (fy + 678)) then
			removeEventHandler("onClientRender",getRootElement(), moveData)
			addEventHandler("onClientRender",getRootElement(), startData)
			openCloseAnim2()
		end
	end
end
end -- moveData (render)


function openCloseAnim2()
	if(bDoorStatus == "close") then
		removeEventHandler("onClientRender",getRootElement(), drawBankSchalter)
		removeEventHandler("onClientRender",getRootElement(), fullClosed)
		toggClose = true
		tx1 = ((1280/2 + fx) - 398.000/2) + 22.5
		if(animID == 1) then
			addEventHandler("onClientRender",getRootElement(), startData)
		elseif(animID ==2) then
			
		end
		addEventHandler("onClientRender",getRootElement(), BdoorOpenAnim2)
		
		bDoorStatus = "open"
	elseif(bDoorStatus == "open") then
		toggClose = true
		removeEventHandler("onClientRender",getRootElement(), fullOpened)
		tx1 = ((1280/2 + fx) - 398.000/2) + 22.5 + 245
		addEventHandler("onClientRender",getRootElement(), BdoorCloseAnim2)
		bDoorStatus = "close"
	end
end -- openCloseAnim2  Die Bankschalter TÃ¼r kann man mit diesem Befehl Ã¶ffnen und schlieÃen (Einzahlen Auszahlen, ...

function BdoorOpenAnim2()
	if(tx1 < ((1280/2 + fx) - 398.000/2) + 22.5 + 245) then
		local x,y = guiGetScreenSize()
		local ax,ay = tx1, ((1024/2 + fy) - 399.0000/2) + 146.5
		local bx,by = 398.000, 399.0000
		dxDrawImage(ax,ay,bx,by,"images/Tur.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
		tx1 = tx1 + 3.8

	else
		removeEventHandler("onClientRender",getRootElement(), BdoorOpenAnim2)
		removeEventHandler("onClientRender",getRootElement(),startData)
		removeEventHandler("onClientRender",getRootElement(),endData)
		addEventHandler("onClientRender", getRootElement(),fullOpened)
		if(animID == 1) then
			startY = 678
		elseif(animID == 2) then
			startY = 801
		end
		addEventHandler("onClientRender", getRootElement(),moveData)
		
	end
end -- BdoorOpen  Bank TÃ¼r wird geÃ¶ffnet (Schalter)  Einzahlen Abbuchen etc.

function BdoorCloseAnim2()
	if(tx1 > ((1280/2 + fx) - 398.000/2) + 22.5) then
		local x,y = guiGetScreenSize()
		local ax,ay = tx1, ((1024/2 + fy) - 399.0000/2) + 146.5
		local bx,by = 398.000, 399.0000
		dxDrawImage(ax,ay,bx,by,"images/Tur.png",0.0,0.0,0.0,tocolor(255,255,255,255),true)
		
		tx1 = tx1  - 3.8
	else
		removeEventHandler("onClientRender",getRootElement(),BdoorCloseAnim2)
		addEventHandler("onClientRender",getRootElement(),fullClosed)
		renderBankMenu()
	end
end -- BdoorClose  Bank TÃ¼r wird geschlossen (Schalter)

function renderBankMenu()
	if(dataID == 1) then
			if(animID == 2) then
				showBsc()
				toggClose = false
				removeEventHandler("onClientRender", getRootElement() , startData)
			elseif(animID == 1) then
				toggClose = false
				showBankEinzahlen()
			end
	elseif(dataID == 2) then
			if(animID == 2) then
				showBsc()
				toggClose = false
				removeEventHandler("onClientRender",getRootElement(), startData)		
			elseif(animID == 1) then
				toggClose = false
				showBankAbbuchen()
			end
	elseif(dataID == 3) then
			if(animID == 2) then
				showBsc()
				toggClose = false
				removeEventHandler("onClientRender",getRootElement(), startData)		
			elseif(animID == 1) then
				toggClose = false
				showBankTransaction()
			end			
	elseif(dataID == 4) then
			if(animID == 2) then
				showBsc()
				toggClose = false
				removeEventHandler("onClientRender",getRootElement(), startData)		
			elseif(animID == 1) then
				showBsc()
				toggClose = false
				removeEventHandler("onClientRender",getRootElement(), endData)	
			end	
		end
end -- renderBankMenu
--guiCreateStaticImage(661,376,,"images/KontoEinzahlen.png",false)
function showBankEinzahlen()
	local time = getRealTime()
	day = time.monthday
	month = time.month + 1
	year = time.year + 1900
	playerName = getPlayerName(getLocalPlayer())
	if(	sparSel == true) then
		kn = getElementData(getLocalPlayer(),"KNS")
	elseif( giroSel == true) then
		kn = getElementData(getLocalPlayer(),"KNG")
	end
	
	local ax,ay = fx + 901,fy + 692
	btn_einzahlen_ok = guiCreateButton(ax,ay,36,22,"OK",false)
	local ax,ay = fx + 766, fy + 441
	edt_einz_bank = guiCreateEdit(ax,ay,130,21,"",false)
	addEventHandler("onClientRender",getRootElement(),renderEinzahlen)
	addEventHandler("onClientRender",getRootElement(),renderEinzahlenL)
	kontoeinzshow = true
	
	function NickLeerzeichenLogin(element)
		local text = guiGetText(element) -- text aus der editBox auslesen
		local int = string.gsub(text, " ", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
		local int = string.gsub(text, "[^%d]", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
	end
	addEventHandler("onClientGUIChanged", edt_einz_bank, NickLeerzeichenLogin)
	
	addEventHandler("onClientGUIClick",btn_einzahlen_ok,
	function(button)
	 	if button == "left" then
	 		if(guiGetText(edt_einz_bank)== 0 or guiGetText(edt_einz_bank) == "") then
	 			outputChatBox("Du kannst nicht 0 $ einzahlen!",137,255,66)
	 			return 1
	 		end
			triggerServerEvent ( "intrace", getLocalPlayer(), guiGetText(edt_einz_bank),sparSel,giroSel ) 
		end
	end 
	, false)
	
end -- showBankEinzahlen

function hideBankEinzahlen()
	if(kontoeinzshow == true) then
		destroyElement(btn_einzahlen_ok)
		destroyElement(edt_einz_bank)
		removeEventHandler("onClientRender",getRootElement(),renderEinzahlen)
		removeEventHandler("onClientRender",getRootElement(),renderEinzahlenL)
		kontoeinzshow = false
	end

end -- hideBankEinzahlen

function renderEinzahlen()
	local bx,by = 605,408.44470046082949308755760368664
	local ax,ay = ((1280/2) + fx) - bx/2, ((1024/2) + fy) - by/2
	dxDrawImage(ax,ay,bx,by,"images/KontoEinzahlen.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
end -- renderEinzahlen

function renderEinzahlenL()
	local bx,by = 925.0,658.0
	local ax,ay = fx + 786.0, fy + 619.0
	dxDrawText(tostring(playerName),ax,ay,bx,by,tocolor(0,0,0,255),1.0,"beckett","left","top",false,false,true)
	local bx,by = 541.0,672.0 
	local ax,ay = fx + 416.0,fy + 630.0
    dxDrawText(tostring(day).."."..tostring(month).."."..tostring(year),ax,ay,bx,by,tocolor(0,0,0,255),1.3,"default-bold","left","top",false,false,true)
   	local bx,by = 475.0,453.0
	local ax,ay = fx + 415.0,fy + 435.0
    dxDrawText(tostring(kn),ax,ay,bx,by,tocolor(0,0,0,255),1.2,"default-bold","left","top",false,false,true)
    local bx,by = 632.0,410.0
	local ax,ay = fx + 458.0,fy + 380.0
    dxDrawText(tostring(playerName),ax,ay,bx,by,tocolor(0,0,0,255),2.0,"default-bold","left","top",false,false,true)
    
end -- renderEinzahlenL

function showBankAbbuchen()
	local time = getRealTime()
	day = time.monthday
	month = time.month + 1
	year = time.year + 1900
	playerName = getPlayerName(getLocalPlayer())
	if(	sparSel == true) then
		kn = getElementData(getLocalPlayer(),"KNS")
	elseif( giroSel == true) then
		kn = getElementData(getLocalPlayer(),"KNG")
	end
	addEventHandler("onClientRender",getRootElement(),renderAbbuchen)
	addEventHandler("onClientRender",getRootElement(),renderAbbuchenL)
	btn_bank_abbuchen = guiCreateButton(fx + 907,fy + 728,28,20,"OK",false)
	edt_abbuchen_geld = guiCreateEdit(fx + 821,fy + 370,94,36,"",false)
	edt_abbuchen_pin = guiCreateEdit(fx + 367,fy + 492,76,31,"",false)
	guiEditSetMaxLength(edt_abbuchen_pin,4)
	guiEditSetMasked(edt_abbuchen_pin,true)
	if(sparSel == true) then
		guiEditSetReadOnly ( edt_abbuchen_pin, true )
	else
		guiEditSetReadOnly ( edt_abbuchen_pin, false )
	end
	kontoabbshow = true
	
	function NickLeerzeichenLogin2(element)
		local text = guiGetText(element) -- text aus der editBox auslesen
		local int = string.gsub(text, " ", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
		local int = string.gsub(text, "[^%d]", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
	
	end
	addEventHandler("onClientGUIChanged", edt_abbuchen_geld, NickLeerzeichenLogin2)
	
	function NickLeerzeichenLogin3(element)
		local text = guiGetText(element) -- text aus der editBox auslesen
		local int = string.gsub(text, " ", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
		local int = string.gsub(text, "[^%d]", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
	end
	addEventHandler("onClientGUIChanged", edt_abbuchen_pin, NickLeerzeichenLogin3)
	
	addEventHandler("onClientGUIClick",btn_bank_abbuchen,
	function(button)
	 	if button == "left" then
	 		if(guiGetText(edt_abbuchen_geld)== 0 or guiGetText(edt_abbuchen_geld)== "") then
	 			outputChatBox("Du kannst nicht 0 $ abbuchen!",137,255,66)
	 			return 1
	 		end
			triggerServerEvent ( "extracte", getLocalPlayer(), guiGetText(edt_abbuchen_geld),guiGetText(edt_abbuchen_pin),sparSel,giroSel ) 
		end
	end 
	, false)
end -- showBankAbbuchen

function hideBankAbbuchen()
	if(kontoabbshow == true) then
		removeEventHandler("onClientRender",getRootElement(),renderAbbuchen)
		removeEventHandler("onClientRender",getRootElement(),renderAbbuchenL)
		destroyElement(btn_bank_abbuchen)
		destroyElement(edt_abbuchen_geld)
		destroyElement(edt_abbuchen_pin)
		kontoabbshow = false
	end
end -- hideBankAbbuchen

function renderAbbuchen()
	local bx,by = 605,479.52443857331571994715984147952
	local ax,ay = ((1280/2) + fx) - bx/2, ((1024/2) + fy) - by/2
	dxDrawImage(ax,ay,bx,by,"images/abbuchen.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
end -- renderAbbuchen

function renderAbbuchenL()
	local ax,ay = fx + 786.0, fy + 653.0
    dxDrawText(tostring(playerName),ax,ay,901.0,698.0,tocolor(0,0,0,255),1.0,"beckett","left","top",false,false,true)
    local ax,ay = fx + 510.0,fy + 488.0
    dxDrawText(tostring(playerName),ax,ay,625.0,533.0,tocolor(0,0,0,255),2.0,"default","left","top",false,false,true)
    local ax,ay = fx + 570.0,fy + 369.0
    dxDrawText(tostring(kn),ax,ay,673.0,404.0,tocolor(0,0,0,255),2.0,"default","left","top",false,false,true)
    local ax,ay = fx + 353.0, fy + 372.0
    dxDrawText(tostring(day).."."..tostring(month).."."..tostring(year),ax,ay,479.0,410.0,tocolor(0,0,0,255),1.8,"default","left","top",false,false,true)
  
end -- renderabbuchenL

function showBankTransaction()

	addEventHandler("onClientRender",getRootElement(),renderTransaction)
	addEventHandler("onClientRender",getRootElement(),renderTransactionL)
	
	edt_trans_kn = guiCreateEdit(fx + 373,fy + 462,134,25,"",false)
	guiEditSetMaxLength(edt_trans_kn,6)
	
	edt_trans_betrag = guiCreateEdit(fx + 723,fy + 525,109,21,"",false)
	
	edt_trans_vz1 = guiCreateEdit(fx + 372,fy + 572,538,22,"",false)
	guiEditSetMaxLength(edt_trans_vz1,60)
	
	edt_trans_vz2 = guiCreateEdit(fx + 372,fy + 596,538,22,"",false)
	guiEditSetMaxLength(edt_trans_vz2,60)
	
	
	edt_trans_ziel = guiCreateEdit(fx + 371,fy + 401,529,25,"",false)
	guiEditSetMaxLength(edt_trans_ziel,16)
	
	btn_trans_ok = guiCreateButton(fx + 908,fy + 707,28,19,"OK",false)
	
	function NickLeerzeichenLogin4(element)
		local text = guiGetText(element) -- text aus der editBox auslesen
		local int = string.gsub(text, " ", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
		local int = string.gsub(text, "[^%d]", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
	end
	addEventHandler("onClientGUIChanged", edt_trans_kn, NickLeerzeichenLogin4)
	
	function NickLeerzeichenLogin5(element)
		local text = guiGetText(element) -- text aus der editBox auslesen
		local int = string.gsub(text, " ", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
		local int = string.gsub(text, "[^%d]", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
	end
	addEventHandler("onClientGUIChanged", edt_trans_betrag, NickLeerzeichenLogin5)
	
	function NickLeerzeichenLogin6(element)
		local text = guiGetText(element) -- text aus der editBox auslesen
		local int = string.gsub(text, " ", "") -- alle nicht numerischen zeichen lÃ¶schen
		if text ~= int then -- falls der int wert vom text abweicht
			guiSetText(element, int) -- den int wert als text der editBox setzen
		end
	end
	addEventHandler("onClientGUIChanged", edt_trans_ziel, NickLeerzeichenLogin6)
	
	showedTransaction = true
	
	addEventHandler("onClientGUIClick",btn_trans_ok,
	function(button)
	 	if button == "left" then
	 		if(guiGetText(edt_trans_betrag)== 0 or guiGetText(edt_trans_betrag)== "") then
	 			outputChatBox("Du kannst nicht 0 $ abbuchen!",137,255,66)
	 			return 1
	 		end
	 		if(guiGetText(edt_trans_kn) == "" or guiGetText(edt_trans_ziel) == "" or guiGetText(edt_trans_vz1) == "") then
	 			outputChatBox("Bitte fülle ALLE Felder aus",137,255,66)
	 			return 1
	 		end
			triggerServerEvent ( "transaction", getLocalPlayer(), guiGetText(edt_trans_betrag),guiGetText(edt_trans_kn),guiGetText(edt_trans_ziel),guiGetText(edt_trans_vz1),guiGetText(edt_trans_vz2) ) 
		end
	end 
	, false)
end -- showBankTransaction

function hideBankTransaction()
	if(showedTransaction == true) then
		removeEventHandler("onClientRender",getRootElement(),renderTransaction)
		removeEventHandler("onClientRender",getRootElement(),renderTransactionL)
		destroyElement(edt_trans_kn)
		destroyElement(edt_trans_vz1)
		destroyElement(edt_trans_vz2)
		destroyElement(edt_trans_betrag)
		destroyElement(edt_trans_ziel)
		destroyElement(btn_trans_ok)
		showedTransaction = false
	end
end -- hideBankTransaction

function renderTransaction()
	local bx,by = 605,437.33256351039260969976905311778
	local ax,ay = ((1280/2) + fx) - bx/2, ((1024/2) + fy) - by/2
	dxDrawImage(ax,ay,bx,by,"images/Bank/transactionW.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
end -- renderTransaction

function renderTransactionL()
	dxDrawText("200090100",fx + 726.0,fy + 464.0,844.0,486.0,tocolor(0,0,0,255),1.0,"default-bold","left","top",false,false,true)
end -- renderTransactionL

function einzahlenEvent()
	hideBankEinzahlen()
	outputChatBox("Betrag wurde erfolgreich eingezahlt",137,255,66)
	animID = 2
	dataID = 4
	openCloseAnim2()
end
addEvent("einzahlenA",true)
addEventHandler("einzahlenA",getRootElement(),einzahlenEvent)

function abbuchenEvenT()
	hideBankAbbuchen()
	removeEventHandler("onClientRender",getRootElement(),endData)
	outputChatBox("Betrag wurde erfolgreich abgebucht",137,255,66)
	animID = 1
	dataID = 4
	openCloseAnim2()
end
addEvent("aevent",true)
addEventHandler("aevent", getRootElement(),abbuchenEvenT)

function transEvent()
	hideBankTransaction()
	outputChatBox("Der Betrag wird überwiesen.",137,255,66)
	animID = 2
	dataID = 4
	openCloseAnim2()
end
addEvent("transA",true)
addEventHandler("transA",getRootElement(),transEvent) 

local function destroyBankMenue()
if(bmstate == 1) then
	if(toggClose == false or toggClose == nil) then
				removeEventHandler("onClientRender",getRootElement(),endBlatt)
				removeEventHandler("onClientRender",getRootElement(),endData)
				hideFrageSparbuch()
				hideFrageGiroKonto()
				hideMenu()
				hideBsc()
				hideKcrSelection()
				hideEditBank()
				hideZugriffSel()
				hideBankEinzahlen()
				hideBankAbbuchen()
				hideBankTransaction()
				if(GKCrActive == true) then
					hideGKCr()
				elseif(SBCrActive == true) then
					hideSBCr()
				end
				if(ktimerB == 1) then
					killTimer(destroyBankMenueTimer)
				end
	else
	destroyBankMenueTimer = setTimer(destroyBankMenue,500,1)
	ktimerB = 1
	end
end
end
addEventHandler("onClientPlayerWasted",getRootElement(),destroyBankMenue)

local function onDamage()
if(bmstate == 1) then
	if(source == getLocalPlayer()) then
		local x,y,z = getElementPosition(getLocalPlayer())
		if(getDistanceBetweenPoints3D (x,y,z,2315.8477, -15.3413, 26.7422) > 1.0 and getDistanceBetweenPoints3D (x,y,z,2315.8477, -7.2092, 26.7422) > 1.0) then
			destroyBankMenue()
		end
	end
end
end
addEventHandler("onClientPlayerDamage",getRootElement(),onDamage)
