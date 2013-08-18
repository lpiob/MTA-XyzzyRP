--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



albumyMuzyczne={
[1]={
	"audio/gto_-_rap.mod",
	"audio/gorappo.xm",
	"audio/4852__zajo__loop02.ogg",
},
[2]={
	"audio/24039__bebeto__loop022.ogg",
	"audio/xtd-ucieczka_z_tropiku.mod",
	"audio/18979__bebeto__loop008-acid.ogg",
},
[3]={
	"audio/18978__bebeto__loop007-ambient.ogg",
	"audio/1281__plagasul__arpeggio6lop.ogg",
},
[4]={
	"audio/4-1.mp3",
	"audio/4-2.mp3",
	"audio/4-3.mp3",
	"audio/4-4.mp3",
	"audio/4-5.mp3",
},
[5]={
	"audio/szalona.ogg",
	"audio/mona_lisa.ogg",
	"audio/jolka.ogg",
	"audio/wino.ogg",
	"audio/zielonym.ogg",
	"audio/full.ogg",
},
[6]={
	"audio/alg.ogg",
	"audio/orle.ogg",
	"audio/poncz.ogg",
	"audio/layla.ogg",
},
[7]={
	"audio/umowilem.ogg",
	"audio/ghost.ogg",
	"audio/trzej.ogg",
	"audio/presley.ogg",
},
[8]={
	"audio/8-1.ogg",
	"audio/8-2.ogg",
	"audio/8-3.ogg",
	"audio/8-4.ogg",
	"audio/8-5.ogg",
},
[9]={
	"audio/9-1.ogg",
	"audio/9-2.ogg",
	"audio/9-3.ogg",
	"audio/9-4.ogg",
	"audio/9-5.ogg",
	"audio/9-6.ogg",
},
[10]={
	"audio/10-1.ogg",
	"audio/10-2.ogg",
	"audio/10-3.ogg",
	"audio/10-4.ogg",
	"audio/10-5.ogg",
},
[11]={
	"audio/11-1.ogg",
	"audio/11-2.ogg",
	"audio/11-3.ogg",
	"audio/11-4.ogg",
	"audio/11-5.ogg",
},
[12]={
	"audio/champions.ogg",
	"audio/rock.ogg",
	"audio/thisworld.ogg",
},
[13]={
	"audio/13-1.ogg",
	"audio/13-2.ogg",
	"audio/13-3.ogg",
	"audio/13-4.ogg",
	"audio/13-5.ogg",
},
[14]={
	"audio/14-1.ogg",
	"audio/14-2.ogg",
	"audio/14-3.ogg",
	"audio/14-4.ogg",
},
[15]={
	"audio/15-1.ogg",
	"audio/15-2.ogg",
	"audio/15-3.ogg",
	"audio/15-4.ogg",
	"audio/15-5.ogg",
},
[16]={
	"audio/16-1.ogg",
	"audio/16-2.ogg",
	"audio/16-3.ogg",
	"audio/16-4.ogg",
},

}

local modeleBezRadia={
-- misc
	[594]=true, -- rc cam
-- trailers
	[606]=true,
	[607]=true,
	[610]=true,
	[611]=true,
	[584]=true,
	[608]=true,
	[435]=true,
	[450]=true,
	[591]=true,
--  recreational
	[539]=true,	-- vortex
	[471]=true,	-- quad
	[557]=true,	-- monster
	[444]=true,
	[556]=true,	-- j.w.
	[571]=true,	-- kart
	[530]=true, --widlak na tartaku
-- rc
	[441]=true,
	[464]=true,
	[501]=true,
	[465]=true,
	[564]=true,
-- trains
	[449]=true,
	[537]=true,
	[538]=true,
	[570]=true,
	[569]=true,
	[590]=true,
-- heavy and utility
	[524]=true,
	[532]=true,
	[486]=true,
	[406]=true,
	[455]=true,
	[403]=true,
	[514]=true,
	[515]=true,
	[531]=true,
-- bikes
	[581]=true,
	[510]=true,
	[522]=true,
	[509]=true,
	[481]=true,
	[462]=true,
	[521]=true,
	[463]=true,
	[586]=true,
	[468]=true,
	[461]=true,
-- samoloty
	[592]=true,
	[577]=true,
	[511]=true,
	[548]=true,
	[512]=true,
	[593]=true,
	[425]=true,
	[520]=true,
	[417]=true,
	[487]=true,
	[553]=true,
	[488]=true,
	[497]=true,
	[563]=true,
	[476]=true,
	[447]=true,
	[519]=true,
	[460]=true,
	[469]=true,
	[513]=true
}   


function pojazdMaRadio(veh)
	local model=getElementModel(veh)
	if modeleBezRadia[model] then return false end
	return true
end