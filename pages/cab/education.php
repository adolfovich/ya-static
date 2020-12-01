<?php
$accepted_img_types = [
  'image/jpeg',
  'image/png',
  'image/gif'
];

if (isset($_POST['action_type']) && $_POST['action_type'] == 'edit_video') {
  $check_ordering = $db->getRow("SELECT * FROM edu_videos WHERE ordering = ?i", $_POST['videoOrdering']);
  $all_edit_videos = $db->getAll("SELECT * FROM edu_videos WHERE ordering >= ?i AND id != ?i", $_POST['videoOrdering'], $_POST['videotId']);
    $db->query("UPDATE edu_videos SET name = ?s, ordering = ?i WHERE id = ?i", $_POST['videoName'], $_POST['videoOrdering'], $_POST['videotId']);

    if ($check_ordering && $check_ordering['id'] != $_POST['videotId']) {
      foreach ($all_edit_videos as $edit_video) {
        $db->query("UPDATE edu_videos SET ordering = ordering + 1 WHERE id = ?i", $edit_video['id']);
      }
    }
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
  $check_ordering = $db->getRow("SELECT * FROM edu_subcategories WHERE ordering = ?i", $_POST['subCatOrdering']);
  $all_edit_subcats = $db->getAll("SELECT * FROM edu_subcategories WHERE ordering >= ?i AND id != ?i", $_POST['subCatOrdering'], $_POST['subCatId']);
    $db->query("UPDATE edu_subcategories SET name = ?s, ordering = ?i, color = ?s WHERE id = ?i", $_POST['subCatName'], $_POST['subCatOrdering'], $_POST['subCatColor'], $_POST['subCatId']); //

    if ($check_ordering && $check_ordering['id'] != $_POST['subCatId']) {
      foreach ($all_edit_subcats as $edit_subcat) {
        $db->query("UPDATE edu_subcategories SET ordering = ordering + 1 WHERE id = ?i", $edit_subcat['id']);
      }
    }
    $msg['type'] = 'success';
    $msg['text'] = 'Подкатегория сохранена';
}

if (isset($_POST['action_type']) && $_POST['action_type'] == 'delete_subcat') {
  $db->query("UPDATE edu_subcategories SET deleted = 1 WHERE id = ?i", $_POST['subCatId']);
  $msg['type'] = 'success';
  $msg['text'] = 'Подкатегория удалена';
}

/*if (isset($_POST['action_type']) && $_POST['action_type'] == 'edit_subcat') {

    $db->query("UPDATE edu_subcategories SET name = ?s WHERE id = ?i", $_POST['subCatName'], $_POST['subCatId']);
    $msg['type'] = 'success';
    $msg['text'] = 'Подкатегория сохранена';

}*/

if (isset($_POST['action_type']) && $_POST['action_type'] == 'delete_cat') {
  $db->query("UPDATE edu_categories SET deleted = 1 WHERE id = ?i", $_POST['catId']);
  $msg['type'] = 'success';
  $msg['text'] = 'Категория удалена';
}

if (isset($_POST['action_type']) && $_POST['action_type'] == 'edit_cat') {

  $check_ordering = $db->getRow("SELECT * FROM edu_categories WHERE ordering = ?i", $_POST['catOrdering']);
  $all_edit_cats = $db->getAll("SELECT * FROM edu_categories WHERE ordering >= ?i AND id != ?i", $_POST['catOrdering'], $_POST['catId']);

  $profiles = implode(",", $_POST['profiles']);
  $db->query("UPDATE edu_categories SET name = ?s, access = ?s, ordering = ?i, color = ?s WHERE id = ?i", $_POST['catName'], $profiles, $_POST['catOrdering'], $_POST['catColor'], $_POST['catId']);

  if (isset($_FILES['catIcon']) && $_FILES['catIcon']['error'] == 0) {
    if (!in_array($_FILES['catIcon']['type'], $accepted_img_types)) {
      $msg['window'] = 'addCat';
      $msg['type'] = 'error';
      $msg['text'] = 'Неверный формат изображения';
    } else {
      $full_path = dirname(__FILE__);
      $full_path = str_replace('pages/cab', 'caticons/', $full_path);

      $fileTmpPath = $_FILES['catIcon']['tmp_name'];
      $name = $_FILES['catIcon']['name'];
      $dest_path = $full_path . $name;

      $dbpath = '/caticons/'.$name;

      if(move_uploaded_file($fileTmpPath, $dest_path)) {
        $db->query("UPDATE edu_categories SET icon = ?s WHERE id = ?i", $dbpath, $_POST['catId']);
      }
    }
  }

  if ($check_ordering && $check_ordering['id'] != $_POST['catId']) {
    foreach ($all_edit_cats as $edit_cat) {
      $db->query("UPDATE edu_categories SET ordering = ordering + 1 WHERE id = ?i", $edit_cat['id']);
    }
  }
      unset($_POST);
      $msg['type'] = 'success';
      $msg['text'] = 'Категория сохранена';
}



