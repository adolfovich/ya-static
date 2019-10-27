<?php

//var_dump($form);

if ($core->login()) {
  $core->redir('cab/');
}

if (isset($form['inputLogin']) && $form['inputLogin'] == '') {
  $error = 'Не указан логин';
} elseif (isset($form['inputPassword']) && $form['inputPassword'] == '') {
  $error = 'Не указан пароль';
} elseif (isset($form['inputLogin']) && isset($form['inputPassword'])) {
  if ($user_info = $db->getRow('SELECT * FROM users WHERE login = ?s', $form['inputLogin'])) {

    if ($core->as_md5($pass_key, $form['inputPassword']) == $user_info['pass']) {
      echo 'OKK';

      $_SESSION['id'] = $user_info['id'];
      $_SESSION['login'] = $user_info['login'];
      setcookie ("sid", session_id(), time() + 50000);
      $session_time = $core->cfgRead('session_time');

      if (setcookie("login", $user_info['login'], time() + $session_time)) {
        //echo 'OKK';
        //var_dump($_SESSION);
        $core->redir('cab/');
      } else {
        echo 'ошибка установки cookie';
      }


    } else {
      $error = 'Неверный пароль';
    }
  } else {
    $error = 'Пользователь не найден';
  }
}


include ('tpl/cab/login.tpl');
