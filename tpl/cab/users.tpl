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
        <div class="col-sm-8">
          <div class="card shadow">
            <div class="card-header border-0">
              <div class="row align-items-center">
                <div class="col">
                  <h3 class="mb-0">Список пользователей</h3>
                </div>
                <div class="col text-right">
                  <a href="new_user" class="btn btn-sm btn-primary">Добавить пользователя</a>
                  <a href="users?a=all_users" class="btn btn-sm btn-primary">Показать уволеных</a>
                </div>

              </div>
            </div>
            <div class="table-responsive">
              <!-- Projects table -->
              <table class="table align-items-center table-flush">
                <thead class="thead-light">
                  <tr>
                    <th scope="col" style="width: 20px;">#</th>
                    <th scope="col" class="text-left">ФИО</th>
                    <th scope="col" >Салоны</th>
                    <th scope="col" >Профиль</th>
                    <th style="width: 20px;"></th>
                    <th style="width: 20px;"></th>
                  </tr>
                </thead>
                <tbody>
                  <?php foreach($users as $user) { ?>
                  <tr>
                    <th scope="row"><?=$user['id']?></th>
                    <td class="text-left"><a href="/cab/user_edit?id=<?=$user['id']?>"><?=$user['name']?></a></td>
                    <td><?=getUserSalons($user['salons'])?></td>
                    <td><?=$user['profileName']?></td>
                    <td>
                      <?php if ($user['id'] != 1) { ?>
                      <a href="/cab/user_edit?id=<?=$user['id']?>" class="mdc-button mdc-button--unelevated">
                        <i class="fas fa-user-edit"></i>
                      </a>
                    <?php } ?>
                    </td>
                    <td>
                      <?php if ($user['id'] != 1) { ?>
                        <?php if ($user['status'] == 1) { ?>
                      <a href="/cab/users?a=del&id=<?=$user['id']?>"class="mdc-button mdc-button--unelevated secondary-filled-button mdc-ripple-upgraded">
                        <i class="fas fa-user-minus"></i>
                      </a>
                    <?php }} ?>
                    </td>
                  </tr>
                  <?php } ?>

                </tbody>
              </table>
            </div>
          </div>
        </div>

        <div class="col-sm-4">
          <div class="card shadow">
            <div class="card-header border-0">
              <div class="row align-items-center">
                <div class="col">
                  <h3 class="mb-0">Профили</h3>
                </div>
                <div class="col text-right">
                  <a href="new_profile" class="btn btn-sm btn-primary">Добавить профиль</a>
                </div>

              </div>
            </div>
            <div class="table-responsive">
              <table class="table align-items-center table-flush">
                <thead class="thead-light">
                  <tr>
                    <th scope="col" class="text-left">Название</th>
                    <th style="width: 20px;"></th>
                    <th style="width: 20px;"></th>
                  </tr>
                </thead>
                <tbody>
                  <?php foreach ($profiles as $profile) { ?>
                    <tr>
                      <th scope="row"><?=$profile['name']?></th>
                      <td>
                        <?php if ($profile['id'] != 1) { ?>
                          <a href="/cab/profile_edit?id=<?=$profile['id']?>"class="mdc-button mdc-button--unelevated secondary-filled-button mdc-ripple-upgraded">
                            <i class="fas fa-edit"></i>
                          </a>
                        <?php } ?>
                      </td>
                      <td>
                        <?php if ($profile['id'] != 1) { ?>
                          <a href="/cab/users?a=del_profile&id=<?=$profile['id']?>"class="mdc-button mdc-button--unelevated secondary-filled-button mdc-ripple-upgraded">
                            <i class="fas fa-trash-alt"></i>
                          </a>
                        <?php } ?>
                      </td>
                    </tr>
                  <?php } ?>

                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    <?php include ('tpl/cab/tpl_footer.tpl'); ?>
    </div>
  </div>
