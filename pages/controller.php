<?php

$menu = $db->getAll("SELECT * FROM `menu` WHERE `enabled` = 1 ORDER BY `ordering`");

if (isset($url[1])) {
  $page_name = $db->getOne("SELECT name FROM menu WHERE url LIKE '%".$url[1]."%'");
}

if (isset($user_id)) {
  $auth_user = $db->getRow("SELECT * FROM `users` WHERE `id` = ?i", $user_id);
  $user_data = $db->getRow("SELECT * FROM `users` WHERE `id` = ?i", $user_id);

  $user_salons = explode(",", $user_data['salons']);
  //var_dump($user_salons);
  $user_profile = $db->getRow("SELECT * FROM `profiles` WHERE `id` = ?i", $user_data['profile']);
  $user_stats = explode(",", $user_profile['stat_access']);
}

header("Cache-Control: no cache");
session_cache_limiter("private_no_expire");

if ($url[0] == 'cab') {
  include ('pages/cab/template.php');
} else if ($url[0] == 'video') {
  include ('pages/video.php');
} else {
  include ('pages/cab/login.php');
}
