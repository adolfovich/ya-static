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
        <div class="col">
          <div class="card shadow">
            <div class="card-header border-0">
              <div class="row align-items-center">
                <div class="col">
                  <h3 class="mb-0">Редактирование салона</h3>
                </div>
                <div class="col text-right">
                  <?php if (!$disabled) { ?>
                  <a href="#" class="btn btn-sm btn-primary" onClick="document.getElementById('salonEdit').submit()">Сохранить</a>
                  <?php } ?>
                  <a href="#" class="btn btn-sm btn-primary" onClick="window.location='salons'">Закрыть</a>
                </div>

              </div>
            </div>
            <div style="padding-left: 20px; padding-right: 20px;">
            <form id="salonEdit" method="POST" action="?a=save&id=<?=$salon_data['id']?>">
              <div class="row" style="padding-bottom: 20px;">
                <div class="col-md-6">

                  <div class="form-group" style="margin-bottom: 1.5rem !important;">
                    <div class="custom-control custom-switch">
                      <input name="franchising" type="checkbox" value="1" class="custom-control-input" id="customSwitch_edit_franchising" <?php if ($salon_data['franchising']) echo 'checked';?> <?=$disabled?> >
                      <label class="custom-control-label" for="customSwitch_edit_franchising">Фрашчайзи</label>
                    </div>
                  </div>


                  <div class="form-group">
                    <label for="salonName">Название салона</label>
                    <input type="text" name="salonName" id="salonName" placeholder="Название салона" class="form-control" value="<?=$salon_data['name']?>" <?=$disabled?> />
                  </div>



                  <?php foreach ($fields_list as $field) { ?>
                    <div class="form-group">
                      <label for="salonFields<?=$field['id']?>"><?=$field['name']?></label>
                      <input type="text" name="salonFields[<?=$field['id']?>]" id="salonFields<?=$field['id']?>" placeholder="<?=$field['name']?>" class="form-control" value="<?=$core->getSalonFieldValue($salon_data['id'], $field['id'])?>" <?=$disabled?> />
                    </div>
                  <?php } ?>
                </div>
              </div>

              <div class="row"></div>

            </form>
            </div>
          </div>
        </div>

      </div>
    <?php include ('tpl/cab/tpl_footer.tpl'); ?>
    </div>
  </div>
