<?php
/**
* LSS auth plug-in for phpBB3
*
* @author Łukasz Biegaj <wielebny@lss-rp.pl>
*/

// uwaga, ponizszy kod jest stary i brzydki

class BazaDanych {
    private $dbhost="adres_serwera_baz_danych";    // ugly
    private $dbname="nazwa_bazy_danych";
    private $dbuser="uzytkownik";
    private $dbpass="haslo";


    public $sqllink;
    public $result;
    private $last_query;
    function __construct($host=false,$name=false,$user=false,$pass=false) {
        setlocale(LC_ALL,'pl_PL');
        $this->sqllink=mysql_connect(
                $host?$host:$this->dbhost,
                $user?$user:$this->dbuser,
                $pass?$pass:$this->dbpass);
        mysql_select_db($name?$name:$this->dbname,$this->sqllink);
        mysql_query("SET NAMES utf8;",$this->sqllink);

    }
    function wynik($zapytanie) {
        $this->last_query=$zapytanie;
        return @mysql_result(mysql_query($zapytanie,$this->sqllink),0);

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

}





/**
* @ignore
*/
if (!defined('IN_PHPBB'))
{
    exit;
}


/**
* Login function
*/
function login_lss(&$username, &$password)
{
    global $db;

    // do not allow empty password
    if (!$password)
    {
        return array(
            'status'    => LOGIN_ERROR_PASSWORD,
            'error_msg'    => 'NO_PASSWORD_SUPPLIED',
            'user_row'    => array('user_id' => ANONYMOUS),
        );
    }

    if (!$username)
    {
        return array(
            'status'    => LOGIN_ERROR_USERNAME,
            'error_msg'    => 'LOGIN_ERROR_USERNAME',
            'user_row'    => array('user_id' => ANONYMOUS),
        );
    }

    if (true)
    {
        $username_clean=utf8_clean_string($username);
        $rdb=new BazaDanych();
        $r_login=$rdb->e($username_clean);
        $r_hash=md5(strtolower($username_clean)."MRFX_01".$password);
        $auth=$rdb->wynik("SELECT 1 FROM lss_users WHERE login='$r_login' AND hash='$r_hash';");

        if (intval($auth['id'])!=1) {
//            print_r($auth); exit;
            return array(
                'status'    => LOGIN_ERROR_USERNAME,
                'error_msg'    => 'LOGIN_ERROR_USERNAME',
                'user_row'    => array('user_id' => ANONYMOUS),
            );
        }

        $sql = 'SELECT user_id, username, user_password, user_passchg, user_email, user_type
            FROM ' . USERS_TABLE . "
            WHERE username_clean = '" . $db->sql_escape($username_clean) . "'";

        $result = $db->sql_query($sql);
        $row = $db->sql_fetchrow($result);
        $db->sql_freeresult($result);

        if ($row)
        {
            // User inactive...
            if ($row['user_type'] == USER_INACTIVE || $row['user_type'] == USER_IGNORE)
            {
                return array(
                    'status'        => LOGIN_ERROR_ACTIVE,
                    'error_msg'        => 'ACTIVE_ERROR',
                    'user_row'        => $row,
                );
            }

            // Successful login...
            return array(
                'status'        => LOGIN_SUCCESS,
                'error_msg'        => false,
                'user_row'        => $row,
            );
        }

        // this is the user's first login so create an empty profile
        return array(
            'status'        => LOGIN_SUCCESS_CREATE_PROFILE,
            'error_msg'        => false,
            'user_row'        => user_row_lss($username,$password),
        );
    }

    // Not logged into apache
    return array(
        'status'        => LOGIN_ERROR_EXTERNAL_AUTH,
        'error_msg'        => 'LOGIN_ERROR_EXTERNAL_AUTH_APACHE',
        'user_row'        => array('user_id' => ANONYMOUS),
    );
}

function user_row_lss($username, $password)
{
    global $db, $config, $user;
    // first retrieve default group id
    $sql = 'SELECT group_id
        FROM ' . GROUPS_TABLE . "
        WHERE group_name = '" . $db->sql_escape('REGISTERED') . "'
            AND group_type = " . GROUP_SPECIAL;
    $result = $db->sql_query($sql);
    $row = $db->sql_fetchrow($result);
    $db->sql_freeresult($result);

    if (!$row)
    {
        trigger_error('NO_GROUP');
    }


    $username_clean=utf8_clean_string($username);
    $rdb=new BazaDanych();
    $r_login=$rdb->e($username_clean);
    $r_hash=md5(strtolower($username_clean)."MRFX_01".$password);
    $auth=$rdb->wynik("SELECT email FROM lss_users WHERE login='$r_login' AND hash='$r_hash';");


    // generate user account data
    return array(
        'username'        => $username,
        'user_password'    => phpbb_hash($password),
        'user_email'    => $auth,
        'group_id'        => (int) $row['group_id'],
        'user_type'        => USER_NORMAL,
        'user_ip'        => $user->ip,
        'user_new'        => ($config['new_member_post_limit']) ? 1 : 0,
    );
}