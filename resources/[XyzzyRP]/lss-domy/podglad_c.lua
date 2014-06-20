--[[
Domy do wynajecia - podglad domow na mapie

@author Lukasz Biegaj <wielebny@bestplay.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--



bindKey( 'i', 'both', function( key, keyState )
	if keyState == 'down' then
		for k, v in ipairs ( getElementsByType( 'colshape', resourceRoot ) ) do
			local dom=getElementData(v,"dom")
			if (dom and dom.ownerid) then
				createBlipAttachedTo( v, 32, 2, 255,0,0,255,100,500 );
			else
				createBlipAttachedTo( v, 31, 2, 255,0,0,255,100,500 );
			end
		end
	else
		for k, v in ipairs( getElementsByType( 'blip', getResourceRootElement() ) ) do
			destroyElement(v)
		end
	end

end)
