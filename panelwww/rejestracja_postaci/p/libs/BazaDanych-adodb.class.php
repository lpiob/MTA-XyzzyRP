<?
require_once("adodb5/adodb.inc.php");

class BazaDanych extends ADONewConnection {
	private $dbhost=DB_HOST;
	private $dbname=DB_NAME;
	private $dbuser=DB_USER;
	private $dbpass=DB_PASS;
	public $sqllink;
	public $result;
	private $last_query;
	function __construct($host=false,$name=false,$user=false,$pass=false) {
		parent::__construct("mysql");
		parent::connect($host,$user,$pass,$name);
	}

/*
	function wynik($zapytanie,$) {
		

	}
	function zapytanie($zapytanie) {
		$this->last_query=$zapytanie;
		$this->result=mysql_query($zapytanie,$this->sqllink);
		return $this->result;
	}
	function lastinsertid() {
		return mysql_insert_id();
	}
	function wierszy() { return @mysql_num_rows($this->result); }
	function pobierz_wyniki($q="") {
		if ($q<>"") $this->zapytanie($q);
		return @mysql_fetch_assoc($this->result);
	}
	function pobierz_tabele_wynikow($q="",$klucz=false) { // pobiera wszystkie wyniki i zwraca jako tablice
		if ($q<>"") $this->zapytanie($q);
		$tablica=Array();
		if($this->wierszy()==0) return $tablica;
		//          while(($tablica[] = mysql_fetch_assoc($this->result)) || array_pop($tablica));

		while ($d=$this->pobierz_wyniki()) 

		if ($klucz!==false) 
			$tablica[$d[$klucz]]=$d;
		else
			$tablica[]=$d;
		
		return $tablica;

	}

	function dbg() {
		print "<pre>\nLQ: ".$this->last_query."\nE: ".mysql_error($this->sqllink)."\n</pre>";
	}
	function e($str){
	    return mysql_real_escape_string($str,$this->sqllink);
	}
	function affected_rows(){
	    return mysql_affected_rows($this->sqllink);
	}
*/

}
?>