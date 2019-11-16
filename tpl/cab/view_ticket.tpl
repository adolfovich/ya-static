

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
            <div class="card-header bg-transparent" style="padding-bottom: 0;">
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
              <form>
                <div class="form-group row">
                  <label class="col-sm-3 col-form-label">Тип заявки:</label>
                  <div class="col-sm-8">
                    <input type="text" class="form-control" value="<?=$ticket['type_name']?>" disabled>
                  </div>
                </div>
                <?php
                  foreach ($data as $key => $value) {
                    $feeld = $db->getRow("SELECT * FROM tickets_fields WHERE id = ?i", $key);
                    ?>
                    <div class="form-group row">
                      <label class="col-sm-3 col-form-label"><?=$feeld['name']?>:</label>
                      <div class="col-sm-8">
                        <?php if ($feeld['type'] != 'textarea') { ?>
                        <input type="<?=$feeld['type']?>" class="form-control" value="<?=$value?>" disabled>
                        <?php } else { ?>
                        <textarea class="form-control" rows="5" disabled><?=$value?></textarea>
                        <?php } ?>
                      </div>
                    </div>
                    <?php
                  }
                ?>
              </form>


            </div>
          </div>

        </div>
      </div>

      <?php include ('tpl/cab/tpl_footer.tpl'); ?>
    </div>
  </div>
