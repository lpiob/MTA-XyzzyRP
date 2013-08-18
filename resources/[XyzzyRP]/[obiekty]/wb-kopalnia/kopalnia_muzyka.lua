local VW=19
local I=1
kopalnia=createColSphere(1252,-200,1374,1000)	-- kopalnia
setElementDimension(kopalnia,VW)
setElementInterior(kopalnia,I)



local muzyka

local function onClientColShapeHit( theElement, matchingDimension )
	if (not matchingDimension) then return end
	 if ( theElement == getLocalPlayer() and getElementInterior(source)==getElementInterior(localPlayer)) then  -- Checks whether the entering element is the local player
		if (source==kopalnia) then
			muzyka=playSound("audio/fx-kopalnia.ogg",true)

--			setSoundEffectEnabled(muzyka,"echo",true)	-- efekt dzwiekowy
			-- lista efektow pod http://wiki.multitheftauto.com/wiki/SetSoundEffectEnabled

			-- dzwiek 3d
--			muzyka=playSound3D("audio/fx-kopalnia.ogg",260,-1799,1479,true)	-- zrodlo dzwieku (x,y,z)
--			setElementDimension(muzyka,VW)
--			setSoundMaxDistance(muzyka,50)	-- maksymalna odleglosc z jakiej slychac

		end
    end
end

local function onClientColShapeLeave( theElement, matchingDimension )
--	if (not matchingDimension) then return end
	 if ( theElement == getLocalPlayer() ) then  -- Checks whether the entering element is the local player
		if (source==kopalnia) then
			stopSound(muzyka)
		end
    end
end




addEventHandler("onClientColShapeHit",getResourceRootElement(),onClientColShapeHit)
addEventHandler("onClientColShapeLeave",getResourceRootElement(),onClientColShapeLeave)

