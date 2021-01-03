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
          <div class="card">
            <div class="card-header bg-transparent" style="padding-bottom: 0;">
              <div class="row align-items-center">

                <div class="col">

                  <ul class="nav nav-pills justify-content-end">
                    <li class="nav-item mr-2 mr-md-0">
                      <div class="row">
                        <div class="col-md-12">
                          <div class="form-group">
                            <div class="form-group">
                              <div class="input-group mb-4">
                                <div class="input-group-prepend">
                                  <span class="input-group-text" style="">Салон:</span>
                                </div>
                                <select id="chart_salon" class="form-control" data-toggle="select"  onChange="reloadChart()">

                                  <option value="all" <?php if (isset($_GET['salon']) && $_GET['salon'] == 'all') echo 'selected';?> >Все салоны</option>
                                  <?php foreach($salons as $salon) { ?>
                                    <?php if (in_array($salon['id'], $user_salons) || $user_data['salons'] == 0) { ?>
                                    <option value="<?=$salon['id']?>" <?php if (isset($_GET['salon']) && $_GET['salon'] == $salon['id']) echo 'selected'; ?> ><?=$salon['name']?></option>
                                    <?php } ?>
                                  <?php } ?>
                                </select>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-md-6">
                          <div class="form-group">
                            <div class="input-group mb-4">
                              <div class="input-group-prepend">
                                <span class="input-group-text" style="">С</span>
                              </div>
                              <input id="chart_date_from" name="stat_date_from" type="date" class="form-control" onChange="reloadChart()" value="<?php if (isset($_GET['dateFrom'])) { echo $_GET['dateFrom'];} else { echo date('Y-m-d', time() - (86400 * 7));}?>">
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group">
                            <div class="input-group mb-4">
                              <div class="input-group-prepend">
                                <span class="input-group-text" style="">ПО</span>
                              </div>
                              <input id="chart_date_to" name="stat_date_to" type="date" class="form-control" onChange="reloadChart()" value="<?php if (isset($_GET['dateTo'])) { echo $_GET['dateTo'];} else { echo date('Y-m-d', time() - (86400 * 7));}?>">
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group">
                            <select id="chart_stat" class="form-control" data-toggle="select"  onChange="reloadChart()">
                              <?php foreach($statistics as $statistic) { ?>
                                <?php if (in_array($statistic['id'], $user_stats) || !$user_profile['stat_access']) { ?>
                                <option value="<?=$statistic['string_id']?>" <?php if (isset($_GET['stat']) && $_GET['stat'] == $statistic['string_id']) echo 'selected'; ?> ><?=$statistic['name']?></option>
                                <?php } ?>
                              <?php } ?>
                            </select>
                          </div>
                        </div>
                        <div class="col-md-6">
                        <div class="form-group">
                          <select id="chart_type" class="form-control" data-toggle="select"  onChange="reloadChart()">
                            <option value="by_day">По дням</option>
                            <option value="by_week">По неделям</option>
                            <option value="by_month">По месяцам</option>
                          </select>
                        </div>
                        </div>
                      </div>
                      <div class="row justify-content-end">
                        <div class="col-md-3">
                          <div class="form-group">
                            <button type="button" onClick="editData()" class="btn btn-primary">Редактировать</button>
                          </div>
                        </div>
                        <div class="col-md-3">
                          <div class="form-group">
                            <button type="button" onClick="reloadChart()" class="btn btn-primary">Показать</button>
                          </div>
                        </div>
                      </div>

                    </li>


                    <li class="nav-item mr-2 mr-md-0">

                    </li>
                    <li class="nav-item mr-2 mr-md-0">

                    </li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="card-body">
              <div id="chart"></div>
            </div>
          </div>
        </div>
        <div class="col-xl-4">
          <div class="card shadow">
            <div class="card-header bg-transparent">
              <div class="row align-items-center">
                <div class="col">
                  <h6 class="text-uppercase text-muted ls-1 mb-1"></h6>
                  <h2 class="mb-0">Ввод статистики</h2>
                </div>
              </div>
            </div>
            <div class="card-body">
              <div class="row">
                <div class="col-md-12">
                  <div class="form-group">
                    <label for="selectStatistic">Выберите статистику</label>
                    <select id="selectStatistic" class="form-control has-success" data-toggle="select" onChange="changeStatForm(this.value)">
                      <?php foreach($statistics as $statistic) { ?>
                        <?php if (in_array($statistic['id'], $user_stats) || $user_data['salons'] == 0) { ?>
                        <option value="<?=$statistic['string_id']?>"><?=$statistic['name']?></option>
                        <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                </div>
              </div>
              <?php foreach($statistics as $statistic) { ?>
                <?php if ($i != 1) $form_display = 'display: none;' ?>
                <form id="<?=$statistic['string_id']?>" class="stat_form" style="<?=$form_display?>">
                  <div class="row">
                    <div class="col-md-12">
                      <div class="form-group">
                        <label for="selectStatistic">Выберите салон</label>
                        <select id="<?=$statistic['string_id']?>_stat_salon" class="form-control has-success" data-toggle="select">
                          <?php foreach($salons as $salon) { ?>
                            <?php if (in_array($salon['id'], $user_salons) || $user_data['salons'] == 0) { ?>
                            <option value="<?=$salon['id']?>"><?=$salon['name']?></option>
                            <?php } ?>
                          <?php } ?>
                        </select>
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-md-12">
                      <div class="form-group">
                        <label for="stat_date">Укажите дату</label>
                        <input id="<?=$statistic['string_id']?>_stat_date" name="stat_date" type="date" class="form-control" value="<?=date('Y-m-d')?>">
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-md-12">
                      <div class="form-group">
                        <label for="value">Укажите значение</label>
                        <input type="text" id="<?=$statistic['string_id']?>_value" name="value" class="form-control" placeholder="<?=$statistic['name']?>">
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-md-12">
                      <div class="form-group">
                        <button type="button" onClick="sendStat('<?=$statistic['string_id']?>')" class="btn btn-primary">Отправить</button>
                      </div>
                    </div>
                  </div>
                </form>
                <?php $i++; ?>
              <?php } ?>

              <script>
                function changeStatForm(formId)
                {
                  var forms = document.getElementsByClassName('stat_form');
                  for (let elem of forms) {
                    if (elem.id == formId) {
                      elem.style.display = 'block';
                    } else {
                      elem.style.display = 'none';
                    }
                  }
                }
              </script>
            </div>
          </div>
        </div>
      </div>

      <script>

        function sendStat(statName)
        {
          var statDate = document.getElementById(statName+'_stat_date').value;
          var statValue = document.getElementById(statName+'_value').value;
          var statSalon = document.getElementById(statName+'_stat_salon').value;

          $.post(
            "/pages/cab/ajax/setStat.php",
            {
              stat: statName,
              date: statDate,
              value: statValue,
              salon: statSalon
            },
            onAjaxSuccess
          );

          function onAjaxSuccess(data)
          {
            //console.log(data);
            var result = JSON.parse(data);
            if (result.status == 'OK') {
              Swal.fire({
                title: 'Успешно!',
                text: result.response,
                type: 'success',
                confirmButtonText: 'ОК'
              })
              document.getElementById(statName+'_value').value = '';
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

        function editData()
        {
          var dateFrom = document.getElementById('chart_date_from').value;
          var dateTo = document.getElementById('chart_date_to').value;
          var stat = document.getElementById('chart_stat').value;
          var type = document.getElementById('chart_type').value;
          var salon = document.getElementById('chart_salon').value;

          var url = 'editStat?dateFrom='+dateFrom+'&dateTo='+dateTo+'&stat='+stat+'&type='+type+'&salon='+salon;
          console.log(url);
          window.location.href = url;
        }

        function reloadChart()
        {
          var dateFrom = document.getElementById('chart_date_from').value;
          var dateTo = document.getElementById('chart_date_to').value;
          var stat = document.getElementById('chart_stat').value;
          var type = document.getElementById('chart_type').value;
          var salon = document.getElementById('chart_salon').value;

          $.post(
            "/pages/cab/ajax/getChart.php", 
            {
              date_from: dateFrom,
              date_to: dateTo,
              stat: stat,
              type: type,
              salon: salon
            },
            onAjaxSuccess
          );

          function onAjaxSuccess(data)
          {
            //console.log(data);
            var result = JSON.parse(data);
            document.getElementById('chart').innerHTML = '';

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
                series: [{
                    name: result.element,
                    data: result.data
                }],
                dataLabels: {
                    enabled: true
                },
                stroke: {
                    curve: 'straight'
                },
                title: {
                    text: result.title,
                    align: 'left'
                },
                xaxis: {
                    categories: result.categories,
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

            var chart = new ApexCharts(
                document.querySelector("#chart"),
                options
            );

            chart.render();
          }
        }

        window.onload = function()
        {
            reloadChart();
        }

      </script>

      <?php include ('tpl/cab/tpl_footer.tpl'); ?>
    </div>
  </div>
