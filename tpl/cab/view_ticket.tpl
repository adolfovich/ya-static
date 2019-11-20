

<div class="main-content">
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
                      <h2 class="mb-0">Заявка #<?=$ticket['id']?>  <span class="badge badge-secondary <?=$ticket['status_color']?>"><?=$ticket['status_name']?></span></h2>
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
                <?php
                  foreach ($data as $key => $value) {
                    $feeld = $db->getRow("SELECT * FROM tickets_fields WHERE id = ?i", $key);
                    if ($ticket['edited']) { $disable = '';} else { $disable = 'disabled'; }
                    ?>
                    <div class="form-group row">
                      <label class="col-sm-3 col-form-label"><?=$feeld['name']?>:</label>
                      <div class="col-sm-8">
                        <?php if ($feeld['type'] != 'textarea') { ?>
                        <input name="field_<?=$feeld['id']?>" type="<?=$feeld['type']?>" class="form-control" value="<?=$value?>" <?=$disable?> onKeyUp="enSaveButton()">
                        <?php } else { ?>
                        <textarea name="field_<?=$feeld['id']?>" class="form-control" rows="5" <?=$disable?> onKeyUp="enSaveButton()"><?=$value?></textarea>
                        <?php } ?>
                      </div>
                    </div>
                    <?php
                  }
                ?>

                <?php if ($user_profile['change_ticket_status'] && $next_statuses[0] != 0) {?>

                  <div class="form-group row">
                    <label class="col-sm-3 col-form-label">Коментарий:</label>
                    <div class="col-sm-8">
                      <textarea name="comment" class="form-control" rows="5" onKeyUp="enSaveButton()"></textarea>
                    </div>
                  </div>

                <div class="form-group row">
                  <label class="col-sm-3 col-form-label">Изменить статус:</label>
                  <div class="col-sm-8">
                    <select name="changeStatus" id="changeStatus" class="form-control has-success" data-toggle="select" onChange="enSaveButton()">
                      <option selected disabled>---</option>
                      <?php foreach($next_statuses as $status) { ?>
                        <?php $status_info = $core->getTicketStatusInfo($status); ?>
                        <option value="<?=$status?>"><?=$status_info['name']?></option>
                      <?php } ?>
                    </select>
                  </div>
                </div>
                <?php } ?>

                <?php if ($ticket['edited'] || $user_profile['change_ticket_status']) { ?>
                  <?php if ($next_statuses[0] != 0) {?>
                  <div class="form-group"><button id="saveButton" type="submit" onclick="" class="btn btn-primary" disabled>Сохранить</button></div>
                  <?php } ?>
                <?php } ?>
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
                  <div class="alert alert-info" role="alert">
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
      text: 'Изменения созранены',
      type: 'success',
      confirmButtonText: 'ОК'
    })
    </script>
  <?php } ?>
