<?php

require_once('connect.php');

$tickets = $db->getAll("
  SELECT *,
  (SELECT name FROM users WHERE id = t.user_create) as user_name,
  (SELECT name FROM tickets_types WHERE id = t.type) as type_name,
  (SELECT name FROM tickets_statuses WHERE id = t.status) as status_name,
  (SELECT color FROM tickets_statuses WHERE id = t.status) as status_color
  FROM tickets t ORDER BY t.id DESC");

$tickets_types = $db->getAll("SELECT * FROM tickets_types");

$arr = [];
$html = '';

//echo '<table>';

foreach ($tickets as $ticket) {
  $html .= '<tr class = "ticketsTable" onClick="location.href = \'view_ticket?id='.$ticket['id'].'\'" style="">';
    $html .= '<td class="budget">'.$ticket['id'].'</td>';
    $html .= '<td class="budget">'.date("d.m.Y", strtotime($ticket['create_date'])).'</td>';
    $html .= '<td class="budget">'.$ticket['user_name'].'</td>';
    $html .= '<td class="budget">'.$ticket['type_name'].'</td>';
    $html .= '<td class="budget"><span class="badge '.$ticket['status_color'].'">'.$ticket['status_name'].'</span></td>';
  $html .= '</tr>';
}

//echo $html;
//echo '</table>';
//echo '<hr>';

$arr['response'] = $html;

echo $core->returnJson($arr);
