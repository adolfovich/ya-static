<?php

if (isset($get['a']) && $get['a'] == 'del') {
  if ($db->query("UPDATE `salons` SET `enabled` = 0 WHERE `id` = ?i", $get['id'])) {
    $msg = ["type"=>"success", "text"=>"Салон удален"];
  }
}

$salons = $db->getAll("SELECT * FROM `salons` WHERE `enabled` = 1");


include ('tpl/cab/salons.tpl');
