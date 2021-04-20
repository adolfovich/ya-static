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
                <input type="text" class="form-control" id="inputPassword2" placeholder="" value="">
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

<style>
.loading {
  width: 100%;
    height: 100%;
    position: absolute;
    z-index: 9999;
    background: rgba(0, 0, 0, 0.4);
    display: none;
}

.loading-icon {
  font-size: 5em;
      color: #fff;
      margin-left: calc(50% - 40px);
      margin-top: 30%;
}

</style>

<div class="loading">
  <div class="loading-icon"><i class="fas fa-spinner fa-spin"></i></div>
</div>

<?php include ('tpl/cab/leftmenu.tpl'); ?>
<?php include ($page); ?>
