-- watek z linkami do tych kół
-- http://forum.lss-rp.pl/viewtopic.php?f=5&t=6265

local r={
-- 1025,1073,1074,1075,1076,1077,1078,1079,1080,1081,1082,1083,1084,1085,1096,1097,1098
	[1074]="n/wheel_lr4",
	[1075]="n/wheel_lr2",
	[1076]="n/wheel_sr3",
	[1077]="n/wheel_sr2",
	[1078]="n/wheel_gn1",
	[1079]="n/wheel_sr4",
	[1081]="n/wheel_sr5",
	[1082]="n/wheel_lr5",

	[1096]="n/wheel_gn5",
	[1097]="n/wheel_sr1",
}
for i,v in pairs(r) do
	local txd = engineLoadTXD(v..'.txd')
	engineImportTXD(txd, i)
	local dff = engineLoadDFF(v..'.dff', i)
	engineReplaceModel(dff, i)
end

r={
-- 1025,1073,1074,1075,1076,1077,1078,1079,1080,1081,1082,1083,1084,1085,1096,1097,1098
	[1025]="hd/wheel_or1",
	[1073]="hd/wheel_sr6",
	[1080]="hd/wheel_sr5",
	[1083]="hd/wheel_lr2",
	[1084]="hd/wheel_lr5",
	[1085]="hd/wheel_gn2",
	[1098]="hd/wheel_gn5",
}
for i,v in pairs(r) do
	local dff = engineLoadDFF(v..'.dff', i)
	engineReplaceModel(dff, i)
end