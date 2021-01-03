<div class="main-content">

  <style>

  .modal-error {
  text-align: center;
  }

  </style>

  <div class="modal" id="addOperation"  tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <form id="addOperationForm" method="POST" action="finance_settings">
        <input type="hidden" name="action_type" value="add_operation">

        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Новая операция</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">

            <div class="form-group">
              <label for="opSalon">Салон</label>
              <select class="form-control" id="opSalon" name="opSalon">
                <option value="0">Все салоны</option>
                <?php foreach($all_salons as $salon) { ?>
                  <option value="<?=$salon['id']?>"><?=$salon['name']?></option>
                <?php } ?>
              </select>
            </div>

            <div class="form-group">
              <label for="opType">Тип операции</label>
              <select class="form-control" id="opType" name="opType" onChange="loadDescriptions();">
                <option value="debit">Доход</option>
                <option value="credit">Расход</option>
              </select>
            </div>

            <div class="form-group">
              <label for="opName">Название</label>
              <input type="text" name="opName" class="form-control" id="opName" placeholder="" >
            </div>

          </div>

          <div class="modal-error text-danger">
            <?php if (isset($msg) && $msg['type'] == 'error') { echo $msg['text']; } ?>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
            <button type="submit" class="btn btn-primary">Сохранить</button>
          </div>
        </div>
      </form>
    </div>
  </div>

  <?php if (isset($msg) && $msg['type'] == 'error') { ?>
    <script>
      $('#<?=$msg['window']?>').modal('show');
    </script>
  <?php } ?>

    <!-- Top navbar -->
    <?php include ('tpl/cab/tpl_header.tpl'); ?>
    <!-- Header -->
    <div class="header bg-gradient-primary pb-8 pt-5 pt-md-8">
      <?php if (isset($msg) && $msg['type'] == 'success') { ?>
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
      <div class="container-fluid">
        <div class="header-body">

        </div>
      </div>

    <!-- Page content -->

    <div class="container-fluid mt--7">
      <div class="row">
        <div class="col-xl-12 mb-5 mb-xl-0">
          <div class="card shadow">
            <div class="card-header bg-transparent" style="padding-bottom: 0;">
              <div class="row align-items-center">
                <div class="col-md-9">

                  <form method="POST" action="finance_settings" class="form-inline" id="finSettingsForm">
                    <div class="form-group mb-2 col-md-3">
                      <label for="text1" class="sr-only">Поиск по названию</label>
                      <input type="text" readonly class="form-control-plaintext" id="text1" value="Поиск по названию">
                    </div>
                    <div class="form-group mb-2 col-md-7">
                      <label for="opNameSearch" class="sr-only"></label>
                      <input style="width: 100%;" type="text" name="opNameSearch" class="form-control" id="opNameSearch" placeholder="Название операции" value="<?php if (isset($form['opNameSearch'])) echo $form['opNameSearch'] ?>">
                    </div>

                    <button type="submit" class="btn btn-primary mb-2"><i class="fas fa-search"></i></button>


                  </form>

                </div>
                <div class="col-md-3 text-right">

                  <button class="btn btn-primary mb-2" data-toggle="modal" data-target="#addOperation">Новая операция</button>

                </div>

              </div>
            </div>
            <div class="card-body">

              <table class="table">
                <thead class="thead-light">
                  <tr>
                    <th scope="col">Название</th>
                    <th scope="col">Тип</th>
                    <th scope="col">Салон</th>
                    <th scope="col"></th>
                  </tr>
                </thead>
                <tbody class="table-striped" id="table-expenses">
                  <?php
                  if ($operations) {
                  foreach($operations as $operation) {
                    if ($operation['type'] == 'debit') {
                      $op_type = 'Доход';
                    } else {
                      $op_type = 'Расход';
                    }

                    if ($operation['salon']) {
                      $salon_name = $db->getOne("SELECT name FROM salons WHERE id = ?i", $operation['salon']);
                    } else {
                      $salon_name = 'Все';
                    }

                  ?>
                  <tr>
                    <td><?=$operation['name']?></td>
                    <td><?=$op_type?></td>
                    <td><?=$salon_name?></td>
                    <td>
                      <a href="#" class="btn btn-primary"><i class="fas fa-edit"></i></a>
                      <a href="?delete=<?=$operation['id']?>" class="btn btn-danger"><i class="fas fa-trash-alt"></i></a>
                    </td>
                  </tr>
                  <?php }
                  } else { ?>
                    <td colspan="4" Style="text-align: center;"> Не найдено </td>
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
