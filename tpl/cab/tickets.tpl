<div class="main-content">

  <style>
  .modal-error {
    text-align: center;
  }

  #table-tickets tr {
    cursor: pointer;
  }

  #table-tickets tr:hover {
    background: #eee;
  }


  </style>

  <div class="modal" id="addGeneralPurchase"  tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <form id="addGeneralPurchaseForm" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="action_type" value="addGeneralPurchase">

        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Новая общая закупка</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body" style="padding-top: 5px; padding-bottom: 5px;">

            <div class="form-group" style="margin-bottom: 0.5rem;">
              <label for="generalPurchaseProvider">Поставщик</label>
              <select class="form-control" id="generalPurchaseProvider" name="generalPurchaseProvider">
                <option value="0" selected disabled>Выберите поставщика</option>
                <?php foreach($purchase_providers as $purchase_provider) { ?>
                  <?php if (isset($form['purchaseProvider']) && $form['purchaseProvider'] == $purchase_provider['id']) {
                    $selected_provider = 'selected';
                  } else {
                    $selected_provider = '';
                  }?>
                  <option value="<?=$purchase_provider['id']?>" <?=$selected_provider?>><?=$purchase_provider['name']?></option>
                <?php } ?>
              </select>
            </div>

          </div>

          <div class="modal-error text-danger">
            <?php if (isset($msg) && $msg['type'] == 'error') { echo $msg['text']; } ?>
          </div>
          <div class="modal-footer" style="padding-top: 0.5rem;">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
            <button type="submit" id="addGeneralPurchaseSubmit" class="btn btn-primary">Сохранить</button>
          </div>
        </div>
      </form>
    </div>
  </div>


  <!------------------------------------------>

  <div class="modal" id="addPurchase"  tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <form id="addPurchaseForm" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="action_type" value="addPurchase">

        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Новая закупка</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body" style="padding-top: 5px; padding-bottom: 5px;">

            <div class="form-group" style="margin-bottom: 0.5rem;">
              <label for="purchaseSalon">Салон</label>
              <select class="form-control" id="purchaseSalon" name="purchaseSalon">
                <?php foreach($user_salons as $user_salon) { ?>
                  <?php if (isset($form['purchaseSalon']) && $form['purchaseSalon'] == $user_salon['id']) {
                    $selected_salon = 'selected';
                  } else {
                    $selected_salon = '';
                  }?>
                  <option value="<?=$user_salon['id']?>" <?=$selected_salon?>><?=$user_salon['name']?></option>
                <?php } ?>
              </select>
            </div>

            <div class="form-group" style="margin-bottom: 0.5rem;">
              <label for="purchaseProvider">Поставщик</label>
              <select class="form-control" id="purchaseProvider" name="purchaseProvider" onChange="loadNomenclature(this.value)">
                <option value="0" selected disabled>Выберите поставщика</option>
                <?php foreach($purchase_providers as $purchase_provider) { ?>
                  <?php if (isset($form['purchaseProvider']) && $form['purchaseProvider'] == $purchase_provider['id']) {
                    $selected_provider = 'selected';
                  } else {
                    $selected_provider = '';
                  }?>
                  <option value="<?=$purchase_provider['id']?>" <?=$selected_provider?>><?=$purchase_provider['name']?></option>
                <?php } ?>
              </select>
            </div>

            <script>
            function loadNomenclature(provider) {
              $.post(
                "/pages/cab/ajax/loadNomenclature.php",
                { id: provider },
                onAjaxSuccess
              );

              function onAjaxSuccess(data)
              {
                console.log(data);
                result = JSON.parse(data);

                if (result.status == 'OK') {
                  document.getElementById('nomenclatureList').innerHTML = result.response.html;
                } else {
                  document.getElementById('nomenclatureList').innerHTML = '';
                  Swal.fire({
                    title: 'Ошибка!',
                    text: result.error,
                    type: 'error',
                    confirmButtonText: 'ОК'
                  })
                }
              }
            }
            </script>

            <div class="form-group" id="nomenclatureList">
              <div class="form-row">
                <div class="col text-center">Название</div>
                <div class="col text-center">Прошлая закупка</div>
                <div class="col text-center">Остаток</div>
                <div class="col text-center">Заказ</div>
              </div>


            </div>

          </div>

          <div class="modal-error text-danger">
            <?php if (isset($msg) && $msg['type'] == 'error') { echo $msg['text']; } ?>
          </div>
          <div class="modal-footer" style="padding-top: 0.5rem;">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
            <button type="submit" id="addPurchasSubmit" class="btn btn-primary">Сохранить</button>
          </div>
        </div>
      </form>
    </div>
  </div>
