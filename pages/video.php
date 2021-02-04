<?php

//$video = '';

if (isset($_GET['id']) && $_GET['id'] != '') {
  $hash_data = $db->getRow("SELECT * FROM `edu_once_links` WHERE hash = ?s", $_GET['id']);

  if ($hash_data) {
    $leave_time = $db->getOne("SELECT data FROM settings WHERE name = 'once_links_time'");
    //var_dump(strtotime($hash_data['date']) + ($leave_time * 60));
    //echo '<br>';
    //var_dump(time());
    if ((strtotime($hash_data['date']) + ($leave_time * 60)) > time()) {
      $video = $db->getRow("SELECT * FROM edu_videos WHERE id = ?i", $hash_data['id_video']);
      //var_dump($video);
      $dopFiles = $db->getAll("SELECT * FROM edu_videos_files WHERE video_id = ?i AND deleted = 0", $video['id']);

    } else {
      $arr['error'] = 'Ошибка. Время действия ссылки истекло.';
    }
  } else {
    $arr['error'] = 'Ошибка. Неверная ссылка.';
  }
}

include ('tpl/video.tpl');
