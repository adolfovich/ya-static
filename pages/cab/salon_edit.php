<?php

if (isset($get['a']) && $get['a'] == 'save' && $user_profile['edit_salons']) {
  if (strlen($form['salonName']) >= 5) {
    $update = [
      "name" => $form['salonName']
    ];

    $q = $db->parse("UPDATE `salons` SET ?u WHERE `id` = ?i", $update, $get['id']);

    foreach ($form['salonFields'] as $field_id => $field_value) {
      if ($field_value != '') {
        $core->setSalonFieldValue($get['id'], $field_id, $field_value);
      }
    }

    if ($db->query($q)) {
      $msg = ["type"=>"success", "text"=>"Данные сохранены"];
    }


  } else {
    $msg = ["type"=>"danger", "text"=>"Ошибка! Название салона должно содержать не менее 5 символов"];
  }
}

if (isset($get['id'])) {
  if ($salon_data = $db->getRow("SELECT * FROM `salons` WHERE `id` = ?i", $get['id'])) {
    $fields_list = $db->getAll("SELECT * FROM salons_fields WHERE deleted != 1");
  } else {
    $msg = ["type"=>"danger", "text"=>"Ошибка! салон не найден"];
  }
}

if (!$user_profile['edit_salons']) {
  $disabled = 'disabled';
} else {
  $disabled = '';
}

include ('tpl/cab/salon_edit.tpl');
