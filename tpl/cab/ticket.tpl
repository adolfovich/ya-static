

<div class="main-content">
  <style>
  .hovered-tr:hover {
    background: #ddd;
    cursor: pointer;
  }
  </style>
    <!-- Top navbar -->
    <?php include ('tpl/cab/tpl_header.tpl'); ?>
    <!-- Header -->
    <div class="header bg-gradient-primary pb-8 pt-5 pt-md-8">
      <div class="container-fluid">
        <div class="header-body">

        </div>
      </div>
    </div>
    <!-- Page content -->
    <div class="container-fluid mt--7">
      <div class="row">
        <div class="col-xl-8 mb-5 mb-xl-0">
          <div class="card shadow">
            <div class="card-header bg-transparent" style="/*padding-bottom: 0;*/">
              <div class="row align-items-center">
                <div class="col">
                  <div class="row">
                    <div class="col-md-11">
                      <h6 class="text-uppercase text-muted ls-1 mb-1"></h6>
                      <h2 class="mb-0">Заявка #<?=$ticket['id']?>
                        <span
                          class="status"
                          style="color:<?=$ticket['status_color']?>; background-color:<?=$core->hex2rgba($ticket['status_color'], 0.3)?>">
                            <?=$ticket['status_name']?>
                        </span>
                      </h2>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="card-body">
              <form method="POST">
                <div class="form-group row">
                  <label class="col-sm-3 col-form-label">Тип заявки:</label>
                  <div class="col-sm-8">
                    <input type="text" class="form-control" value="<?=$ticket['type_name']?>" disabled>
                  </div>
                </div>

                <?php if ($ticket['type'] == 0 || $ticket['type'] == 100) { ?>
                <div class="form-group row">
                  <label class="col-sm-3 col-form-label">Поставщик:</label>
                  <div class="col-sm-8">
                    <input type="text" class="form-control" value="<?=$ticket['provider_name']?>" disabled>
                  </div>
                </div>
                <?php } ?>

                <?php if ($next_statuses[0] != 0) {
                  $disabled_inputs = '';
                } else {
                  $disabled_inputs = 'disabled';
                } ?>

                <div class="form-group row" style="margin-bottom: 0.5rem;">
                  <?php if ($ticket['type'] == 0 || $ticket['type'] == 100) { ?>
                    <table class="table">
                      <thead>
                        <tr>
                          <td></td>
                          <th class="text-center">Название</th>
                          <th class="text-center">Прошлая закупка</th>
                          <th class="text-center">Остаток</th>
                          <th class="text-center">Заказ</th>
                        </tr>
                      </thead>

                      <tbody>
                        <?php if ($ticket['type'] == 0) { ?>
                          <?php foreach ($purchases as $purchase) { ?>
                            <tr>
                              <td></td>
                              <td class="align-middle"><?=$purchase['nomenclature']?></td>
                              <td><input type="number" class="form-control" value="<?=$core->previousPurchase($purchase['nomenclature_id'], $ticket['salon_id'])?>" disabled></td>
                              <td><input name="nomenclature[<?=$purchase['nomenclature_id']?>][old]" type="number" class="form-control" min="0" value="<?=$purchase['residue']?>" disabled ></td>
                              <td><input name="nomenclature[<?=$purchase['nomenclature_id']?>][new]" type="number" class="form-control" min="0" value="<?=$purchase['purchase']?>" onKeyUp="enSaveButton()" <?=$disabled_inputs?> ></td>
                            </tr>
                          <?php } ?>
                        <?php } else if ($ticket['type'] == 100) { ?>
                          <?php $count_purchases = $db->getAll("SELECT id, 	nomenclature_id, SUM(residue) AS sum_residue, SUM(purchase) AS sum_purchase, (SELECT name FROM tickets_nomenclature WHERE id = nomenclature_id) as name FROM tickets_purchases WHERE ticket_id IN (?a) GROUP BY nomenclature_id", $purchases); ?>
                          <?php foreach ($count_purchases as $count_purchase) { ?>
                            <tr id="heading<?=$count_purchase['nomenclature_id']?>">
                              <td class="text-center"><a href="#" onClick="$('#hidden<?=$count_purchase['nomenclature_id']?>').toggle();"><i class="fas fa-chevron-down"></i></a></td>
                              <td class="text-center"><?=$count_purchase['name']?></td>
                              <td class="text-center"><?=$core->previousPurchase($count_purchase['nomenclature_id'])?></td>
                              <td class="text-center"><?=$count_purchase['sum_residue']?></td>
                              <td class="text-center"><?=$count_purchase['sum_purchase']?></td>
                            </tr>

                            <?php
                              $nomenclatures = $db->getAll("SELECT tp.*, (SELECT id FROM salons WHERE id = tp.salon_id) as salon_id, (SELECT name FROM salons WHERE id = tp.salon_id) as salon_name FROM tickets_purchases tp WHERE tp.nomenclature_id = ?i AND tp.ticket_id IN (?a)", $count_purchase['nomenclature_id'], $purchases);
                            ?>
                            <tr id="hidden<?=$count_purchase['nomenclature_id']?>" style="display:none;">
                              <td colspan="5">
                              <table class="table">
                                <thead>
                                  <th class="text-center">Салон</th>
                                  <th class="text-center">Прошл. закупка</th>
                                  <th class="text-center">Остаток</th>
                                  <th class="text-center">Заказ</th>
                                </thead>
                                <tbody>
                                  <?php foreach ($nomenclatures as $nomenclature) { ?>
                                    <tr class="hovered-tr" onclick="location.href = 'ticket?id=<?=$nomenclature['ticket_id']?>&return_to=<?=$get['id']?>'">
                                      <td class="text-center"><?=$nomenclature['salon_name']?></td>
                                      <td class="text-center"><?=$core->previousPurchase($nomenclature['nomenclature_id'], $nomenclature['salon_id'])?></td>
                                      <td class="text-center"><?=$nomenclature['residue']?></td>
                                      <td class="text-center"><?=$nomenclature['purchase']?></td>
                                    </tr>
                                  <?php } ?>

                                </tbody>
                              </table>
                            </td>
                            </tr>
                          <?php } ?>

                        <?php } ?>
                      </tbody>
                    </table>



                  <?php } else { ?>
                      <label class="col-sm-3 col-form-label">Комментарий:</label>
                      <div class="col-sm-8" >
                        <textarea class="form-control" rows="3" disabled><?=$ticket['text']?></textarea>
                      </div>


                  <?php } ?>
                </div>


                <div class="content form-group row" >
                  <?php foreach ($ticket_photos as $ticket_photo) { ?>
                    <!--<div class="col">
                      <img src="<?=$ticket_photo['path']?>" style="width: 200px;" />
                    </div>-->
                    <a class="elem" href="<?=$ticket_photo['path']?>" data-lcl-thumb="<?=$ticket_photo['path']?>">
                    	<span style="background-image: url(<?=$ticket_photo['path']?>);"></span>
                    </a>
                  <?php } ?>
                </div>
                <?php if ($comments) { ?>
                <?php foreach($comments as $comment) { ?>
                  <?php $text = trim(str_replace('<span style="text-decoration: underline;">Комментарий</span>:', '', $comment['text'])); ?>
                  <?php if ($text) { ?>
                  <div class="form-group row">
                    <label class="col-sm-3 col-form-label"><?=$comment['user_name']?>:<br><span style="font-size: 0.9em;">(<?=date("d.m.y h:i", strtotime($comment['date']))?>)</span></label>
                    <div class="col-sm-8" style="padding-top: 12px;">
                      <?=$text?>
                    </div>
                  </div>
                  <?php } ?>
                <?php } ?>
                <?php } ?>

                <div class="form-group row">
                  <label class="col-sm-3 col-form-label">Дата выполнения:</label>
                  <div class="col-sm-8">
                    <input type="date" name="lead_time" class="form-control" onChange="enSaveButton()" value="<?php if ($ticket['lead_time']) echo date('Y-m-d', strtotime($ticket['lead_time']))?>" >
                  </div>
                </div>

                <?php if ($next_statuses[0] != 0) {?>

                  <div class="form-group row">
                    <label class="col-sm-3 col-form-label">Добавить коментарий:</label>
                    <div class="col-sm-8">
                      <textarea name="comment" class="form-control" rows="5" onKeyUp="enSaveButton()"></textarea>
                    </div>
                  </div>

                <?php } ?>



                <?php if (($user_profile['change_ticket_status'] && $next_statuses[0] != 0) || $user_profile['change_close_tickets']) {?>

                <div class="form-group row">
                  <label class="col-sm-3 col-form-label">Изменить статус:</label>
                  <div class="col-sm-8">
                    <select name="changeStatus" id="changeStatus" class="form-control has-success" data-toggle="select" onChange="enSaveButton()">
                      <option selected disabled>---</option>
                      <?php $accepted_ticket_statuses = explode(',', $user_profile['accepted_ticket_statuses']); ?>
                      <?php foreach($next_statuses as $status) { ?>
                        <?php if (in_array($status, $accepted_ticket_statuses) || $user_profile['accepted_ticket_statuses'] == 0) { ?>
                          <?php $status_info = $core->getTicketStatusInfo($status); ?>
                          <option value="<?=$status?>"><?=$status_info['name']?></option>
                        <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                </div>
                <?php } ?>

                <div class="form-group">
                  <?php if ($ticket['edited'] || $user_profile['change_ticket_status']) { ?>
                    <?php if ($next_statuses[0] != 0) {?>
                    <button id="saveButton" type="submit" onclick="" class="btn btn-primary" disabled>Сохранить</button>
                    <?php } ?>
                  <?php } ?>
                  <button onclick="location.href = 'tickets'; return false;" class="btn btn-primary" >Закрыть</button>
                  <?php if (isset($get['return_to']) && $get['return_to'] > 0) { ?>
                  <button onclick="location.href = 'ticket?id=<?=$get['return_to']?>'; return false;" class="btn btn-primary" >Вернуться</button>
                  <?php } ?>
                </div>
              </form>


            </div>
          </div>

        </div>

        <div class="col-xl-4">
          <div class="card shadow" >
            <div class="card-header bg-transparent">
              <div class="row align-items-center">
                <div class="col">
                  <h6 class="text-uppercase text-muted ls-1 mb-1"></h6>
                  <h2 class="mb-0">История</h2>
                </div>
              </div>
            </div>
            <div class="card-body" style="max-height: 595px; overflow-x: auto;">
              <div class="row">
                <div class="col-md-12">
                  <?php foreach ($ticket_log as $log) { ?>
                  <div class="alert" role="alert" style="border: 1px solid #ccc;">
                      <b><?=date("d.m H:i", strtotime($log['date']))?> <?=$log['user_name']?></b><br>
                      <?=$log['text']?>
                  </div>
                  <?php } ?>
                </div>
              </div>

              <form id="newTicket">

              </form>

            </div>
          </div>
        </div>
      </div>

      <?php include ('tpl/cab/tpl_footer.tpl'); ?>
    </div>
  </div>


  <script>
    function enSaveButton()
    {
      document.getElementById("saveButton").disabled = false;
    }
  </script>

  <?php if (isset($saved)) { ?>
    <script>
    Swal.fire({
      title: 'Успешно!',
      text: 'Изменения сохранены',
      type: 'success',
      confirmButtonText: 'ОК'
    })
    </script>
  <?php } ?>
