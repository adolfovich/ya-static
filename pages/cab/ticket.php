<?php



if (isset($form)) {

  $curr_ticket = $db->getRow("SELECT * FROM `tickets` WHERE `id` = ?i", $_GET['id']);

  if ($form['lead_time'] && $form['lead_time'] != date("Y-m-d", strtotime($curr_ticket['lead_time']))) {
    $db->query("UPDATE `tickets` SET lead_time = ?s WHERE `id` = ?i", $form['lead_time'], $_GET['id']);
    $comment = 'Дата выполнения  изменена с '.date("d.m.Y", strtotime($curr_ticket['lead_time'])).' на '.date("d.m.Y", strtotime($form['lead_time']));
    $core->ticketLog($_GET['id'], $user_data['id'], '<span style="text-decoration: underline;">Изменение:</span> '.$comment);
    unset($comment);
  }

  if (isset($form['changeStatus'])) {

    $changeStatus = $form['changeStatus'];
    if ($changeStatus == 2 && $curr_ticket['type'] == 100) {
      $purchase_tickets = explode(';', $curr_ticket['text']);
      foreach ($purchase_tickets as $purchase_ticket) {
        $db->query("UPDATE tickets SET status = ?i WHERE id = ?i", $core->cfgRead('auto_status_purchse_end'), $purchase_ticket);
      }
    }
    unset($form['changeStatus']);
  }

  if (isset($form['comment'])) {
    $comment = $form['comment'];
    unset($form['comment']);
  }



  if (isset($comment) && $comment != '') {
    $core->ticketLog($_GET['id'], $user_data['id'], '<span style="text-decoration: underline;">Комментарий</span>: '.$comment);
  }

  if (isset($form['nomenclature'])) {
    foreach ($form['nomenclature'] as $key => $value) {
      //var_dump($key);
      //var_dump($db->parse("SELECT tp.*, (SELECT name FROM tickets_nomenclature WHERE id = tp.nomenclature_id) as nomenclature FROM tickets_purchases tp WHERE tp.ticket_id = ?i AND tp.nomenclature_id = ?i", $_GET['id'], $key));

      $old_data = $db->getRow("SELECT tp.*, (SELECT name FROM tickets_nomenclature WHERE id = tp.nomenclature_id) as nomenclature FROM tickets_purchases tp WHERE tp.ticket_id = ?i AND tp.nomenclature_id = ?i", $_GET['id'], $key);

      //var_dump($old_data['purchase']);
      //var_dump($value['new']);

      if ($old_data['purchase'] != $value['new']) {
        $db->query("UPDATE tickets_purchases SET purchase = ?s WHERE ticket_id = ?i AND nomenclature_id = ?i", $value['new'], $_GET['id'], $key);
        $comment = 'Позиция "'.$old_data['nomenclature']. '" изменена с '.$old_data['purchase'].' на '.$value['new'];
        $core->ticketLog($_GET['id'], $user_data['id'], '<span style="text-decoration: underline;">Изменение:</span> '.$comment);
      }
    }
  }
}
//var_dump($form);
if (isset($form)) {

  if (isset($changeStatus) && $changeStatus != $curr_ticket['status']) {
    $update = [
      "status" => $changeStatus
    ];
    $db->query("UPDATE `tickets` SET ?u WHERE `id` = ?i", $update, $_GET['id']);
    $status_info = $core->getTicketStatusInfo($changeStatus);
    $core->ticketLog($_GET['id'], $user_data['id'], '<span style="text-decoration: underline;">Изменение статуса на</span> "'.$status_info['name'].'"');
  }

  $saved = TRUE;
}

$ticket = $db->getRow("SELECT
  *,
  (SELECT `name` FROM `tickets_statuses` WHERE `id` = t.`status`) as status_name,
  (SELECT `next_statuses` FROM `tickets_statuses` WHERE `id` = t.`status`) as next_statuses,
  (SELECT `edited` FROM `tickets_statuses` WHERE `id` = t.`status`) as edited,
  (SELECT `color` FROM `tickets_statuses` WHERE `id` = t.`status`) as status_color,
  (SELECT `name` FROM `tickets_types` WHERE `id` = t.`type`) as type_name,
  (SELECT name FROM tickets_providers WHERE id = provider) as provider_name,
  (SELECT email FROM tickets_providers WHERE id = provider) as provider_email
  FROM `tickets` t WHERE `id` = ?i", $_GET['id']);

if ($user_profile['accepted_ticket_statuses'] != 0) {
  $next_statuses = explode(',', $ticket['next_statuses']);
} else {
  $next_statuses = $db->getCol("SELECT id FROM tickets_statuses WHERE deleted != 1");
}

//var_dump($user_profile['accepted_ticket_statuses']);


$ticket_log = $db->getAll("SELECT tl.*, (SELECT `name` FROM `users` WHERE `id` = tl.`user_id`) as `user_name` FROM `tickets_log` tl WHERE tl.`ticket_id` = ?i ORDER BY tl.`id` DESC", $ticket['id']);

$ticket_photos = $db->getAll("SELECT * FROM tickets_photos WHERE ticket_id = ?i", $ticket['id']);

if (!$ticket['type_name']) {
  if ($ticket['type'] == 0) {
    $ticket['type_name'] = 'Закупка';
  } else if ($ticket['type'] == 100) {
    $ticket['type_name'] = 'Общая закупка';
  }
}

if ($ticket['type'] == 0) {
  $purchases = $db->getAll("SELECT tp.*, (SELECT id FROM tickets_nomenclature WHERE id = tp.nomenclature_id) as nomenclature_id, (SELECT name FROM tickets_nomenclature WHERE id = tp.nomenclature_id) as nomenclature FROM tickets_purchases tp WHERE tp.ticket_id = ?i AND 	tp.purchase > 0", $ticket['id'] );
}

if ($ticket['type'] == 100) {
  $purchases = explode(';', $ticket['text']);

}

$comments = $db->getAll("SELECT tl.*, (SELECT `name` FROM `users` WHERE `id` = tl.`user_id`) as `user_name` FROM `tickets_log` tl WHERE tl.`ticket_id` = ?i AND text LIKE ?s ORDER BY tl.`id` DESC", $ticket['id'], '%Комментарий%');

include ('tpl/cab/ticket.tpl');
