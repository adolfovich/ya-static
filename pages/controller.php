<?php
//var_dump($url);

$menu = $db->getAll("SELECT * FROM `menu` WHERE `enabled` = 1");

if (isset($url[1])) {
  $page_name = $db->getOne("SELECT name FROM menu WHERE url LIKE '%".$url[1]."%'");
}


//var_dump();

if (isset($user_id)) {
  $auth_user = $db->getRow("SELECT * FROM `users` WHERE `id` = ?i", $user_id);
  $user_data = $db->getRow("SELECT * FROM `users` WHERE `id` = ?i", $user_id);
  $user_salons = explode(",", $user_data['salons']);  
}


if ($url[0] == 'cab') {
  include ('pages/cab/template.php');
} else {
  include ('pages/cab/login.php');
}
