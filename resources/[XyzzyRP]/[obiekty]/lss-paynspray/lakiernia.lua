addEvent("onCarPainting", true)
addEventHandler("onCarPainting", root, function(cr,cg,cb,ktora)
	if (getElementType(source)~="vehicle") then return end
	local r,g,b,r2,g2,b2=getVehicleColor(source,true)
	if (ktora==1) then
		if (r<cr) then			r=r+1		elseif (r>cr) then			r=r-1		end
		if (g<cg) then			g=g+1		elseif (g>cg) then			g=g-1		end
		if (b<cb) then			b=b+1		elseif (b>cb) then			b=b-1		end
	elseif (ktora==2) then
		if (r2<cr) then			r2=r2+1		elseif (r2>cr) then			r2=r2-1		end
		if (g2<cg) then			g2=g2+1		elseif (g2>cg) then			g2=g2-1		end
		if (b2<cb) then			b2=b2+1		elseif (b2>cb) then			b2=b2-1		end

	end
--	r=(r*127+cr)/128

	setVehicleColor(source, r,g,b, r2,g2,b2)
--	outputDebugString("r: " .. r)
end)