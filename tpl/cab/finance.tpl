<div class="main-content">

  <style>
  .modal-error {
    text-align: center;
  }
  </style>

  <div class="modal" id="addOperation"  tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <form id="addOperationForm" method="POST">
        <input type="hidden" name="action_type" value="add_operation">

        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Добавлeние операции</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body" style="padding-top: 5px; padding-bottom: 5px;">

            <div class="form-group" style="margin-bottom: 0.5rem;">
              <label for="opSalon">Салон</label>
              <select class="form-control" id="opSalon" name="opSalon">
                <?php foreach($user_salons as $user_salon) { ?>
                  <option value="<?=$user_salon['id']?>"><?=$user_salon['name']?></option>
                <?php } ?>
              </select>
            </div>

            <div class="form-group" style="margin-bottom: 0.5rem;">
              <label for="opDete">Дата операции</label>
              <input type="date" name="opDete" class="form-control" id="opDete" placeholder="" value="<?=date("Y-m-d")?>">
            </div>

            <div class="form-group" style="margin-bottom: 0.5rem;">
              <label for="opType">Тип операции</label>
              <select class="form-control" id="opType" name="opType" onChange="loadDescriptions();">
                <option value="1">Доход</option>
                <option value="2">Расход</option>
                <option value="3">Инкассация</option>
              </select>
            </div>

            <div class="form-group" style="margin-bottom: 0.5rem;">
              <label for="opDesc">Расшифровка</label>
              <select class="form-control" id="opDesc" name="opDesc">
                <option selected disabled>Выберите тип операции</option>
              </select>
            </div>

            <div class="form-group" style="margin-bottom: 0.5rem;">
              <label for="opAmount">Сумма</label>
              <input type="number" name="opAmount" class="form-control" id="opAmount" placeholder="" >
            </div>

            <div class="form-group" style="margin-bottom: 0.5rem;">
              <label for="opComment">Комментарий</label>
              <input type="text" name="opComment" class="form-control" id="opComment" placeholder="" >
            </div>

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
                  <form class="form-inline" id="finForm">
                    <div class="form-row">
                      <div class="form-group mx-sm-3 mb-2">
                        <label for="dateFrom" style="padding-right: 47px;">Период с </label>

                        <input type="date" name="dateFrom" class="form-control" id="dateFrom" placeholder=""
                        value="<?php if(isset($filter['dateFrom'])) {echo date("Y-m-d", strtotime($filter['dateFrom'])); } else { echo date("Y-m-d", (time() - (86400 * 30)));} ?>"
                        onChange="loadFinData()">
                      </div>
                      <div class="form-group mx-sm-3 mb-2">
                        <label for="dateTo" style="padding-right: 30px;"> - </label>
                        <input type="date" name="dateTo" class="form-control" id="dateTo" placeholder=""
                        value="<?php if(isset($filter['dateTo'])) {echo date("Y-m-d", strtotime($filter['dateTo'])); } else { echo date("Y-m-d");} ?>"
                        onChange="loadFinData()">
                      </div>
                    </div>
                    <div class="form-row">
                      <div class="form-group mx-sm-3 mb-2">
                        <label for="salon" style="padding-right: 60px;">Салон</label>
                        <select name="salon" id="salon" class="form-control chosen-select" style="margin-left: 10px; max-width: 140px;" onChange="loadFinData()" >
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
                        <select name="type" id="type" class="form-control" style="margin-left: 10px; max-width: 140px;" onChange="loadDescriptionsFilter(); loadFinData();">
                          <option value="all" <?php if (isset($filter['type']) && $filter['type'] == 'all') echo 'selected'; ?>>Все</option>
                          <option value="2" <?php if (isset($filter['type']) && $filter['type'] == '2') echo 'selected'; ?>>Расходы</option>
                          <option value="1" <?php if (isset($filter['type']) && $filter['type'] == '1') echo 'selected'; ?>>Доходы</option>
                          <option value="3" <?php if (isset($filter['type']) && $filter['type'] == '3') echo 'selected'; ?>>Инкассация</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-row">
                      <div class="form-group mx-sm-3 mb-2">
                        <label for="description">Расшифровка</label>
                        <select name="description" id="description" class="form-control  select2-salon" style="margin-left: 10px; max-width: 140px;" onChange="loadFinData()">
                            <option value="all" selected>Все</option>
                            <?php
                            $selected = '';
                            foreach ($op_descriptions as $op_description) {
                              if (isset($filter['description']) && $filter['description'] == $op_description['id']) {
                                $selected = 'selected';
                              } else {
                                $selected = '';
                              }
                              ?>
                              <option value="<?=$op_description['id']?>" <?=$selected?>><?=$op_description['name']?></option>
                              <?php
                              }
                            ?>
                        </select>
                      </div>
                    </div>
                  </form>
                </div>
                <div class="col-md-4 text-right">
                  <button type="submit" class="btn btn-primary mb-2" data-toggle="modal" data-target="#addOperation">Добавить операцию</button>
                  <?php if ($user_profile['edit_finance']) { ?>
                  <a href="finance_settings" class="btn btn-primary mb-2" ><i class="fas fa-cog"></i></a>
                  <?php } ?>
                  <br>
                  <a href="#" class="btn btn-primary mb-2" onClick="openReport('finForm', '/reports/finance_salons.php')">Отчет по салонам</i></a>
                </div>
              </div>

            </div>
            <div class="card-body">
              <ul class="nav nav-tabs nav-justified" id="myTab" role="tablist">
                <li class="nav-item">
                  <a class="nav-link active" id="operations-tab" data-toggle="tab" href="#operations" role="tab" aria-controls="operations" aria-selected="true" onclick="document.cookie='finTab=operations'">Операции</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" id="chart-tab" data-toggle="tab" href="#chart" role="tab" aria-controls="chart" aria-selected="false" onclick="document.cookie='finTab=chart'">График</a>
                </li>
              </ul>
              <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="operations" role="tabpanel" aria-labelledby="operations-tab">
                  <table class="table table-sm">
                    <thead class="thead-light">
                      <tr>
                        <th scope="col" style="text-align: center;">Салон</th>
                        <th scope="col" style="text-align: center;">Дата</th>
                        <th scope="col" style="text-align: center;">Тип<br>операции</th>
                        <th scope="col" style="text-align: center;">Расшифровка</th>
                        <th scope="col" style="text-align: center;">Сумма</th>
                        <th scope="col" style="text-align: center;">Комментарий</th>
                        <th></th>
                      </tr>
                    </thead>
                    <tbody class="table-striped" id="table-operations">
                    </tbody>
                  </table>
                </div>
                <div class="tab-pane fade" id="chart" role="tabpanel" aria-labelledby="chart-tab">
                  <form id="formChart">
                    <div class="form-group">
                      <label for="chartType">Сортировка</label>
                      <select class="form-control" id="chartType" name="chartType" onChange="loadChart();">
                        <option value="days">По дням</option>
                        <option value="weeks">По неделям</option>
                        <option value="months">По месяцам</option>
                      </select>
                    </div>
                  </form>
                  <div id="finChart"></div>
                </div>
              </div>

            </div>
          </div>
        </div>
      </div>
      <?php include ('tpl/cab/tpl_footer.tpl'); ?>
    </div>
  </div>

  <script>

  <?php if (isset($_COOKIE['finTab'])) { ?>
    activaTab('<?=$_COOKIE['finTab']?>');
  <?php } ?>



  function activaTab(tab){
    $('.nav-tabs a[href="#' + tab + '"]').tab('show');
  };

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

    var descriptoins = JSON.parse('<?=$descriptions?>');

    function loadDescriptions() {
      type = document.getElementById("opType").value;
      descr = document.getElementById("opDesc");
      descr.innerHTML = '';
      for (key in descriptoins[type]) {
        descr.innerHTML += '<option value="'+key+'">'+descriptoins[type][key]+'</option>';
      }
    }

    function loadDescriptionsFilter() {
      type = document.getElementById("type").value;
      descr = document.getElementById("description");
      descr.innerHTML = '<option value="0">Все</option>';
      <?php if (isset($filter['description'])) { ?>
      selectedDescr = '<?=$filter['description']?>';
      <?php } else { ?>
      selectedDescr = '';
      <?php } ?>

      for (key in descriptoins[type]) {
        if (selectedDescr == descriptoins[type][key]) {
          descr.innerHTML += '<option value="'+descriptoins[type][key]+'" selected>'+descriptoins[type][key]+'</option>';
        } else {
          descr.innerHTML += '<option value="'+descriptoins[type][key]+'">'+descriptoins[type][key]+'</option>';
        }
      }
    }

    $(document).ready(function(){

        loadDescriptions();
        loadDescriptionsFilter();
        loadFinData();
    })

    function loadChart() {
      $.post(
        "/pages/cab/ajax/loadFinChart.php",
        $("#formChart").serialize()+'&'+$("#finForm").serialize(),
        onAjaxSuccess
      );

      function onAjaxSuccess(data)
      {
        result = JSON.parse(data);

        if (result.status == 'OK') {
          var options = {
              chart: {
                  height: 350,
                  type: 'line',
                  zoom: {
                    enabled: false,
                  },
                  toolbar: {
                    show: false,
                    autoSelected: 'zoom'
                  }
              },
              series: [
                {
                  name: result.response.chart.element,
                  data: result.response.chart.data
                },{
                  name: result.response.chart.element1,
                  data: result.response.chart.data1
                }
              ],
              dataLabels: {
                  enabled: true
              },
              stroke: {
                  curve: 'straight'
              },
              title: {
                  text: result.response.chart.title,
                  align: 'left'
              },
              xaxis: {
                  categories: result.response.chart.categories,
              },
              grid: {
                row: {
                    colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
                    opacity: 0.5
                },
              },
              markers: {
                size: 4
              },
          }

          document.getElementById('finChart').innerHTML = '';
          var chart = new ApexCharts(
              document.querySelector("#finChart"),
              options
          );
          chart.render()
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

    function setCookieFilter() {
      filterData = $("#finForm").serialize();
      document.cookie='finFilter='+filterData;
    }

    function loadFinData() {

      setCookieFilter();
      $.post(
        "/pages/cab/ajax/loadFinData.php",
        $("#finForm").serialize(),
        onAjaxSuccess
      );

      function onAjaxSuccess(data)
      {

        result = JSON.parse(data);

        if (result.status == 'OK') {
          document.getElementById('table-operations').innerHTML = result.response.operations;
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


  </script>
