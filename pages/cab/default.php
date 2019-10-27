<?php

$statistics = $db->getAll("SELECT * FROM `statistics` WHERE `enabled` = 1");
$salons = $db->getAll("SELECT * FROM `salons` WHERE `enabled` = 1");

$i = 1;

include ('tpl/cab/default.tpl');