<!----------------------------------------------------------------------------------------------->
  <div class="modal" id="add"  tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <form id="addForm" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="action_type" value="add">

        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Новая заявка</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body" style="padding-top: 5px; padding-bottom: 5px;">

            <div class="form-group" style="margin-bottom: 0.5rem;">
              <label for="ticketSalon">Салон</label>
              <select class="form-control" id="ticketSalon" name="ticketSalon">
                <?php foreach($user_salons as $user_salon) { ?>
                  <?php if (isset($form['ticketSalon']) && $form['ticketSalon'] == $user_salon['id']) {
                    $selected_salon = 'selected';
                  } else {
                    $selected_salon = '';
                  }?>
                  <option value="<?=$user_salon['id']?>" <?=$selected_salon?>><?=$user_salon['name']?></option>
                <?php } ?>
              </select>
            </div>

            <div class="form-group" style="margin-bottom: 0.5rem;">
              <label for="ticketType">Тип заявки</label>
              <select class="form-control" id="ticketType" name="ticketType" >

                <?php foreach($tickets_types as $tickets_type) { ?>
                  <?php if (isset($form['ticketType']) && $form['ticketType'] == $tickets_type['id']) {
                    $selected_type = 'selected';
                  } else {
                    $selected_type = '';
                  }?>
                  <option value="<?=$tickets_type['id']?>" <?=$selected_type?>><?=$tickets_type['name']?></option>
                <?php } ?>
              </select>
            </div>

            <div class="form-group" style="margin-bottom: 0.5rem;">
              <label for="ticketText">Текст заявки</label>
              <textarea name="ticketText" class="form-control" id="ticketText" rows="3"></textarea>
            </div>

            <ul class="list-group">
              <li class="list-group-item">Фото</li>
              <li class="list-group-item" id="dopFiles">
                <div class="form-group">
                  <input type="file" name="dopFile1" class="form-control" id="dopFile1" aria-describedby="dopFileHelp1" >
                  <small id="dopFileHelp1" class="form-text text-muted">Файл должен быть в формате jpg, jpeg, png</small>
                </div>

              </li>
              <li class="list-group-item">
                <a href="#" class="btn btn-outline-primary btn-sm" onClick="addFileField()">Добавить еще один файл</a>
              </li>
            </ul>
          </div>

          <div class="modal-error text-danger">
            <?php if (isset($msg) && $msg['type'] == 'error') { echo $msg['text']; } ?>
          </div>
          <div class="modal-footer" style="padding-top: 0.5rem;">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
            <button type="submit" id="addSubmit" class="btn btn-primary">Сохранить</button>
          </div>
        </div>
      </form>
    </div>
  </div>
<script>
$( "#addSubmit" ).click(function() {
  $( "#addSubmit" ).prop('disabled', true);
  $( "#addSubmit" ).text( 'Подождите...' );
  $( "#addForm" ).submit();
});
</script>

