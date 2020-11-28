<!-- Footer -->
<footer class="footer">
  <div class="row align-items-center justify-content-xl-between">
    <div class="col-xl-6">
      <div class="copyright text-center text-xl-left text-muted">
        © <?=date("Y")?><a href="https://exeptional.ru" class="font-weight-bold ml-1" target="_blank" style="color: #6c757d; font-weight: 100 !important;">e<span style="color: green;">[x]</span>eptional software</a>
      </div>
    </div>
    <!--div class="col-xl-6">
      <ul class="nav nav-footer justify-content-center justify-content-xl-end">
        <li class="nav-item">
          <a href="https://www.creative-tim.com" class="nav-link" target="_blank">Creative Tim</a>
        </li>
        <li class="nav-item">
          <a href="https://www.creative-tim.com/presentation" class="nav-link" target="_blank">About Us</a>
        </li>
        <li class="nav-item">
          <a href="http://blog.creative-tim.com" class="nav-link" target="_blank">Blog</a>
        </li>
        <li class="nav-item">
          <a href="https://github.com/creativetimofficial/argon-dashboard/blob/master/LICENSE.md" class="nav-link" target="_blank">MIT License</a>
        </li>
      </ul>
    </div-->
  </div>
</footer>

<script>
  function modalDelete(type, id) {
    $.post(
      "/pages/cab/ajax/getModalEdu.php",
      {
        type: type,
        id: id
      },
      onAjaxSuccess
    );

    function onAjaxSuccess(data)
    {
      //console.log(data);
      var result = JSON.parse(data);
      if (result.status == 'OK') {
        document.getElementById('deleteBody').innerHTML = result.response; //response
        $('#delete').modal('show');
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
  function modalEdit(type, id) {
    $.post(
      "/pages/cab/ajax/getModalEdu.php",
      {
        type: type,
        id: id
      },
      onAjaxSuccess
    );

    function onAjaxSuccess(data)
    {
      //console.log(data);
      var result = JSON.parse(data);
      if (result.status == 'OK') {
        document.getElementById('editBody').innerHTML = result.response; //response
        $('#edit').modal('show');
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
