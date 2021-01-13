<?php

/*
+---------------------------------------------------------------------------+
| Statistics v 0.0.1                                                        |
| ============                                                              |
| Copyright (c) by NoNameStudio                                             |
| For contact details:                                                      |
|                                                                           |
|	                                                                          |
| PHP7.2 & MYSQL5.8                                                         |
+---------------------------------------------------------------------------+
*/

session_start();

//error_reporting(E_ERROR | E_PARSE);
set_time_limit (30000);
//ini_set('error_reporting', E_ALL);
//ini_set('display_errors', 1);
//ini_set('display_startup_errors', 1);
error_reporting(0);

// Support Database
include ('_conf.php');
include ('classes/safemysql.class.php');
$db = new SafeMySQL(array('host' => $db_host,'user' => $db_user, 'pass' => $db_pass, 'db' => $db_name, 'charset' => 'utf8'));

//var_dump($db->getRow("SELECT * FROM `settings`"));

require_once('classes/core.class.php');

$core  = new Core();

$url = $core->url;
$form = $core->form;
$ip = $core->ip;
$get = $core->setGet();

if (isset($_SESSION['id'])) {
  $user_id = $_SESSION['id'];
}

require_once('pages/controller.php');
