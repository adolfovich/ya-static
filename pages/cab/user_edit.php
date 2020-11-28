<?php

if (isset($get['a']) && $get['a'] == 'save') {
  $update = [];
  //var_dump($form);
  if ($form['userPass'] && $form['userRePass']) {
    if (strlen($form['userPass']) >= 5) {
      if ($form['userPass'] == $form['userRePass']) {
        if ($db->query("UPDATE `users` SET `pass` = ?s WHERE `id` = ?i", $core->as_md5($pass_key, $form['userPass']), $get['id'])) {
          $msg = ["type"=>"success", "text"=>"Пароль изменен"];
        }
      } else {
        $msg = ["type"=>"danger", "text"=>"Ошибка! Введенные пароли не совпадают"];
      }
    } else {
      $msg = ["type"=>"danger", "text"=>"Ошибка! Пароль должен быть не менее 5 символов"];
    }
  }



  if (isset($form['userProfile'])) {
    $userProfile = intval($form['userProfile']);
    $update['profile'] = $userProfile;
  }

  if (isset($form['userSalons'])) {
    $userSalons = '';
    $end_element = array_pop($form['userSalons']);
    foreach ($form['userSalons'] as $value) {
       $userSalons .= $value . ',';
    }
    $userSalons .= $end_element;
    //var_dump($userSalons);
    $update['salons'] = $userSalons;
  }

  if ($form['userName']) {
    $update['name'] = $form['userName'];
  }

  $q = $db->parse("UPDATE `users` SET ?u WHERE id = ?i", $update, $get['id']);

  var_dump($q);

  //$db->query("UPDATE `users` SET ?u WHERE id = ?i", $update, $get['id']);

  if ($db->query($q)) {
    $msg = ["type"=>"success", "text"=>"Данные сохранены"];
  }


}

if (isset($get['id'])) {
  if ($user_data = $db->getRow("SELECT * FROM `users` WHERE `id` = ?i", $get['id'])) {
    $user_profile = $db->getRow("SELECT * FROM `profiles` WHERE `id` = ?i", $user_data['profile']);
    $user_salons = explode(",", $user_data['salons']);
    $profiles = $db->getAll("SELECT * FROM `profiles`");
    $salons = $db->getAll("SELECT * FROM `salons`");
  } else {
    $msg = ["type"=>"danger", "text"=>"Ошибка! пользователь не найден"];
  }
}

include ('tpl/cab/user_edit.tpl');
