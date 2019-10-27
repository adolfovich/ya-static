<?php

if (isset($get['a']) && $get['a'] == 'save') {
  if (strlen($form['salonName']) >= 5) {
    $update = [
      "name" => $form['salonName']
    ];

    $q = $db->parse("UPDATE `salons` SET ?u WHERE `id` = ?i", $update, $get['id']);

    if ($db->query($q)) {
      $msg = ["type"=>"success", "text"=>"Данные сохранены"];
    }
  } else {
    $msg = ["type"=>"danger", "text"=>"Ошибка! Название салона должно содержать не менее 5 символов"];
  }
}

if (isset($get['id'])) {
  if ($salon_data = $db->getRow("SELECT * FROM `salons` WHERE `id` = ?i", $get['id'])) {

  } else {
    $msg = ["type"=>"danger", "text"=>"Ошибка! салон не найден"];
  }
}

include ('tpl/cab/salon_edit.tpl');
