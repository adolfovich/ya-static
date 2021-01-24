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
        <div class="col-sm-12">
          <div class="card shadow">
            <div class="card-header border-0">
              <div class="row align-items-center">
                <div class="col">
                  <h3 class="mb-0">Список салонов</h3>
                </div>
                <div class="col text-right">
                  <div class="row">
                    <div class="col">
                      <a href="new_salon" class="btn btn-sm btn-primary" style="margin-bottom: 10px;">Добавить салон</a>
                    </div>
                  </div>
                  <?php if ($user_profile['edit_salons']) { ?>
                  <div class="row">
                    <div class="col">
                      <a href="salons_fields" class="btn btn-sm btn-primary" style="margin-bottom: 10px;">Настройка полей</a>
                    </div>
                  </div>
                  <?php } ?>


                </div>

              </div>
            </div>
            <div class="table-responsive">
              <!-- Projects table -->
              <table class="table align-items-center table-flush">
                <thead class="thead-light">
                  <tr>
                    <th scope="col" style="width: 20px;">#</th>
                    <th scope="col" class="text-left">Салон</th>
                    <?php foreach ($fields as $field) { ?>
                      <th scope="col" ><?=$field['name']?></th>
                    <?php } ?>

                    <th style="width: 20px;"></th>
                    <th style="width: 20px;"></th>
                  </tr>
                </thead>
                <tbody>
                  <?php foreach($salons as $salon) { ?>
                  <tr>
                    <th scope="row"><?=$salon['id']?></th>
                    <td class="text-left"><a href="/cab/salon_edit?id=<?=$salon['id']?>" ><?=$salon['name']?></a></td>
                    <?php foreach ($fields as $field) { ?>
                      <td scope="col"><?=$core->getSalonFieldValue($salon['id'], $field['id'])?></td>
                    <?php } ?>
                    <td>
                      <a href="/cab/salon_edit?id=<?=$salon['id']?>" class="mdc-button mdc-button--unelevated">
                        <?php if ($user_profile['edit_salons']) { ?>
                        <i class="fas fa-edit"></i>
                        <?php } else { ?>
                        <i class="far fa-eye"></i>
                        <?php } ?>
                      </a>
                    </td>
                    <td>
                      <?php if ($user_profile['edit_salons']) { ?>
                      <a href="/cab/salons?a=del&id=<?=$salon['id']?>"class="mdc-button mdc-button--unelevated secondary-filled-button mdc-ripple-upgraded">
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
