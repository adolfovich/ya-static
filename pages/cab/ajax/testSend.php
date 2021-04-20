<?php

require_once('connect.php');

$ticket_data['provider_email'] = 'adolfovich.alexashka@gmail.com';
$html = 'test';

$send_email = $core->sendMyMail('Заказ #'.$ticket_data['id'].' Парикмахерская Я', $html , $ticket_data['provider_email']);

var_dump($send_email);
