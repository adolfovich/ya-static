<div class="main-content">
    <!-- Top navbar -->
    <?php include ('tpl/cab/tpl_header.tpl'); ?>
    <!-- Header -->
    <div class="header bg-gradient-primary pb-8 pt-5 pt-md-8">
      <?php if (isset($msg)) { ?>
        <div class="row" style="padding-left: 40px; padding-right: 40px;">
          <div class="col-sm-8">
            <div class="alert alert-<?=$msg['type']?> alert-dismissible fade show" role="alert">
                <span class="alert-inner--icon"></span>
                <span class="alert-inner--text"><?=$msg['text']?></span>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
          </div>
        </div>
      <?php } ?>
    </div>
    <!-- Page content -->
    <div class="container-fluid mt--7">
      <div class="row">
        <div class="col">
          <div class="card shadow">
            <div class="card-header border-0">
              <div class="row align-items-center">
                <div class="col">
                  <h3 class="mb-0">Редактирование профиля: <?=$profile_data['name']?></h3>
                </div>
                <div class="col text-right">
                  <a href="#" class="btn btn-sm btn-primary" onClick="document.getElementById('profileEdit').submit()">Сохранить</a>
                  <a href="#" class="btn btn-sm btn-primary" onClick="window.location='users'">Закрыть</a>
                </div>

              </div>
            </div>
            <div style="padding-left: 20px; padding-right: 20px;">
            <form id="profileEdit" method="POST" action="?a=save&id=<?=$profile_data['id']?>">
              <div class="row">

                <div class="col-md-6">
                  <div class="form-group">
                    <input type="text" class="form-control" name="profileName" id="userName" placeholder="Название профиля" value="<?=$profile_data['name']?>">
                  </div>
                </div>
              </div>
              <div class="card-header border-0">
                <div class="row align-items-center">
                  <div class="col">
                    <h3 class="mb-0">Разрешения:</h3>
                  </div>

                </div>
              </div>
              <?php foreach ($menu as $value) {?>
                <?php if (in_array($value['id'], $access)) {$checked = 'checked';} else {$checked = '';} ?>
              <div class="row">
                <div class="col-md-6">
                  <div class="form-group">
                    <div class="custom-control custom-switch">
                      <input name="access[]" type="checkbox" value="<?=$value['id']?>" class="custom-control-input" id="customSwitch<?=$value['id']?>" <?=$checked?>>
                      <label class="custom-control-label" for="customSwitch<?=$value['id']?>"><?=$value['name']?></label>
                    </div>
                  </div>
                </div>
              </div>
              <?php } ?>


            </form>
            </div>
          </div>
        </div>




      </div>
    <?php include ('tpl/cab/tpl_footer.tpl'); ?>
    </div>
  </div>
