<?php

$tickets = $db->getAll("
  SELECT *,
  (SELECT name FROM users WHERE id = t.user_create) as user_name,
  (SELECT name FROM tickets_types WHERE id = t.type) as type_name,
  (SELECT name FROM tickets_statuses WHERE id = t.status) as status_name,
  (SELECT color FROM tickets_statuses WHERE id = t.status) as status_color
  FROM tickets t ORDER BY t.id DESC");

$tickets_types = $db->getAll("SELECT * FROM tickets_types");

include ('tpl/cab/tickets.tpl');
