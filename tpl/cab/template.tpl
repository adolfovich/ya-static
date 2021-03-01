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


<?php include ('tpl/cab/leftmenu.tpl'); ?>
<?php include ($page); ?>
