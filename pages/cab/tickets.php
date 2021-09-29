<?php

//var_dump($form);

$allowFileTypes = [
  'image/jpg',
  'image/jpeg',
  'image/png',
];

$full_path = dirname(__FILE__);
$full_path = str_replace('pages/cab', '', $full_path);

//$page_title = "Заявки";

$img_insert = [];

if (isset($form['action_type'])) {
  if ($form['action_type'] == 'add') {

    if (isset($_FILES['dopFile1']) && $_FILES['dopFile1']['error'] == 0) {
      foreach ($_FILES as $file) {

        if (in_array(mime_content_type($file['tmp_name']), $allowFileTypes)) {

          $fileTmpPath = $file['tmp_name'];
          $extention = explode(".", $file['name']);
          $extention = end($extention);
          $name = uniqid().'.'.$extention;
          $dest_path = $full_path.'/ticketsFoto/' . $name;
          $dbpath = '/ticketsFoto/'.$name;

          move_uploaded_file($fileTmpPath, $dest_path);

          $img_insert[] = "INSERT INTO tickets_photos SET ticket_id = ?i, path = '".$dbpath."'";

        } else {
          $msg['window'] = 'add';
          //$msg['video_id'] = $_POST['videotId'];
          $msg['type'] = 'error';
          $msg['text'] = 'Недопустимый формат фото ';
          break;
        }
      }
    }

      if (!isset($msg['type']) || $msg['type'] != 'error') {
        $insertTicket = [
          'type' => $form['ticketType'],
          'salon_id' => $form['ticketSalon'],
          'user_create' => $user_data['id'],
          'text' => $form['ticketText'],
        ];

        $db->query("INSERT INTO tickets SET ?u", $insertTicket);
        $ticket_id = $db->insertId();

        $insertLog = [
          'ticket_id' => $ticket_id,
          'user_id' => $user_data['id'],
          'text' => 'Создание заявки',
        ];

        $db->query("INSERT INTO tickets_log SET ?u", $insertLog);

        if (count($img_insert)) {
          foreach ($img_insert as $insert_q) {
            $db->query($insert_q, $ticket_id);
          }
        }
      }

  }

  if ($form['action_type'] == 'addPurchase') {

    $salon = $form['purchaseSalon'];
    $provider = $form['purchaseProvider'];

    $insert = [
      'type' => 0,
      'salon_id' => $form['purchaseSalon'],
      'user_create' => $user_data['id'],
      'provider' => $provider
    ];

    $db->query("INSERT INTO tickets SET ?u", $insert);
    $ticket_id = $db->insertId();

    foreach ($form['nomenclature'] as $key => $value) {
      if ($value['old'] != '' && $value['new'] != '') {
        $insert_purchase = [
          'ticket_id' => $ticket_id,
          'salon_id' => $form['purchaseSalon'],
          'provider_id' => $provider,
          'nomenclature_id' => $key,
          'residue' => $value['old'],
          'purchase' => $value['new'],
        ];

        $db->query("INSERT INTO tickets_purchases SET ?u", $insert_purchase);
      }      
    }

    $insertLog = [
      'ticket_id' => $ticket_id,
      'user_id' => $user_data['id'],
      'text' => 'Создание заявки',
    ];

    $db->query("INSERT INTO tickets_log SET ?u", $insertLog);
  }

  if ($form['action_type'] == 'addGeneralPurchase') {

    $purchases = $db->getAll("SELECT * FROM tickets WHERE type = 0 AND status = 3");

    $text = '';
    $i = 0;
    foreach ($purchases as $purchase) {
      if ($i != 0) $text .= ';';
      $text .=  $purchase['id'];

      $db->query("UPDATE tickets SET status = 1 WHERE id = ?i", $purchase['id']);
      $comment = 'Добавлена в общую закупку';
      $core->ticketLog($purchase['id'], $user_data['id'], '<span style="text-decoration: underline;">Изменение:</span> '.$comment);
      $i++;
    }

    //generalPurchaseProvider
    $insert = [
      'type' => 100,
      'user_create' => $user_data['id'],
      'provider' => $form['generalPurchaseProvider'],
      'text' => $text
    ];

    $db->query("INSERT INTO tickets SET ?u", $insert);

    $generalPurchaseID = $db->insertId();

    $insertLog = [
      'ticket_id' => $generalPurchaseID,
      'user_id' => $user_data['id'],
      'text' => 'Создание заявки',
    ];

    $db->query("INSERT INTO tickets_log SET ?u", $insertLog);

    $core->jsredir('ticket?id='.$generalPurchaseID);
  }
}

if (!$user_data['salons']) {
  $accepted_salons = 0;
  $user_salons = $db->getAll("SELECT * FROM salons WHERE enabled = 1 AND franchising = 0");
  $user_salons_ids = $db->getCol("SELECT id FROM salons WHERE enabled = 1 AND franchising = 0");
} else {
  $accepted_salons = explode(",", $user_data['salons']);
  $user_salons = $db->getAll("SELECT * FROM salons WHERE enabled = 1 AND id IN (?a)", $accepted_salons);
  $user_salons_ids = $db->getCol("SELECT id FROM salons WHERE enabled = 1 AND id IN (?a)", $accepted_salons);
}

$tickets_types = $db->getAll("SELECT * FROM tickets_types WHERE id BETWEEN 1 AND 100 ");

$tickets_statuses = $db->getAll("SELECT * FROM tickets_statuses WHERE deleted = 0 ORDER BY ordering");

$purchase_providers = $db->getAll("SELECT * FROM tickets_providers WHERE deleted = 0");

//$tickets = $db->getAll("SELECT t.* FROM tickets.t WHERE t.salon_id IN (?u)", $user_salons_ids);

include ('tpl/cab/tickets.tpl');
