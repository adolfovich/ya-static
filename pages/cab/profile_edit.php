<?php

if (isset($get['a']) && $get['a'] == 'save') {
  //var_dump($form);
  if (strlen($form['profileName']) >= 5) {
    $update['name'] = $form['profileName'];
    if ($form['access']) {
      $update_access = '';

      $end_element = array_pop($form['access']);
      foreach ($form['access'] as $value) {
         $update_access .= $value . ',';
      }
      $update_access .= $end_element;

      $update['access'] = $update_access;

      $q = $db->parse("UPDATE `profiles` SET ?u WHERE `id` = ?i", $update, $get['id']);

      //var_dump($q);

      if ($db->query($q)) {
        $msg = ["type"=>"success", "text"=>"Профиль изменен"];
      }

    }
  } else {
    $msg = ["type"=>"danger", "text"=>"Ошибка! Название профиля должно быть не менее 5 символов"];
  }
}

if (isset($get['id'])) {
  if ($profile_data = $db->getRow("SELECT * FROM `profiles` WHERE `id` = ?i", $get['id'])) {
    $access = explode(",", $profile_data['access']);
  } else {
    $msg = ["type"=>"danger", "text"=>"Ошибка! профиль не найден"];
  }
}


include ('tpl/cab/profile_edit.tpl');
