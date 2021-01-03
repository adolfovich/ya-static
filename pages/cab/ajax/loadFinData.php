<?php


require_once('connect.php');

$arr['response'] = [];
$arr['response']['expenses'] = '';
$arr['response']['income'] = '';




if ($form["salon"] == 'all') {
  $accepted_salons = explode(",", $user_data['salons']);
} else {
  $accepted_salons[] = $form["salon"];
}

$expenses = $db->getAll("SELECT *, (SELECT name FROM salons WHERE id = salon) as salon_name FROM finance_journal WHERE op_type = 'credit' AND salon IN (?a) AND date BETWEEN ?s AND ?s ORDER BY date DESC", $accepted_salons, $form["dateFrom"], $form["dateTo"]);

if ($expenses) {
  foreach($expenses as $expense) {
    $arr['response']['expenses'] .= '<tr>';
    $arr['response']['expenses'] .= '<th scope="row">'.$expense['salon_name'].'</th>';
    $arr['response']['expenses'] .= '<td>'.date("d.m.Y", strtotime($expense['date'])).'</td>';
    $arr['response']['expenses'] .= '<td>Расход</td>';
    $arr['response']['expenses'] .= '<td>'.$expense['op_decryption'].'</td>';
    $arr['response']['expenses'] .= '<td>'.number_format($expense['amount'], 2, '.', ' ').'</td>';
    $arr['response']['expenses'] .= '<td>'.$expense['op_comment'].'</td>';
    $arr['response']['expenses'] .= '<td><a href="?deleteRecord='.$expense['id'].'"><i class="fas fa-trash-alt"></i></a></td>';
    $arr['response']['expenses'] .= '</tr>';

    $arr['response']['expenses'] .= '';
  }
} else {
  $arr['response']['expenses'] .= '<tr>';
  $arr['response']['expenses'] .= '<td colspan="6" style="text-align: center;">Нет данных</td>';
  $arr['response']['expenses'] .= '</tr>';
}

$incomes = $db->getAll("SELECT *, (SELECT name FROM salons WHERE id = salon) as salon_name FROM finance_journal WHERE op_type = 'debit' AND salon IN (?a) AND date BETWEEN ?s AND ?s ORDER BY date DESC", $accepted_salons, $form["dateFrom"], $form["dateTo"]);

if ($incomes) {
  foreach($incomes as $income) {
    $arr['response']['income'] .= '<tr>';
    $arr['response']['income'] .= '<th scope="row">'.$income['salon_name'].'</th>';
    $arr['response']['income'] .= '<td>'.date("d.m.Y", strtotime($income['date'])).'</td>';
    $arr['response']['income'] .= '<td>Расход</td>';
    $arr['response']['income'] .= '<td>'.$income['op_decryption'].'</td>';
    $arr['response']['income'] .= '<td>'.number_format($income['amount'], 2, '.', ' ').'</td>';
    $arr['response']['income'] .= '<td>'.$income['op_comment'].'</td>';
    $arr['response']['income'] .= '<td><a href="?deleteRecord='.$income['id'].'"><i class="fas fa-trash-alt"></i></a></td>';
    $arr['response']['income'] .= '</tr>';
    $arr['response']['income'] .= '';
  }
} else {
  $arr['response']['income'] .= '<tr>';
  $arr['response']['income'] .= '<td colspan="6" style="text-align: center;">Нет данных</td>';
  $arr['response']['income'] .= '</tr>';
}

echo $core->returnJson($arr);
