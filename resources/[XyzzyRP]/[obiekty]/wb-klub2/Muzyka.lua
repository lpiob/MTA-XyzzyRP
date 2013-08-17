local VW=29
klub2=createColSphere(1040.73,-1397.77,1438.41,200)	-- klub2
setElementDimension(klub2,VW)



local muzyka

local function onClientColShapeHit( theElement, matchingDimension )
	if (not matchingDimension) then return end
	 if ( theElement == getLocalPlayer() ) then  -- Checks whether the entering element is the local player
		if (source==klub2) then
			muzyka=playSound("audio/Muzyka.ogg",true)

--			setSoundEffectEnabled(muzyka,"echo",true)	-- efekt dzwiekowy
			-- lista efektow pod http://wiki.multitheftauto.com/wiki/SetSoundEffectEnabled

			-- dzwiek 3d
--			muzyka=playSound3D("audio/fx-klub2.ogg",260,-1799,1479,true)	-- zrodlo dzwieku (x,y,z)
--			setElementDimension(muzyka,VW)
--			setSoundMaxDistance(muzyka,50)	-- maksymalna odleglosc z jakiej slychac

		end
    end
end

local function onClientColShapeLeave( theElement, matchingDimension )
--	if (not matchingDimension) then return end
	 if ( theElement == getLocalPlayer() ) then  -- Checks whether the entering element is the local player
		if (source==klub2) then
			stopSound(muzyka)
		end
    end
end




addEventHandler("onClientColShapeHit",getResourceRootElement(),onClientColShapeHit)
addEventHandler("onClientColShapeLeave",getResourceRootElement(),onClientColShapeLeave)

