<?php
/**
 * <pre>
 * Invision Power Services
 * IP.Board v3.4.x
 * Login handler abstraction : SA-MP FullServer account handler
 * </pre>
 *
 * @author      IP.Board
 * @author      Eider <eider@fullserver.eu>
 * @author      Lukasz Biegaj <wielebny@lss-rp.pl>
 * @package     IP.Board
 *
 */

if ( ! defined( 'IN_IPB' ) )
{
    print "<h1>Incorrect access</h1>You cannot access this file directly. If you have recently upgraded, make sure you upgraded 'admin.php'.";
    exit();
}

class login_server extends login_core implements interface_login
{
    /**
     * Temporary data store
     *
     * @access    protected
     * @var        array
     */
    protected $data_store    = array();
    
    /**
     * Login method configuration
     *
     * @access    protected
     * @var        array
     */
    protected $method_config    = array();
    
    /**
     * Constructor
     *
     * @access    public
     * @param    object        ipsRegistry reference
     * @param    array         Configuration info for this method
     * @param    array         Custom configuration info for this method
     * @return    @e void
     */
    public function __construct( ipsRegistry $registry, $method, $conf=array() )
    {
        $this->method_config    = $method;
        parent::__construct( $registry );
    }
    
    /**
     * Authenticate the request
     *
     * @access    public
     * @param    string        Username
     * @param    string        Email Address
     * @param    string        Password
     * @return    boolean        Authentication successful
     */
    public function authenticate( $username, $email_address, $password )
    {
        //-----------------------------------------
        // Check admin authentication request
        //-----------------------------------------
        
        if ( $this->is_admin_auth )
        {
            $this->adminAuthLocal( $username, $email_address, $password );
            
              if ( $this->return_code == 'SUCCESS' )
              {
                  return true;
              }
        }

        //-----------------------------------------
        // Reset array
        //-----------------------------------------
        
        $this->auth_errors = array();

        //-----------------------------------------
        // OK?
        //-----------------------------------------

        // @todo @fixme dorobic error handling
        // @todo tu podaj ścieżkę do biblioteki adodb5 oraz dane autoryzacji
        require_once("/home/lbiegaj/lss-rp.pl/panel/public_html/p/libs/adodb5/adodb.inc.php");
        $RDB=NewADOConnection("mysql");
        $RDB->Connect("adres_serwera_mysql", "login", "haslo", "nazwa_bazy_danych");
        $RDB->Execute("set names utf8");

        $hasz=md5(strtolower($username) . "MRFX_01" . $password);
        $autentykacja=$RDB->getRow("SELECT id,login,email,premium>NOW() premium FROM lss_users WHERE login=? AND hash=?", Array($username, $hasz));

        if (!$autentykacja || !$autentykacja['id']) {
            $this->return_code = 'NO_USER';
            return false;
        }

        $name=$autentykacja['login'];
        $email=$autentykacja['email'];
        $userId=$autentykacja['id'];

        if ( count($this->auth_errors) )
        {
            $this->return_code = $this->return_code ? $this->return_code : 'NO_USER';
            return false;
        }

        $this->_loadMember( $userId );

        if ( $this->member_data['member_id'] )
        {
            $this->return_code = 'SUCCESS';
        }
        else
        {
            $this->member_data = $this->createLocalMember( array(
                                                            'members'            => array(
                                                                                         'email'                    => $email,
                                                                                         'name'                        => $name,
                                                                                         'members_l_username'        => strtolower($name),
                                                                                         'members_display_name'        => $name,
                                                                                         'members_l_display_name'    => strtolower($name),
                                                                                         'joined'                    => time(),
                                                                                         'members_created_remote'    => 1,
                                                                                         'server_id'                    => $userId,
                                                                                        ),
                                                            'profile_portal'    => array(
                                                                                        ),
                                                    )        );

            $this->return_code = 'SUCCESS';
        }

/*
        // @todo odkomentowac w razie potrzeby
        // ponizszy fragment kodu odpowiada za przydzielenie gracza do grupy 'zbanowani' i grupy 'premium'
        // mozesz go odkomentowac, ale popraw przydzielane member_group_id do grup w Twojej instalacji ipboard

        $ban=$RDB->getOne("SELECT 1 FROM lss_bany WHERE id_user=? AND date_to>NOW()",Array($userId));
        if ($ban && intval($ban)>0) {
          // zakladamy bana na forum
          $this->DB->update( 'members', array( 'member_group_id' => 5 ), 'member_id='.intval($this->member_data['member_id']) );
        } elseif ($this->member_data['member_group_id']==5) { // zdejmujemy bana
            $this->DB->update( 'members', array( 'member_group_id' => $autentykacja['premium']>0?10:3 ), 'member_id='.intval($this->member_data['member_id']) );
        } elseif ($this->member_data['member_group_id']==3 && $autentykacja['premium']>0) {
            $this->DB->update( 'members', array( 'member_group_id' => 10 ), 'member_id='.intval($this->member_data['member_id']) );
        }
*/

        $this->request['rememberMe'] =  $this->data_store['cookiedate'] ;

        return true;
    }

    /**
     * Load a member from account ID
     *
     * @access    protected
     * @param    string         Token
     * @return    @e void
     */
    protected function _loadMember( $userToken )
    {
        $check = $this->DB->buildAndFetch( array( 'select'    => 'member_id',
                                                          'from'    => 'members',
                                                          'where'    => "server_id='" . $this->DB->addSlashes( $userToken ) . "'"
                                                )        );

        if( $check['member_id'] )
        {
            $this->member_data = IPSMember::load( $check['member_id'], 'extendedProfile,groups' );
        }
    }
}
