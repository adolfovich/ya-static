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
                  <h3 class="mb-0">Редактирование пользователя <?=$user_data['name']?></h3>
                </div>
                <div class="col text-right">
                  <a href="#" class="btn btn-sm btn-primary" onClick="document.getElementById('userEdit').submit()">Сохранить</a>
                  <a href="#" class="btn btn-sm btn-primary" onClick="window.location='users'">Закрыть</a>
                </div>

              </div>
            </div>
            <div style="padding-left: 20px; padding-right: 20px;">
            <form id="userEdit" method="POST" action="?a=save&id=<?=$user_data['id']?>">
              <div class="row">
                <div class="col-md-6">
                  <div class="form-group">
                    <input type="text" placeholder="Regular" class="form-control" disabled value="<?=$user_data['login']?>"/>

                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group">
                    <input type="text" class="form-control" name="userName" id="userName" placeholder="ФИО" value="<?=$user_data['name']?>">
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-md-6">
                  <div class="form-group">
                    <input type="password" class="form-control" name="userPass" id="userPass" placeholder="Новый пароль">
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group">
                    <input type="password" class="form-control" name="userRePass" id="userRePass" placeholder="Повтор пароля">
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-md-6">
                  <div class="form-group">
                    <select class="custom-select" name="userProfile">
                      <option selected disabled>Профиль: <?=$user_profile['name']?></option>\
                      <?php foreach($profiles as $profile) { ?>
                        <option value="<?=$profile['id']?>"><?=$profile['name']?></option>
                      <?php } ?>
                    </select>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group">
                    <select class="custom-select" multiple name="userSalons[]">
                      <option disabled>Парикмахерские: </option>
                      <?php foreach($salons as $salon) { ?>
                        <?php if (in_array($salon['id'], $user_salons)) { ?> 
                          <option value="<?=$salon['id']?>" selected><?=$salon['name']?></option>
                        <?php } else { ?>
                          <option value="<?=$salon['id']?>"><?=$salon['name']?></option>
                        <?php } ?>

                      <?php } ?>
                    </select>
                  </div>
                </div>
              </div>
            </form>
            </div>
          </div>
        </div>




      </div>
    <?php include ('tpl/cab/tpl_footer.tpl'); ?>
    </div>
  </div>
