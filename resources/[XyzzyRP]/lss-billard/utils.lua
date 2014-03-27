--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--


rodzajeBil={
	[2995]={mianownik="Jedynka połówka", biernik="jedynkę połówkę"},
	[2996]={mianownik="Dwójka połówka",biernik="dwójkę połówkę"},
	[2997]={mianownik="Trójka połówka",biernik="trójkę połówkę"},
	[2998]={mianownik="Czwórka połówka",biernik="czwórkę połówkę"},
	[2999]={mianownik="Piątka połówka",biernik="piątkę połówkę"},
	[3000]={mianownik="Szóstka połówka",biernik="szóstkę połówkę"},
	[3001]={mianownik="Siódemka połówka",biernik="siodemkę połówkę"},

	[3002]={mianownik="Jedynka cała", biernik="jedynkę całą"},

	[3003]={mianownik="Biała bila",biernik="białą bilę"},

	[3100]={mianownik="Dwójka cała",biernik="dwójkę całą"},
	[3101]={mianownik="Trójka cała",biernik="trójkę całą"},
	[3102]={mianownik="Czwórka cała",biernik="czwórkę całą"},
	[3103]={mianownik="Piątka cała",biernik="piątkę całą"},
	[3104]={mianownik="Szóstka cała",biernik="szóstkę całą"},
	[3105]={mianownik="Siódemka cała",biernik="siodemkę całą"},
	[3106]={mianownik="Czarna bila (ósemka cała)",biernik="czarną bilę (ósemkę całą)"},
}


function shuffle(t)
  local n = #t
 
  while n >= 2 do
    -- n is now the last pertinent index
    local k = math.random(n) -- 1 <= k <= n
    -- Quick swap
    t[n], t[k] = t[k], t[n]
    n = n - 1
  end
 
  return t
end

function findRotation(startX, startY, targetX, targetY)	-- Doomed-Space-Marine
	local t = -math.deg(math.atan2(targetX - startX, targetY - startY))
	
	if t < 0 then
		t = t + 360
	end
	
	return t
end
