--[[
Obsluga baz danych, interfejs do bazy MySQL realizowany za pomoca wbudowanych w MTA funkcji db...

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

local SQL

local function connect()
    -- w ponizszej linii uzupelnij dane autoryzacji
	SQL = dbConnect("mysql", "dbname=x;host=y", "nazwa_uzytkownika","haslo","share=1")
	if (not SQL) then
		outputServerLog("BRAK POLACZENIA Z BAZA DANYCH!")
	else
		zapytanie("SET NAMES utf8;")
	end

end

addEventHandler("onResourceStart",resourceRoot, connect)

function pobierzTabeleWynikow(...)
	local h=dbQuery(SQL,...)
	if (not h) then 
		return nil
	end
	local rows = dbPoll(h, -1)
	return rows
end

function pobierzWyniki(...)
	local h=dbQuery(SQL,...)
	if (not h) then 
		return nil
	end
	local rows = dbPoll(h, -1)
	if not rows then return nil end
	return rows[1]
end

function zapytanie(...)
	local h=dbQuery(SQL,...)
	local result,numrows=dbPoll(h,-1)
	return numrows
end

--[[
function insertID()
	return mysql_insert_id(SQL)
end

function affectedRows()
	return mysql_affected_rows(SQL)
end
]]--

function fetchRows(query)
	local result=mysql_query(SQL,query)
	if (not result) then return nil end
	local tabela={}

	while true do
    	local row = mysql_fetch_row(result)
	    if (not row) then break end
	    table.insert(tabela,row)
	end
	mysql_free_result(result)
	return tabela
end


