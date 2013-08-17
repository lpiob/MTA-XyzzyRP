local VW=17
local I=1
fabryka=createColSphere(-88.59,-258.31,1417.34,100)	-- fabryka
setElementDimension(fabryka,VW)
setElementInterior(fabryka,I)



local muzyka

local function onClientColShapeHit( theElement, matchingDimension )
	if (not matchingDimension) then return end
	 if ( theElement == getLocalPlayer() and getElementInterior(source)==getElementInterior(localPlayer)) then  -- Checks whether the entering element is the local player
		if (source==fabryka) then
			muzyka=playSound("audio/fx-fabryka.ogg",true)

--			setSoundEffectEnabled(muzyka,"echo",true)	-- efekt dzwiekowy
			-- lista efektow pod http://wiki.multitheftauto.com/wiki/SetSoundEffectEnabled

			-- dzwiek 3d
--			muzyka=playSound3D("audio/fx-fabryka.ogg",260,-1799,1479,true)	-- zrodlo dzwieku (x,y,z)
--			setElementDimension(muzyka,VW)
--			setSoundMaxDistance(muzyka,50)	-- maksymalna odleglosc z jakiej slychac

		end
    end
end

local function onClientColShapeLeave( theElement, matchingDimension )
--	if (not matchingDimension) then return end
	 if ( theElement == getLocalPlayer() ) then  -- Checks whether the entering element is the local player
		if (source==fabryka) then
			stopSound(muzyka)
		end
    end
end




addEventHandler("onClientColShapeHit",getResourceRootElement(),onClientColShapeHit)
addEventHandler("onClientColShapeLeave",getResourceRootElement(),onClientColShapeLeave)

