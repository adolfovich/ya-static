<div class="main-content">
    <!-- Top navbar -->

    <!-- Header -->
    <div class="header bg-gradient-primary pb-8 pt-5 pt-md-8">
      <div class="container-fluid">
        <div class="header-body">

        </div>
      </div>
    </div>
    <!-- Page content -->
    <div class="container-fluid mt--7">
      <?php if (isset($arr['error'])) { ?>
        <div class="row">
          <h2 style="text-align: center; color:red;"><?=$arr['error']?></h2>
        </div>
      <?php } else { ?>

      <div class="row">
        <h2 style="text-align: center;"><?=$video['name']?></h2>
      </div>
      <div class="row" style="text-align: center;">
        <div class="embed-responsive embed-responsive-16by9">
          <video style="margin: 0 auto;" src="<?=$video['path']?>" controls></video>
        </div>
      </div>
      <?php } ?>
    </div>
  </div>
