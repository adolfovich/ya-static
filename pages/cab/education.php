<?php


if (isset($_POST['action_type']) && $_POST['action_type'] == 'edit_video') {
    $db->query("UPDATE edu_videos SET name = ?s WHERE id = ?i", $_POST['videoName'], $_POST['videotId']);
    $msg['type'] = 'success';
    $msg['text'] = 'Видеоролик сохранен';
}

if (isset($_POST['action_type']) && $_POST['action_type'] == 'delete_video') {
  $db->query("UPDATE edu_videos SET deleted = 1 WHERE id = ?i", $_POST['videotId']);
  $msg['type'] = 'success';
  $msg['text'] = 'Видеоролик удален';
}

/////////////////////////////////////////////////////////////

if (isset($_POST['action_type']) && $_POST['action_type'] == 'edit_subcat') {
    $db->query("UPDATE edu_subcategories SET name = ?s WHERE id = ?i", $_POST['subCatName'], $_POST['subCatId']);
    $msg['type'] = 'success';
    $msg['text'] = 'Подкатегория сохранена';
}

if (isset($_POST['action_type']) && $_POST['action_type'] == 'delete_subcat') {
  $db->query("UPDATE edu_subcategories SET deleted = 1 WHERE id = ?i", $_POST['subCatId']);
  $msg['type'] = 'success';
  $msg['text'] = 'Подкатегория удалена';
}

if (isset($_POST['action_type']) && $_POST['action_type'] == 'edit_subcat') {

    $db->query("UPDATE edu_subcategories SET name = ?s WHERE id = ?i", $_POST['subCatName'], $_POST['subCatId']);
    $msg['type'] = 'success';
    $msg['text'] = 'Подкатегория сохранена';

}

if (isset($_POST['action_type']) && $_POST['action_type'] == 'delete_cat') {
  $db->query("UPDATE edu_categories SET deleted = 1 WHERE id = ?i", $_POST['catId']);
  $msg['type'] = 'success';
  $msg['text'] = 'Категория удалена';
}

if (isset($_POST['action_type']) && $_POST['action_type'] == 'edit_cat') {

      $profiles = implode(",", $_POST['profiles']);
      $db->query("UPDATE edu_categories SET name = ?s, access = ?s WHERE id = ?i", $_POST['catName'], $profiles, $_POST['catId']);
      unset($_POST);
      $msg['type'] = 'success';
      $msg['text'] = 'Категория сохранена';

}

if (isset($_POST['action_type']) && $_POST['action_type'] == 'add_cat') {
  //var_dump($_POST);
  if ($_POST['catName'] != '') {
    if (isset($_POST['profiles']) && count($_POST['profiles']) > 0) {
      $profiles = implode(",", $_POST['profiles']);
      $db->query("INSERT INTO edu_categories SET name = ?s, access = ?s", $_POST['catName'], $profiles);
      unset($_POST);
      $msg['type'] = 'success';
      $msg['text'] = 'Категория успешно добавлена';

    } else {
      $msg['window'] = 'addCat';
      $msg['type'] = 'error';
      $msg['text'] = 'Укажите один или несколько профилей';
    }
  } else {
    $msg['window'] = 'addCat';
    $msg['type'] = 'error';
    $msg['text'] = 'Название не может быть пустым';
  }
}

if (isset($_POST['action_type']) && $_POST['action_type'] == 'add_subcat') {
  if ($_POST['catName'] != '') {
    $db->query("INSERT INTO edu_subcategories SET name = ?s, cat = ?i", $_POST['catName'], $_POST['cat']);
    unset($_POST);
    $msg['type'] = 'success';
    $msg['text'] = 'Категория успешно добавлена';
  } else {
    $msg['window'] = 'addCat';
    $msg['type'] = 'error';
    $msg['text'] = 'Название не может быть пустым';
  }
}

if (isset($_POST['action_type']) && $_POST['action_type'] == 'add_video') {
  if ($_POST['videoName'] != '') {

    $full_path = dirname(__FILE__);
    $full_path = str_replace('pages/cab', 'videos/', $full_path);


    if (isset($_FILES['videoFile']) && $_FILES['videoFile']['error'] == 0 && $_FILES['videoFile']['type'] == 'video/mp4') {

      $fileTmpPath = $_FILES['videoFile']['tmp_name'];
      $name = $_FILES['videoFile']['name'];
      $dest_path = $full_path . $name;
      $dbpath = '/videos/'.$name;

      if(move_uploaded_file($fileTmpPath, $dest_path)) {
        $db->query("INSERT INTO edu_videos SET name = ?s, path = ?s, subcat = ?i", $_POST['videoName'], $dbpath, $_POST['subcat']);
        $msg['type'] = 'success';
        $msg['text'] = 'Видео успешно добавлено';
        unset($_POST);
      } else {
        $msg['window'] = 'addCat';
        $msg['type'] = 'error';
        $msg['text'] = 'Ошибка копирования';
      }

    } else {
      $msg['window'] = 'addCat';
      $msg['type'] = 'error';
      $msg['text'] = 'Не выбран файл или неверный формат файла';
    }

  } else {
    $msg['window'] = 'addCat';
    $msg['type'] = 'error';
    $msg['text'] = 'Название не может быть пустым';
  }
}

//var_dump($auth_user);

if (isset($_GET['cat']) &&  $_GET['cat'] > 0) {
  $cat_data = $db->getRow("SELECT * FROM edu_categories WHERE id = ?i", $_GET['cat']);

  $access_groups = explode(',', $cat_data['access']);



  if ($cat_data) {
    if (in_array($auth_user['profile'], $access_groups)) {
      if (isset($_GET['subcat'])) {
        $subcat_data = $db->getRow("SELECT * FROM edu_subcategories WHERE id = ?i", $_GET['subcat']);

        //var_dump($_GET['video']);

        if (isset($_GET['video'])) {
          $video_data = $db->getRow("SELECT * FROM edu_videos WHERE id = ?i", $_GET['video']);
          if ($video_data) {
            include ('tpl/cab/education_viseo.tpl');
          } else {
            include ('tpl/cab/404.tpl');
          }
        } else {
          if ($subcat_data) {
            $videos = $db->getAll("SELECT * FROM edu_videos WHERE subcat = ?i AND deleted = 0", $_GET['subcat']);
            include ('tpl/cab/education_viseos.tpl');
          } else {
            include ('tpl/cab/404.tpl');
          }
        }
      } else {
        $subcats = $db->getAll("SELECT * FROM edu_subcategories WHERE cat = ?i AND deleted = 0 ORDER BY ordering", $cat_data['id']);
        include ('tpl/cab/education_cat.tpl');
      }
    } else {
      include ('tpl/cab/403.tpl');
    }





  } else {
    include ('tpl/cab/404.tpl');
  }


} else {
  $cats = $db->getAll("SELECT * FROM edu_categories WHERE deleted = 0 ORDER BY ordering");

  $profiles = $db->getAll("SELECT * FROM profiles WHERE is_del = 0");

  $icons = $db->getAll("SELECT * FROM icons");
  include ('tpl/cab/education.tpl');
}
