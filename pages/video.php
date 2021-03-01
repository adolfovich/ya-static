<?php

//$video = '';

$leave_time = $db->getOne("SELECT data FROM settings WHERE name = 'once_links_time'");

if (isset($_GET['id']) && $_GET['id'] != '') {
  $hash_data = $db->getRow("SELECT * FROM `edu_once_links` WHERE hash = ?s", $_GET['id']);

  if ($hash_data) {

    if ($hash_data['id_video']) {

      if ((strtotime($hash_data['date']) + ($leave_time * 60)) > time()) {
        $video = $db->getRow("SELECT * FROM edu_videos WHERE id = ?i", $hash_data['id_video']);
        $dopFiles = $db->getAll("SELECT * FROM edu_videos_files WHERE video_id = ?i AND deleted = 0", $video['id']);

      } else {
        $arr['error'] = 'Ошибка. Время действия ссылки истекло.';
      }
    } else if ($hash_data['id_subcat']) {

      if (isset($_GET['video'])) {
        $video = $db->getRow("SELECT * FROM edu_videos WHERE id = ?i", $_GET['video']);
        $dopFiles = $db->getAll("SELECT * FROM edu_videos_files WHERE video_id = ?i AND deleted = 0", $video['id']);
      } else {
        $videos = $db->getAll("SELECT * FROM edu_videos WHERE subcat = ?i", $hash_data['id_subcat']);
      }

    } else if ($hash_data['id_cat']) {

      if ((strtotime($hash_data['date']) + ($leave_time * 60)) > time()) {
        if (isset($_GET['subcat'])) {
          if (isset($_GET['video'])) {
            $video = $db->getRow("SELECT * FROM edu_videos WHERE id = ?i", $_GET['video']);
            $dopFiles = $db->getAll("SELECT * FROM edu_videos_files WHERE video_id = ?i AND deleted = 0", $video['id']);
          } else {
            $videos = $db->getAll("SELECT * FROM edu_videos WHERE subcat = ?i", $_GET['subcat']);
          }

        } else {
          $subcats = $db->getAll("SELECT * FROM edu_subcategories WHERE cat = ?i", $hash_data['id_cat']);
        }

        //var_dump($subcats);

      } else {
        $arr['error'] = 'Ошибка. Время действия ссылки истекло.';
      }

    }





  } else {
    $arr['error'] = 'Ошибка. Неверная ссылка.';
  }
}

include ('tpl/video.tpl');