<!--
  <div class="modal" id="editOperation"  tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <form id="editOperationForm" method="POST">
        <input type="hidden" name="action_type" value="edit_operation">

        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Изменение операции</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body" id="editOperationBody" style="padding-top: 5px; padding-bottom: 5px;">

          </div>
          <div class="modal-error text-danger">
            <?php if (isset($msg) && $msg['type'] == 'error') { echo $msg['text']; } ?>
          </div>
          <div class="modal-footer" style="padding-top: 0.5rem;">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
            <button type="submit" class="btn btn-primary">Сохранить</button>
          </div>
        </div>
      </form>
    </div>
  </div>
-->
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
                <div class="col-md-8">
                  <form class="form-inline" id="ticketForm">
                    <div class="form-row">
                      <div class="form-group mx-sm-3 mb-2">
                        <label for="dateFrom" style="padding-right: 47px;">Период с </label>

                        <input type="date" name="dateFrom" class="form-control" id="dateFrom" placeholder=""
                        value="<?php if(isset($filter['dateFrom'])) {echo date("Y-m-d", strtotime($filter['dateFrom'])); } else { echo date("Y-m-d", (time() - (86400 * 30)));} ?>"
                        onChange="loadTicketData()">
                      </div>
                      <div class="form-group mx-sm-3 mb-2">
                        <label for="dateTo" style="padding-right: 30px;"> - </label>
                        <input type="date" name="dateTo" class="form-control" id="dateTo" placeholder=""
                        value="<?php if(isset($filter['dateTo'])) {echo date("Y-m-d", strtotime($filter['dateTo'])); } else { echo date("Y-m-d");} ?>"
                        onChange="loadTicketData()">
                      </div>
                    </div>

                    <div class="form-row">
                      <div class="form-group mx-sm-3 mb-2">
                        <label for="salon" style="padding-right: 60px;">Салон</label>
                        <select name="salon" id="salon" class="form-control chosen-select" style="margin-left: 10px; max-width: 140px;" onChange="loadTicketData()" >
                          <?php
                          if (count($user_salons) <= 1) {
                            ?>
                            <option value="<?=$user_salons[0]['id']?>" selected><?=$user_salons[0]['name']?></option>
                            <?php
                          } else {
                            ?>
                            <option value="all" selected>Все</option>
                            <?php
                            $selected = '';
                            foreach ($user_salons as $user_salon) {
                              if (isset($filter['salon']) && $filter['salon'] == $user_salon['id']) {
                                $selected = 'selected';
                              } else {
                                $selected = '';
                              }
                              ?>
                              <option value="<?=$user_salon['id']?>" <?=$selected?>><?=$user_salon['name']?></option>
                              <?php
                            }
                          }
                          ?>
                        </select>
                      </div>


                      <div class="form-group mx-sm-3 mb-2">
                        <label for="type">Тип</label>
                        <select name="type" id="type" class="form-control" style="margin-left: 10px; max-width: 140px;" onChange="loadTicketData();">
                          <option value="0" <?php if (isset($filter['type']) && $filter['type'] == '0') echo 'selected'; ?>>Все</option>
                          <option value="1" <?php if (isset($filter['type']) && $filter['type'] == '1') echo 'selected'; ?>>Заявки</option>
                          <option value="2" <?php if (isset($filter['type']) && $filter['type'] == '2') echo 'selected'; ?>>Закупки</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-row">
                      <div class="form-group mx-sm-3 mb-2">
                        <label for="status">Статус</label>
                        <select name="status" id="status" class="form-control  select2-salon" style="margin-left: 10px; max-width: 140px;" onChange="loadTicketData()">
                            <option value="0" selected>Все</option>
                            <?php
                            $selected = '';
                            foreach ($tickets_statuses as $tickets_status) {
                              if (isset($filter['status']) && $filter['status'] == $tickets_status['id']) {
                                $selected = 'selected';
                              } else {
                                $selected = '';
                              }
                              ?>
                              <option value="<?=$tickets_status['id']?>" <?=$selected?>><?=$tickets_status['name']?></option>
                              <?php
                            }
                            ?>
                        </select>
                      </div>
                    </div>
                  </form>
                  <div class="form-row">
                    <div class="form-group mx-sm-3 mb-2">
                      <a href="#" class="btn btn-primary mb-2" onClick="loadTicketData()">Применить</a>
                    </div>
                  </div>
                </div>
                <div class="col-md-4 text-right">
                  <button class="btn btn-primary mb-2" data-toggle="modal" data-target="#add">Новая заявка</button>
                  <button class="btn btn-primary mb-2" data-toggle="modal" data-target="#addPurchase">Новая закупка</button>

                  <button class="btn btn-primary mb-2" data-toggle="modal" data-target="#addGeneralPurchase">Сформировать закупку</button>

                  <?php if ($user_profile['edit_finance']) { ?>
                  <a href="tickets_settings" class="btn btn-primary mb-2" ><i class="fas fa-cog"></i></a>
                  <?php } ?>
                  <br>

                </div>
              </div>

            </div>
            <div class="card-body">

                  <table class="table table-sm">
                    <thead class="thead-light">
                      <tr>
                        <th scope="col" style="text-align: center;">Номер</th>
                        <th scope="col" style="text-align: center;">Дата создания</th>
                        <th scope="col" style="text-align: center;">Салон</th>
                        <th scope="col" style="text-align: center;">Тип</th>
                        <th scope="col" style="text-align: center;">Статус</th>
                        <th scope="col" style="text-align: center;">Время выполнения</th>
                        <th scope="col" style="text-align: center;">Последнее изменение</th>

                      </tr>
                    </thead>
                    <tbody class="table-striped" id="table-tickets">
                    </tbody>
                  </table>

            </div>
          </div>
        </div>
      </div>
      <?php include ('tpl/cab/tpl_footer.tpl'); ?>
    </div>
  </div>

  <script>
  function addFileField() {
    countFileFields = $("#dopFiles .form-group").length;
    fileFields = document.getElementById("dopFiles");
    newFieldNum = countFileFields + 1;

    newElems = $('<div class="form-group"><input type="file" name="dopFile'+newFieldNum+'" class="form-control" id="dopFile'+newFieldNum+'" aria-describedby="dopFileHelp'+newFieldNum+'" ><small id="dopFileHelp'+newFieldNum+'" class="form-text text-muted">Файл должен быть в формате MP3, Word, Excel, PDF</small></div>')

    $('#dopFiles').append(newElems);
  }

  function editOperation(opId) {
    //console.log(opId);
    $.post(
      "/pages/cab/ajax/loadOpData.php",
      { id: opId },
      onAjaxSuccess
    );

    function onAjaxSuccess(data)
    {
      result = JSON.parse(data);
      if (result.status == 'OK') {
        document.getElementById('editOperationBody').innerHTML = result.response.html;
        $('#editOperation').modal('show');
        loadChart();
      } else {
        Swal.fire({
          title: 'Ошибка!',
          text: result.error,
          type: 'error',
          confirmButtonText: 'ОК'
        })
      }
    }
  }

    $(document).ready(function(){
        loadTicketData();
    });

    function setCookieFilter() {
      filterData = $("#ticketForm").serialize();
      document.cookie='finFilter='+filterData;
    }

    function loadTicketData() {

      setCookieFilter();
      $.post(
        "/pages/cab/ajax/loadTicketData.php",
        $("#ticketForm").serialize(),
        onAjaxSuccess
      );

      function onAjaxSuccess(data)
      {
        console.log(data);
        result = JSON.parse(data);

        if (result.status == 'OK') {
          document.getElementById('table-tickets').innerHTML = result.response.tickets;
          //loadChart();
        } else {
          Swal.fire({
            title: 'Ошибка!',
            text: result.error,
            type: 'error',
            confirmButtonText: 'ОК'
          })
        }
      }
    }


  </script>
