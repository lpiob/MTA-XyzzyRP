<?

// Szablon.php
require_once('p/libs/smarty/Smarty.class.php');
class Szablon extends Smarty {
 public $plik="";
 public $seed=-1;
 private $html_title="";
 private $html_titles=Array();
 private $html_js=Array();
 private $html_css=Array();
 private $bc=Array();
 
 public function __construct(){
	parent::__construct();
	global $CFG_page_name;

  $this->template_dir='p/templates/';
  $this->compile_dir='p/templates_c/';
//  $this->plugins_dir='p/plugins/';

  global $CFG_page_name;
  $this->html_title=$CFG_page_name;
//  $this->register_modifier('kiedy','kiedy');
 }

 public function dodaj_tytul($txt) {
//    $this->html_titles[]=$txt;
    array_unshift($this->html_titles,$txt);
	$this->html_title=join(" - ", $this->html_titles);
 }
 public function dodaj_js($plik) {
    $this->html_js[]=$plik;
 }
 
 public function dodaj_css($plik) {
    $this->html_css[]=$plik;
 }
 
 public function blad_krytyczny($txt) {
    $this->append('_error_msgs',$txt);
    $this->display('_error.tpl');
    exit;
 }
 public function add_bc($txt,$url){
	$this->bc[]=Array('txt'=>$txt,'url'=>$url);
	$this->dodaj_tytul($txt);
 }
 
 
 public function wyswietl() {
    if ($this->plik=="") 
	$this->blad_krytyczny('Nie wybrano szablonu!');

    $this->assign('html_title',$this->html_title);
    $this->assign('html_js',$this->html_js);
    $this->assign('html_css',$this->html_css);    

	$this->assign('breadcrumbs',$this->bc);
	if ($this->seed>=0)
	    $this->display($this->plik,$this->seed);
	else
	    $this->display($this->plik);
 }
		  
 };
		  
?>