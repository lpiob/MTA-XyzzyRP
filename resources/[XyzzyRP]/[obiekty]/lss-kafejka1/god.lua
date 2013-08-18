setTimer(function()
  for i,v in ipairs(getElementsByType("object", resourceRoot)) do
    setObjectBreakable(v,false)
    setElementFrozen(v,true)
--    setObjectMass(v,getObjectMass(v)+91000)
  end
end, 10000, 1)