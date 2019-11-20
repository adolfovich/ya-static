<?php

if (isset($get['a']) && $get['a'] == 'save') {
  //var_dump($form);
  if (strlen($form['profileName']) >= 5) {
    $update['name'] = $form['profileName'];
    if ($form['access']) {
      $update_access = '';
      $update_stat_access = '';

      $end_element = array_pop($form['access']);
      foreach ($form['access'] as $value) {
         $update_access .= $value . ',';
      }
      $update_access .= $end_element;

      $end_element1 = array_pop($form['stat_access']);
      foreach ($form['stat_access'] as $value) {
         $update_stat_access .= $value . ',';
      }
      $update_stat_access .= $end_element1;

      if (isset($form['change_ticket_status']) && $form['change_ticket_status'] == 1) {
        $change_ticket_status = '1';
      } else {
        $change_ticket_status = '0';
      }

      $update['access'] = $update_access;
      $update['stat_access'] = $update_stat_access;
      $update['change_ticket_status'] = $change_ticket_status;

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

    $statistics = $db->getAll("SELECT * FROM `statistics` WHERE `enabled` = 1");
    $stat_access = explode(",", $profile_data['stat_access']);
  } else {
    $msg = ["type"=>"danger", "text"=>"Ошибка! профиль не найден"];
  }
}


include ('tpl/cab/profile_edit.tpl');
