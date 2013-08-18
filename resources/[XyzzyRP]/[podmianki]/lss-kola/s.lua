local o={1025,1073,1074,1075,1076,1077,1078,1079,1080,1081,1082,1083,1084,1085,1096,1097,1098}


for i,v in ipairs(o) do
	local o=createObject(v,0,0+(i)%5*1.1,2.7+(math.floor(i/5)%5)*1.1)
	setElementInterior(o, 7)
	setElementDimension(o,7)
	
end