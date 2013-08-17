VEH=562
function handlingChange()
--	setModelHandling(VEH, "mass", 11290)
--	setModelHandling(VEH, "turnMass", 30000)
	setModelHandling(VEH, "dragCoeff", 0.7)
--	setModelHandling(VEH, "tractionMultiplier", 1)
	setModelHandling(VEH, "tractionLoss", 1.401)
	setModelHandling(VEH, "centerOfMass", {0.0, 0.1, -0.2} )
	setModelHandling(VEH, "maxVelocity", 180)
	setModelHandling(VEH, "engineAcceleration", 15)
end

addEventHandler("onResourceStart", resourceRoot, handlingChange)
function resetHandling()
	for k,_ in pairs(getModelHandling(VEH)) do
		setModelHandling(VEH, k, nil)
	end
end
addEventHandler("onResourceStop", resourceRoot, resetHandling)