--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--



-- local f3w={}

-- f3w.win = guiCreateWindow(0.6275,0.3333,0.1863,0.4033,"Opcje grafiki",true)
-- f3w.label1 = guiCreateLabel(0.0604,0.1157,0.6443,0.0992,"Shader bloom:",true,f3w.win)

-- f3w.cmb_sb=guiCreateComboBox(0.0872,0.199,0.7987,0.3785, "-wybierz-", true, f3w.win)
-- guiComboBoxAddItem ( f3w.cmb_sb, "wyłączony" )
-- guiComboBoxAddItem ( f3w.cmb_sb, "włączony" )

-- f3w.label2 = guiCreateLabel(0.0604,0.1157+0.2,0.6443,0.0992,"Shader wody:",true,f3w.win)
-- f3w.cmb_sw=guiCreateComboBox(0.0872,0.199+0.2,0.7987,0.3785, "-wybierz-", true, f3w.win)
-- guiComboBoxAddItem ( f3w.cmb_sw, "wyłączony" )
-- guiComboBoxAddItem ( f3w.cmb_sw, "włączony" )


-- f3w.label3 = guiCreateLabel(0.0604,0.1157+0.4,0.6443,0.0992,"Shader karoserii:",true,f3w.win)
-- f3w.cmb_cp=guiCreateComboBox(0.0872,0.199+0.4,0.7987,0.3785, "-wybierz-", true, f3w.win)
-- guiComboBoxAddItem ( f3w.cmb_cp, "wyłączony" )
-- guiComboBoxAddItem ( f3w.cmb_cp, "włączony" )




-- f3w.btn = guiCreateButton(0.0604,0.6917,0.8658,0.2553,"Zamknij",true,f3w.win)

-- guiSetVisible(f3w.win, false)

-- function toggleWin()
	-- local uo_sb=getElementData(localPlayer, "uo_sb")
	-- uo_sb = uo_sb and 1 or 0
	-- guiComboBoxSetSelected(f3w.cmb_sb, uo_sb)

	-- local uo_sw=getElementData(localPlayer, "uo_sw")
	-- uo_sw = uo_sw and 1 or 0
	-- guiComboBoxSetSelected(f3w.cmb_sw, uo_sw)

	-- local uo_cp=getElementData(localPlayer, "uo_cp")
	-- uo_cp = uo_cp and 1 or 0
	-- guiComboBoxSetSelected(f3w.cmb_cp, uo_cp)




	-- if (guiGetVisible(f3w.win)) then
		-- showCursor(false)
		-- guiSetVisible(f3w.win,false)
	-- else
		-- showCursor(true)
		-- guiSetVisible(f3w.win,true)
	-- end
-- end

-- bindKey("F3","down",toggleWin)


-- local function changeUOSB()

  -- local uo_sb=guiComboBoxGetSelected(f3w.cmb_sb)>=1 and true or false
  -- setElementData(localPlayer,"uo_sb", uo_sb)
  -- local uo_sw=guiComboBoxGetSelected(f3w.cmb_sw)>=1 and true or false
  -- setElementData(localPlayer,"uo_sw", uo_sw)

  -- local uo_cp=guiComboBoxGetSelected(f3w.cmb_cp)>=1 and true or false
  -- setElementData(localPlayer,"uo_cp", uo_cp)

-- end

-- local function saveOptions()
  -- local uo_sb=guiComboBoxGetSelected(f3w.cmb_sb)>=1 and true or false
  -- local uo_sw=guiComboBoxGetSelected(f3w.cmb_sw)>=1 and true or false
  -- local uo_cp=guiComboBoxGetSelected(f3w.cmb_sw)>=1 and true or false
  -- triggerServerEvent("saveGraphicOptions", resourceRoot, localPlayer, uo_sb, uo_sw, uo_cp)
  -- guiSetVisible(f3w.win, false)
  -- showCursor(false)
-- end

-- addEventHandler("onClientGUIComboBoxAccepted", f3w.win, changeUOSB)
-- addEventHandler("onClientGUIClick", f3w.btn, saveOptions, false)


shaderpanel = {
    checkbox = {},
    staticimage = {},
    scrollpane = {},
    label = {}
}
shaderpanel.staticimage[1] = guiCreateStaticImage(0.69, 0.35, 0.27, 0.20, "karer_bar.png", true)

shaderpanel.label[1] = guiCreateLabel(0.05, 0.03, 0.85, 0.19, "Panel shaderów", true, shaderpanel.staticimage[1])
local font_0 = guiCreateFont(":lss-gui/droid-sans.ttf", 13)
guiSetFont(shaderpanel.label[1], font_0)
guiLabelSetColor(shaderpanel.label[1], 0, 0, 0)
guiLabelSetHorizontalAlign(shaderpanel.label[1], "center", false)
guiLabelSetVerticalAlign(shaderpanel.label[1], "center")

shaderpanel.staticimage[2] = guiCreateStaticImage(0.030, 0.29, 0.3, 0.16, "name_highlight.png", true, shaderpanel.staticimage[1])    
shaderpanel.checkbox[1] = guiCreateCheckBox(0.06, 0.3, 0.3, 0.1, "Bloom", false, true, shaderpanel.staticimage[1])

shaderpanel.staticimage[3] = guiCreateStaticImage(0.030, 0.44, 0.3, 0.16, "name_highlight.png", true, shaderpanel.staticimage[1])    
shaderpanel.checkbox[2] = guiCreateCheckBox(0.06, 0.45, 0.3, 0.1, "Woda", false, true, shaderpanel.staticimage[1])

shaderpanel.staticimage[4] = guiCreateStaticImage(0.030, 0.59, 0.3, 0.16, "name_highlight.png", true, shaderpanel.staticimage[1])    
shaderpanel.checkbox[3] = guiCreateCheckBox(0.06, 0.6, 0.3, 0.1, "Karoseria", false, true, shaderpanel.staticimage[1])



