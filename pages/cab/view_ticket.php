<?php

if (isset($form)) {

  $curr_ticket = $db->getRow("SELECT * FROM `tickets` WHERE `id` = ?i", $_GET['id']);

  if (isset($form['changeStatus'])) {
    $changeStatus = $form['changeStatus'];
    unset($form['changeStatus']);
  }

  //comment
  if (isset($form['comment'])) {
    $comment = $form['comment'];
    unset($form['comment']);
  }

  if (isset($comment)) {
    $core->ticketLog($_GET['id'], $user_data['id'], $comment);
  }




  if ($form) {
    foreach ($form as $key => $value) {
      $key = explode('_', $key);
      $field = $db->getRow("SELECT * FROM `tickets_fields` WHERE `id` = ?i", $key[1]);

      if ($field['required'] == 1 && !$value) {
        $arr['error'] = 'Не заполнено одно или несколько обязательных полей';
        echo $core->returnJson($arr);
        die();
      } else {
          $form_arr[$field['id']] = $value;
      }
    }
    $json = json_encode($form_arr);
  }

  if (isset($json) && $curr_ticket['data'] != $json) {
    $update = [
      "data" => $json
    ];

    $db->query("UPDATE `tickets` SET ?u WHERE `id` = ?i", $update, $_GET['id']);
    $core->ticketLog($_GET['id'], $user_data['id'], 'Изменение заявки');
  }

  if (isset($changeStatus) && $changeStatus != $curr_ticket['status']) {
    $update = [
      "status" => $changeStatus
    ];
    $db->query("UPDATE `tickets` SET ?u WHERE `id` = ?i", $update, $_GET['id']);
    $status_info = $core->getTicketStatusInfo($changeStatus);
    $core->ticketLog($_GET['id'], $user_data['id'], 'Изменение статуса на "'.$status_info['name'].'"');
  }

  $saved = TRUE;
}

$ticket = $db->getRow("SELECT
  *,
  (SELECT `name` FROM `tickets_statuses` WHERE `id` = t.`status`) as status_name,
  (SELECT `next_statuses` FROM `tickets_statuses` WHERE `id` = t.`status`) as next_statuses,
  (SELECT `edited` FROM `tickets_statuses` WHERE `id` = t.`status`) as edited,
  (SELECT `color` FROM `tickets_statuses` WHERE `id` = t.`status`) as status_color,
  (SELECT `name` FROM `tickets_types` WHERE `id` = t.`type`) as type_name
  FROM `tickets` t WHERE `id` = ?i", $_GET['id']);

$data = json_decode($ticket['data'], TRUE);

$next_statuses = explode(',', $ticket['next_statuses']);

//var_dump($next_statuses[0]);

$ticket_log = $db->getAll("SELECT tl.*, (SELECT `name` FROM `users` WHERE `id` = tl.`user_id`) as `user_name` FROM `tickets_log` tl WHERE tl.`ticket_id` = ?i ORDER BY tl.`id` DESC", $_GET['id']);



include ('tpl/cab/view_ticket.tpl');
