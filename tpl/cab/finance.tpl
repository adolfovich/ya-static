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
          <div class="modal-body">

            <div class="form-group">
              <label for="opSalon">Салон</label>
              <select class="form-control" id="opSalon" name="opSalon">
                <?php foreach($user_salons as $user_salon) { ?>
                  <option value="<?=$user_salon['id']?>"><?=$user_salon['name']?></option>
                <?php } ?>
              </select>
            </div>

            <div class="form-group">
              <label for="opDete">Дата операции</label>
              <input type="date" name="opDete" class="form-control" id="opDete" placeholder="" value="<?=date("Y-m-d")?>">
            </div>

            <div class="form-group">
              <label for="opType">Тип операции</label>
              <select class="form-control" id="opType" name="opType" onChange="loadDescriptions();">
                <option value="1">Доход</option>
                <option value="2">Расход</option>
              </select>
            </div>

            <div class="form-group">
              <label for="opDesc">Расшифровка</label>
              <select class="form-control" id="opDesc" name="opDesc">
                <option selected disabled>Выберите тип операции</option>
              </select>
            </div>

            <div class="form-group">
              <label for="opAmount">Сумма</label>
              <input type="number" name="opAmount" class="form-control" id="opAmount" placeholder="" >
            </div>

            <div class="form-group">
              <label for="opComment">Комментарий</label>
              <input type="text" name="opComment" class="form-control" id="opComment" placeholder="" >
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

                  <form class="form-inline" id="finForm">
                    <div class="form-group mb-2">
                      <label for="text1" class="sr-only">Период</label>
                      <input type="text" readonly class="form-control-plaintext" id="text1" value="Выбрать период">
                    </div>
                    <div class="form-group mx-sm-3 mb-2">
                      <label for="dateFrom" class="sr-only">с</label>
                      <input type="date" name="dateFrom" class="form-control" id="dateFrom" placeholder="" value="<?=date("Y-m-d", time() - 604800)?>" onChange="loadFinData()">
                    </div>
                    <div class="form-group mb-2">
                      <label for="text2" class="sr-only"></label>
                      <input type="text" style="width: 15px;" readonly class="form-control-plaintext" id="text2" value=" - " >
                    </div>
                    <div class="form-group mx-sm-3 mb-2">
                      <label for="dateTo" class="sr-only">с</label>
                      <input type="date" name="dateTo" class="form-control" id="dateTo" placeholder="" value="<?=date("Y-m-d")?>" onChange="loadFinData()">
                    </div>

                    <div class="form-group mx-sm-3 mb-2">
                      <label for="salon">Салон</label>
                      <select name="salon" id="salon" class="form-control" style="margin-left: 10px; max-width: 140px;" onChange="loadFinData()">
                        <?php
                        if (count($user_salons) <= 1) {
                          ?>
                          <option value="<?=$user_salons[0]['id']?>" selected><?=$user_salons[0]['name']?></option>
                          <?php
                        } else {
                          ?>
                          <option value="all" selected>Все</option>
                          <?php
                          foreach ($user_salons as $user_salon) {
                            ?>
                            <option value="<?=$user_salon['id']?>"><?=$user_salon['name']?></option>
                            <?php
                          }
                        }
                        ?>
                      </select>
                    </div>
                  </form>

                </div>
                <div class="col-md-3 text-right">
                  <button type="submit" class="btn btn-primary mb-2" data-toggle="modal" data-target="#addOperation">Добавить операцию</button>
                  <?php if ($profile_data['edit_finance']) { ?>
                  <a href="finance_settings" class="btn btn-primary mb-2" ><i class="fas fa-cog"></i></a>
                  <?php } ?>
                </div>
              </div>
            </div>
            <div class="card-body">

              <ul class="nav nav-tabs nav-justified" id="myTab" role="tablist">
                <li class="nav-item">
                  <a class="nav-link active" id="expenses-tab" data-toggle="tab" href="#expenses" role="tab" aria-controls="expenses" aria-selected="true" onclick="document.cookie='finTab=expenses'">Расходы</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" id="income-tab" data-toggle="tab" href="#income" role="tab" aria-controls="income" aria-selected="false" onclick="document.cookie='finTab=income'">Доходы</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" id="chart-tab" data-toggle="tab" href="#chart" role="tab" aria-controls="chart" aria-selected="false" onclick="document.cookie='finTab=chart'">График</a>
                </li>
              </ul>
              <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="expenses" role="tabpanel" aria-labelledby="expenses-tab">

                  <table class="table">
                    <thead class="thead-light">
                      <tr>
                        <th scope="col">Салон</th>
                        <th scope="col">Дата</th>
                        <th scope="col">Тип операции</th>
                        <th scope="col">Расшифровка</th>
                        <th scope="col">Сумма</th>
                        <th scope="col">Комментарий</th>
                        <th></th>
                      </tr>
                    </thead>
                    <tbody class="table-striped" id="table-expenses">

                    </tbody>
                  </table>

                </div>
                <div class="tab-pane fade" id="income" role="tabpanel" aria-labelledby="income-tab">

                  <table class="table">
                    <thead class="thead-light">
                      <tr>
                        <th scope="col">Салон</th>
                        <th scope="col">Дата</th>
                        <th scope="col">Тип операции</th>
                        <th scope="col">Расшифровка</th>
                        <th scope="col">Сумма</th>
                        <th scope="col">Комментарий</th>
                        <th></th>
                      </tr>
                    </thead>
                    <tbody class="table-striped" id="table-income">

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

    var descriptoins = JSON.parse('<?=$descriptions?>');

    function loadDescriptions() {
      type = document.getElementById("opType").value;
      descr = document.getElementById("opDesc");
      descr.innerHTML = '';
      for (key in descriptoins[type]) {
        descr.innerHTML += '<option value="'+descriptoins[type][key]+'">'+descriptoins[type][key]+'</option>';
      }
    }

    $(document).ready(function(){
        loadDescriptions();
    })

    function loadChart() {
      $.post(
        "/pages/cab/ajax/loadFinChart.php",
        $("#formChart").serialize()+'&'+$("#finForm").serialize(),
        onAjaxSuccess
      );

      function onAjaxSuccess(data)
      {
        //console.log(data);
        result = JSON.parse(data);
        //console.log(result);

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



    function loadFinData() {
      $.post(
        "/pages/cab/ajax/loadFinData.php",
        $("#finForm").serialize(),
        onAjaxSuccess
      );

      function onAjaxSuccess(data)
      {
        //console.log(data);
        result = JSON.parse(data);
        //console.log(result);

        if (result.status == 'OK') {
          document.getElementById('table-expenses').innerHTML = result.response.expenses; //response
          document.getElementById('table-income').innerHTML = result.response.income;//income

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

    loadFinData();
  </script>