shaderpanel.staticimage[5] = guiCreateStaticImage(0.330, 0.29, 0.3, 0.16, "name_highlight.png", true, shaderpanel.staticimage[1])    
shaderpanel.checkbox[4] = guiCreateCheckBox(0.36, 0.3, 0.3, 0.1, "Detale", false, true, shaderpanel.staticimage[1])

shaderpanel.staticimage[6] = guiCreateStaticImage(0.330, 0.44, 0.3, 0.16, "name_highlight.png", true, shaderpanel.staticimage[1])    
shaderpanel.checkbox[5] = guiCreateCheckBox(0.36, 0.45, 0.3, 0.1, "Czarno-biały", false, true, shaderpanel.staticimage[1])

shaderpanel.staticimage[7] = guiCreateStaticImage(0.330, 0.59, 0.3, 0.16, "name_highlight.png", true, shaderpanel.staticimage[1])    
shaderpanel.checkbox[6] = guiCreateCheckBox(0.36, 0.6, 0.3, 0.1, "HDR", false, true, shaderpanel.staticimage[1])

shaderpanel.staticimage[8] = guiCreateStaticImage(0.630, 0.29, 0.3, 0.16, "name_highlight.png", true, shaderpanel.staticimage[1])    
shaderpanel.checkbox[7] = guiCreateCheckBox(0.66, 0.3, 0.3, 0.1, "Noc+", false, true, shaderpanel.staticimage[1])

guiSetVisible(shaderpanel.staticimage[1], false)
guiBringToFront(shaderpanel.checkbox[1])
guiBringToFront(shaderpanel.checkbox[2])
guiBringToFront(shaderpanel.checkbox[3])
guiBringToFront(shaderpanel.checkbox[4])
guiBringToFront(shaderpanel.checkbox[5])
guiBringToFront(shaderpanel.checkbox[6])
guiBringToFront(shaderpanel.checkbox[7])

function toggleWin()
	local uo_sb=getElementData(localPlayer, "uo_sb")
	uo_sb = uo_sb and true or false
	guiCheckBoxSetSelected(shaderpanel.checkbox[1], uo_sb)

	local uo_sw=getElementData(localPlayer, "uo_sw")
	uo_sw = uo_sw and true or false
	guiCheckBoxSetSelected(shaderpanel.checkbox[2], uo_sw)

	local uo_cp=getElementData(localPlayer, "uo_cp")
	uo_cp = uo_cp and true or false
	guiCheckBoxSetSelected(shaderpanel.checkbox[3], uo_cp)

	local uo_det=getElementData(localPlayer, "uo_det")
	uo_det = uo_det and true or false
	guiCheckBoxSetSelected(shaderpanel.checkbox[4], uo_det)

	local uo_bw=getElementData(localPlayer, "uo_bw")
	uo_bw = uo_bw and true or false
	guiCheckBoxSetSelected(shaderpanel.checkbox[5], uo_bw)
	
	local uo_hdr=getElementData(localPlayer, "uo_hdr")
	uo_hdr = uo_hdr and true or false
	guiCheckBoxSetSelected(shaderpanel.checkbox[6], uo_hdr)
	
	local uo_nig=getElementData(localPlayer, "uo_nig")
	uo_nig = uo_nig and true or false
	guiCheckBoxSetSelected(shaderpanel.checkbox[7], uo_nig)
	
	if (guiGetVisible(shaderpanel.staticimage[1])) then
		showCursor(false)
		guiSetVisible(shaderpanel.staticimage[1],false)
	else
		showCursor(true)
		guiSetVisible(shaderpanel.staticimage[1],true)
	end
end

bindKey("F3","down",toggleWin)

addEventHandler("onClientGUIClick", resourceRoot, function(btn,state)
	if btn == "left" then
		-- if state == "up" then
			
			if (getElementType(source)~="gui-checkbox") then 
				guiBringToFront(shaderpanel.checkbox[1])
				guiBringToFront(shaderpanel.checkbox[2])
				guiBringToFront(shaderpanel.checkbox[3])
				guiBringToFront(shaderpanel.checkbox[4])
				guiBringToFront(shaderpanel.checkbox[5])
				guiBringToFront(shaderpanel.checkbox[6])
				guiBringToFront(shaderpanel.checkbox[7])
				return 
			end
			local uo_sb=guiCheckBoxGetSelected(shaderpanel.checkbox[1])
			local uo_sw=guiCheckBoxGetSelected(shaderpanel.checkbox[2])
			local uo_cp=guiCheckBoxGetSelected(shaderpanel.checkbox[3])
			local uo_det=guiCheckBoxGetSelected(shaderpanel.checkbox[4])
			local uo_bw=guiCheckBoxGetSelected(shaderpanel.checkbox[5])
			local uo_hdr=guiCheckBoxGetSelected(shaderpanel.checkbox[6])
			local uo_nig=guiCheckBoxGetSelected(shaderpanel.checkbox[7])
			setElementData(localPlayer,"uo_sb", uo_sb)
			setElementData(localPlayer,"uo_sw", uo_sw)
			setElementData(localPlayer,"uo_cp", uo_cp)
			setElementData(localPlayer,"uo_det", uo_det)
			setElementData(localPlayer,"uo_bw", uo_bw)
			setElementData(localPlayer,"uo_hdr", uo_hdr)
			setElementData(localPlayer,"uo_nig", uo_nig)
			triggerServerEvent("saveGraphicOptions", resourceRoot, localPlayer, uo_sb, uo_sw, uo_cp, uo_det, uo_bw,uo_hdr,uo_nig)
		-- end
	end
end)