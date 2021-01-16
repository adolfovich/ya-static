<?php

function getUserSalons($user_salons) {
  global $db;
  $out = '';
  if (!$user_salons) {
    return 'Все';
  } else {
    $salons_id = explode(",", $user_salons);
    foreach ($salons_id as $salon_id) {
      $salon_name = $db->getOne("SELECT name FROM salons WHERE id = ?i", $salon_id);
      $out .= $salon_name . '<br>';
    }
    return $out;
  }
}

if (isset($get['a']) && $get['a'] == 'del') {
  if ($db->query("UPDATE `users` SET `status` = 0 WHERE `id` = ?i", $get['id'])) {
    $msg = ["type"=>"success", "text"=>"Пользователь удален"];
  };
}

if (isset($get['a']) && $get['a'] == 'return') {
  if ($db->query("UPDATE `users` SET `status` = 1 WHERE `id` = ?i", $get['id'])) {
    $msg = ["type"=>"success", "text"=>"Пользователь восстановлен"];
  };
}

if (isset($get['a']) && $get['a'] == 'del_profile') {
  $users_with_profile = $db->getAll("SELECT * FROM users WHERE profile = ?i", $get['id']);
  if (count($users_with_profile)) {
    $msg = ["type"=>"danger", "text"=>"Ошибка! Профиль не может быть удален так как установлен у пользователей"];
  } else {
    if ($db->query("UPDATE `profiles` SET `is_del` = 1 WHERE `id` = ?i", $get['id'])) {
      $msg = ["type"=>"success", "text"=>"Профиль удален"];
    }
  }
}

if (isset($get['a']) && $get['a'] == 'all_users') {
  $users_where = '';
} else {
  $users_where = 'WHERE `status` = 1';
}

$users = $db->getAll("SELECT *, (SELECT name FROM profiles WHERE id = u.profile) as profileName FROM `users` u ".$users_where);

$profiles = $db->getAll("SELECT * FROM `profiles` WHERE `is_del` = 0");

include ('tpl/cab/users.tpl');
