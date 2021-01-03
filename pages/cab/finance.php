<?php

$profile_data = $db->getRow("SELECT * FROM `profiles` WHERE `id` = ?i", $auth_user['id']);
//var_dump($profile_data['edit_finance']);


if (!$user_data['salons']) {
  $accepted_salons = 0;
  $user_salons = $db->getAll("SELECT * FROM salons WHERE enabled = 1");
  $user_salons_ids = $db->getCol("SELECT id FROM salons WHERE enabled = 1");
} else {
  $accepted_salons = explode(",", $user_data['salons']);
  $user_salons = $db->getAll("SELECT * FROM salons WHERE enabled = 1 AND id IN (?a)", $accepted_salons);
  $user_salons_ids = $db->getCol("SELECT id FROM salons WHERE enabled = 1 AND id IN (?a)", $accepted_salons);
}

//var_dump(time() > strtotime($form['opDete']));
//var_dump(time());

if (isset($_GET['deleteRecord']) && $_GET['deleteRecord'] > 0) {
  $db->query("DELETE FROM finance_journal WHERE id = ?i", $_GET['deleteRecord']);
  $msg['type'] = 'success';
  $msg['text'] = 'Операция удалена';
}

if (isset($form['action_type']) && $form['action_type'] == 'add_operation') {
  if ($accepted_salons == 0 || in_array($form['opSalon'], $accepted_salons)) {
    if (time() > strtotime($form['opDete'])) {
      if ($form['opAmount'] > 0) {
        $operation_data = $db->getRow("SELECT * FROM finance_operation_types WHERE name = ?s", $form['opDesc']);
        $insert = [
          'salon' => $form['opSalon'],
          'date' => $form['opDete'],
          'op_type' => $operation_data['type'],
          'op_decryption' => $operation_data['name'],
          'amount' => $form['opAmount'],
          'op_comment' => $form['opComment']
        ];
        $db->query("INSERT INTO finance_journal SET ?u", $insert);

        $msg['type'] = 'success';
        $msg['text'] = 'Операция сохранена';
      } else {
        $msg['window'] = 'addOperation';
        $msg['type'] = 'error';
        $msg['text'] = 'Сумма должна быть больше нуля';
      }
    } else {
      $msg['window'] = 'addOperation';
      $msg['type'] = 'error';
      $msg['text'] = 'Дата не может быть больше текущей';
    }
  } else {
    $msg['window'] = 'addOperation';
    $msg['type'] = 'error';
    $msg['text'] = 'Неверно указан салон';
  }
}

$op_descriptions = $db->getAll("SELECT * FROM finance_operation_types WHERE salon IN (0, ?a)", $user_salons_ids);

$descriptions = [];

foreach ($op_descriptions as $op_description) {
  if ($op_description['type'] == 'debit') {
    $descriptions[1][] = $op_description['name'];
  } else {
    $descriptions[2][] = $op_description['name'];
  }
}

$descriptions = json_encode($descriptions);

//var_dump($msg);

include ('tpl/cab/finance.tpl');