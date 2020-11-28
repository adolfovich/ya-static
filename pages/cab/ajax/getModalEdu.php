<?php

require_once('connect.php');

$arr['response'] = '';

if (isset($_POST['type']) && isset($_POST['id'])) {
  if ($_POST['type'] == 'editCat') {

    $cat_data = $db->getRow("SELECT * FROM edu_categories WHERE id = ?i", $_POST['id']);
    $profiles = $db->getAll("SELECT * FROM profiles WHERE is_del = 0");

    $arr['response'] .= '<div class="form-group">';
    $arr['response'] .= '<input type="hidden" name="catId" value="'.$cat_data['id'].'">';
    $arr['response'] .= '<label for="catName">Название</label>';
    $arr['response'] .= '<input type="text" name="catName" class="form-control" id="catName" placeholder="Название" value="'.$cat_data['name'].'">';
    $arr['response'] .= '</div>';
    $arr['response'] .= '';
    $arr['response'] .= '<div class="form-group">';
    $arr['response'] .= '<label for="catName">Профили</label>';
    foreach ($profiles as $profile) {
      $arr['response'] .= '<div class="form-check">';

      if (in_array($profile['id'], explode(",", $cat_data['access']))) {
        $checked = 'checked';
      } else {
        $checked = '';
      }
      $arr['response'] .= '<input name="profiles[]" class="form-check-input" type="checkbox" '.$checked.' value="'.$profile['id'].'" id="profiles'.$profile['id'].'">';
      $arr['response'] .= '<label class="form-check-label" for="profiles'.$profile['id'].'">';
      $arr['response'] .= $profile['name'];
      $arr['response'] .= '</label>';
      $arr['response'] .= '</div>';
    }

    $arr['response'] .= '</div>';

  } else if ($_POST['type'] == 'deleteCat') {
    $cat_data = $db->getRow("SELECT * FROM edu_categories WHERE id = ?i", $_POST['id']);

    $arr['response'] .= '<input type="hidden" name="catId" value="'.$cat_data['id'].'">';
    $arr['response'] .= '<div class="row">';
    $arr['response'] .= '<div class="col text-center">Подтвердите удаление категории "'.$cat_data['name'].'"</div>';
    $arr['response'] .= '</div>';
    $arr['response'] .= '';
  } else if ($_POST['type'] == 'editSubcat') {
    $subcat_data = $db->getRow("SELECT * FROM edu_subcategories WHERE id = ?i", $_POST['id']);
    $arr['response'] .= '<div class="form-group">';
    $arr['response'] .= '<input type="hidden" name="subCatId" value="'.$subcat_data['id'].'">';
    $arr['response'] .= '<label for="subCatName">Название</label>';
    $arr['response'] .= '<input type="text" name="subCatName" class="form-control" id="subCatName" placeholder="Название" value="'.$subcat_data['name'].'">';
    $arr['response'] .= '</div>';
    $arr['response'] .= '';
  } else if ($_POST['type'] == 'deleteSubcat') {
    $subcat_data = $db->getRow("SELECT * FROM edu_subcategories WHERE id = ?i", $_POST['id']);

    $arr['response'] .= '<input type="hidden" name="subCatId" value="'.$subcat_data['id'].'">';
    $arr['response'] .= '<div class="row">';
    $arr['response'] .= '<div class="col text-center">Подтвердите удаление подкатегории "'.$subcat_data['name'].'"</div>';
    $arr['response'] .= '</div>';
    $arr['response'] .= '';
  } else if ($_POST['type'] == 'editVideo') {
    $video_data = $db->getRow("SELECT * FROM edu_videos WHERE id = ?i", $_POST['id']);

    $arr['response'] .= '<div class="form-group">';
    $arr['response'] .= '<input type="hidden" name="videotId" value="'.$video_data['id'].'">';
    $arr['response'] .= '<label for="videoName">Название</label>';
    $arr['response'] .= '<input type="text" name="videoName" class="form-control" id="videoName" placeholder="Название" value="'.$video_data['name'].'">';
    $arr['response'] .= '</div>';
    $arr['response'] .= '';
  } else if ($_POST['type'] == 'deleteVideo') {
    $video_data = $db->getRow("SELECT * FROM edu_videos WHERE id = ?i", $_POST['id']);

    $arr['response'] .= '<input type="hidden" name="videotId" value="'.$video_data['id'].'">';
    $arr['response'] .= '<div class="row">';
    $arr['response'] .= '<div class="col text-center">Подтвердите удаление видео "'.$video_data['name'].'"</div>';
    $arr['response'] .= '</div>';
    $arr['response'] .= '';
  }
} else {
  $arr['error'] = 'Ошибка. Неверные данные.';
}

echo $core->returnJson($arr);
