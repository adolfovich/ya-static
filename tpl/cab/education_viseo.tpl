<div class="main-content">

  <style>

  .modal-error {
  text-align: center;
  }

  .cat {
  width: 150px;
  height: 150px;

  border: 1px #5e72e4 solid;

  position: relative;

  background-color:rgba(85, 85, 85, 0.1);
  border-radius: 20px;
  }

  .cat-name {
  margin-top: calc(50% - 1rem);
  display: inline-block;
  font-weight: 600;
  }

  .cat-icon {
  position: absolute;

  font-size: 100px;
  text-align: center;
  margin-left: 35px;
  color:rgba(85, 85, 85, 0.2)
  }
  </style>

  <div class="modal" id="onceLinkModal"  tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <form id="deleteForm" method="POST">
        <input type="hidden" id="editActionType" name="action_type" value="delete_video">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" >Одноразовая ссылка</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div id="onceLinkModalBody" class="modal-body">
            <form class="form-inline">
              <div class="form-row">
                <div class="col-8">
                  <input type="text" class="form-control" id="inputPassword2" placeholder="" value="1111111111111">
                </div>
                <div class="col-4" style="text-align: right;">
                  <button type="button" class="btn btn-primary" onclick="copyUrl()">Копировать</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </form>
    </div>
  </div>

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
                <div class="col">
                  <h6 class="text-uppercase text-muted ls-1 mb-1"></h6>
                  <h2 class="mb-0">
                    <a href="/cab/education">Категории</a> <i class="fas fa-long-arrow-alt-right"></i>
                    <a href="/cab/education?cat=<?=$cat_data['id']?>"><?=$cat_data['name']?></a> <i class="fas fa-long-arrow-alt-right"></i>
                    <a href="/cab/education?cat=<?=$cat_data['id']?>&subcat=<?=$subcat_data['id']?>"><?=$subcat_data['name']?></a> <i class="fas fa-long-arrow-alt-right"></i>
                    <?=$video_data['name']?>
                  </h2>
                </div>
              </div>
            </div>
            <div class="card-body">
              <div class="row">
                <div class="col-sm">
                  <?=$video_data['name']?>
                </div>
                <div class="col-sm" style="text-align: right;">
                  <a href="#" class="btn btn-primary" onClick="getOnceLink(<?=$video_data['id']?>)">Одноразовая ссылка</a>
                  <a href="/cab/education?cat=<?=$cat_data['id']?>&subcat=<?=$subcat_data['id']?>" class="btn btn-primary">Закрыть</a>
                </div>
              </div>
              <br>
              <div class="row" style="text-align: center;">
                <div class="embed-responsive embed-responsive-16by9">
                  <video style="margin: 0 auto;" src="<?=$video_data['path']?>" controls></video>
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
  function getOnceLink(videoId) {
    $.post(
      "/pages/cab/ajax/getOnceLink.php",
      {
        id: videoId
      },
      onAjaxSuccess
    );

    function onAjaxSuccess(data)
    {
      //console.log(data);
      var result = JSON.parse(data);
      if (result.status == 'OK') {
        document.getElementById('onceLinkModalBody').innerHTML = result.response; //response
        $('#onceLinkModal').modal('show');
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

  function copyUrl(){
  var copyText = document.getElementById("inputUrl");
  copyText.select();
  document.execCommand("copy");
  }


</script>
