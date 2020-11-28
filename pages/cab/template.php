<?php

//var_dump($url);
$core->setPageCookie($url, $_GET);

if (!$core->login()) {
  $core->redir('/login');
} else {

  if (isset($_COOKIE['page']) && $_COOKIE['page'] != '') {
    header("Location: /cab/".$_COOKIE['page']);
    setcookie("page", '');
  }



  //var_dump($url);

  if (!isset($url[1]) || $url[1] == '') {
    $page = 'pages/cab/default.php';
  } elseif (file_exists('pages/cab/'.$url[1].'.php')) {
    $page = 'pages/cab/'.$url[1].'.php';
  } else {
    $page = 'pages/cab/404.php';
  }

  //var_dump('pages/cab/'.$url[1].'.php');

  include ('tpl/cab/header.tpl');
  include ('tpl/cab/template.tpl');
  include ('tpl/cab/footer.tpl');


}

//var_dump($page);
