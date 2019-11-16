<?php



$ticket = $db->getRow("SELECT
  *,
  (SELECT `name` FROM `tickets_statuses` WHERE `id` = t.`status`) as status_name,
  (SELECT `color` FROM `tickets_statuses` WHERE `id` = t.`status`) as status_color,
  (SELECT `name` FROM `tickets_types` WHERE `id` = t.`type`) as type_name 
  FROM `tickets` t WHERE `id` = ?i", $_GET['id']);

$data = json_decode($ticket['data'], TRUE);

var_dump($data);

include ('tpl/cab/view_ticket.tpl');
