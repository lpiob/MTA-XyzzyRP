--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



magazyny={

-- fabryka
--[[
	fabryka={
		container_id=1728,	-- id z lss_containers
		panel_loc={-62.09,-245.79,1419.61,17,1} -- x,y,z,d,i - polozenie panelu
	}
]]--

	blueberry={
		nazwa="Magazyn w Blueberry",
		item_container_id=1741,	-- pojemnik, w ktorym beda skladowane przedmioty
		money_container_id=1740, -- pojemnik w ktorym jest skladowana gotowka
		panel_loc={ -- polozenie panelu w ktorym mozna zarzadzac magazynem, x,y,z,d,i,opcjonalnie kat
					-- jesli kat zostanie podany, to w miejscu zostanie utworzony obiekt komputer-atm
			605.08,-21.97,999.90,1040,1
		},
		loading_bays={	-- punkty zaladunku, dowolna ilosc, x,y,z,r
				{293.91,-221.49,0.58,6}
			}
	},
	tartakpanopticon={
		nazwa="Magazyn przy tartaku",
		item_container_id=2462,
		money_container_id=2463,
		panel_loc={ -585.20,-69.24,64.07,0,0,180 },
		loading_bays={
			{-597.52,-60.86,62.64,6},
			{-597.46,-166.30,68.20,6},
			{-479.70,-6.65,54.01,6},
			{-428.83,-164.58,71.63,6},

		},
	},

}

for i,v in pairs(magazyny) do

	if v.panel_loc then
		v.marker_panel=createMarker(v.panel_loc[1], v.panel_loc[2], v.panel_loc[3], "cylinder", 1, 0,0,0,200)
		setElementInterior(v.marker_panel, v.panel_loc[5])
		setElementDimension(v.marker_panel, v.panel_loc[4])
		setElementData(v.marker_panel,"typ","zarzadzanie")
		setElementData(v.marker_panel,"magazyn",i)
		if v.panel_loc[6] then	-- podano kat, tworzymy komputer-atm-terminal
			v.obiekt=createObject(2618,v.panel_loc[1],v.panel_loc[2],v.panel_loc[3],0,0,v[6])
			setElementInterior(v.obiekt, v.panel_loc[5])
			setElementDimension(v.obiekt, v.panel_loc[4])


		end
	end

	if v.item_container_id and v.loading_bays then
		for ii,vv in ipairs(v.loading_bays) do
			vv.marker=createMarker(vv[1],vv[2],vv[3],"cylinder",vv[4], 0,0,0,200)
			setElementData(vv.marker,"typ","ladowanie")
		end
	end
end