if (isset($_POST['action_type']) && $_POST['action_type'] == 'add_cat') {
  //var_dump($_POST);
  if ($_POST['catName'] != '') {
    if (isset($_POST['profiles']) && count($_POST['profiles']) > 0) {

      if (isset($_FILES['catIco']) && $_FILES['catIco']['error'] == 0) { //&& $_FILES['videoFile']['error'] == 0
        //var_dump(in_array($_FILES['catIco']['type'], $accepted_img_types));
        if (!in_array($_FILES['catIco']['type'], $accepted_img_types)) {
          $msg['window'] = 'addCat';
          $msg['type'] = 'error';
          $msg['text'] = 'Неверный формат изображения';
        } else {

          $full_path = dirname(__FILE__);
          $full_path = str_replace('pages/cab', 'caticons/', $full_path);

          $fileTmpPath = $_FILES['catIco']['tmp_name'];
          $name = $_FILES['catIco']['name'];
          $dest_path = $full_path . $name;

          $dbpath = '/caticons/'.$name;

          if(move_uploaded_file($fileTmpPath, $dest_path)) {

            if ($_POST['catOrdering'] == '') $_POST['catOrdering'] = 100;

            $profiles = implode(",", $_POST['profiles']);
            $db->query("INSERT INTO edu_categories SET name = ?s, access = ?s, color = ?s, ordering = ?i, icon = ?s", $_POST['catName'], $profiles, $_POST['catColor'], $_POST['catOrdering'], $dbpath);
            $new_cat_id = $db->insertId();



            $check_ordering = $db->getRow("SELECT * FROM edu_categories WHERE ordering = ?i", $_POST['catOrdering']);
            $all_edit_cats = $db->getAll("SELECT * FROM edu_categories WHERE ordering >= ?i AND id != ?i", $_POST['catOrdering'], $new_cat_id);

            if ($check_ordering) {
              foreach ($all_edit_cats as $edit_cat) {
                $db->query("UPDATE edu_categories SET ordering = ordering + 1 WHERE id = ?i", $edit_cat['id']);
              }
            }

          } else {
            $msg['window'] = 'addCat';
            $msg['type'] = 'error';
            $msg['text'] = 'Ошибка копирования';
          }




          unset($_POST);
          $msg['type'] = 'success';
          $msg['text'] = 'Категория успешно добавлена';
        }
      }



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
  if ($_POST['subCatName'] != '') {
    if ($_POST['subCatOrdering'] == '') $_POST['subCatOrdering'] = 100;
    $db->query("INSERT INTO edu_subcategories SET name = ?s, cat = ?i, color = ?s, ordering = ?i", $_POST['subCatName'], $_POST['cat'], $_POST['subCatColor'], $_POST['subCatOrdering']);
    $new_subcat_id = $db->insertId();

    $check_ordering = $db->getRow("SELECT * FROM edu_subcategories WHERE ordering = ?i", $_POST['subCatOrdering']);
    $all_edit_subcats = $db->getAll("SELECT * FROM edu_subcategories WHERE ordering >= ?i AND id != ?i", $_POST['subCatOrdering'], $new_subcat_id);

    if ($check_ordering) {
      foreach ($all_edit_subcats as $edit_subcat) {
        $db->query("UPDATE edu_subcategories SET ordering = ordering + 1 WHERE id = ?i", $edit_subcat['id']);
      }
    }


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
