--[[
Obsluga baz danych, interfejs do bazy MySQL realizowany za pomoca modułu mta_mysql

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--

local SQL_LOGIN="z"
local SQL_PASSWD="x"
local SQL_DB="y"
local SQL_HOST="tiger.og-servers.net"
local SQL_PORT=tonumber(get("port") or 3306)

local root = getRootElement()

local SQL

local function connect()
	SQL = mysql_connect(SQL_HOST, SQL_LOGIN, SQL_PASSWD, SQL_DB, SQL_PORT)
	if (not SQL) then
		outputServerLog("BRAK POLACZENIA Z BAZA DANYCH!")
	else
		mysql_query(SQL,"SET NAMES utf8")
	end

end


local function keepAlive()
	if (not mysql_ping(SQL)) then
		outputServerLog("Zerwane polaczenie z baza danych, nawiazywanie...")
		connect()
	end
end

addEventHandler("onResourceStart",getResourceRootElement(),function()
	connect()
	setTimer(keepAlive, 30000, 0)
end)

function esc(value)
	return mysql_escape_string(SQL,value)
end

function pobierzTabeleWynikow(query)
	local result=mysql_query(SQL,query)
	if (not result) then 
		outputDebugString("mysql_query failed: (" .. mysql_errno(SQL) .. ") " .. mysql_error(SQL)) -- Show the reason
		return nil 
	end
	local tabela={}
	for result,row in mysql_rows_assoc(result) do
		table.insert(tabela,row)
	end
	mysql_free_result(result)
	return tabela
end

function pobierzWyniki(query)
	local result=mysql_query(SQL,query)
	if (not result) then return nil end
	row = mysql_fetch_assoc(result)
	mysql_free_result(result)
	return row
end


function zapytanie(query)
	local result=mysql_query(SQL,query)
	if (result) then mysql_free_result(result) end
	return
end

function insertID()
	return mysql_insert_id(SQL)
end

function affectedRows()
	return mysql_affected_rows(SQL)
end


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


function getSQLLink()
	return SQL
end

