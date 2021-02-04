<script>

function showPass() {
  if ($('#userPass').get(0).type == 'password') {
    $('#userPass').get(0).type = 'text';
    $('#userRePass').get(0).type = 'text';
    $('#showPassIco').html('<i class="fas fa-eye-slash"></i>');
  } else {
    $('#userPass').get(0).type = 'password';
    $('#userRePass').get(0).type = 'password';
    $('#showPassIco').html('<i class="fas fa-eye"></i>');
  }
}

  var config = {
  '.chosen-select'           : {},
  '.chosen-select-deselect'  : { allow_single_deselect: true },
  '.chosen-select-no-single' : { disable_search_threshold: 10 },
  '.chosen-select-no-results': { no_results_text: 'Oops, nothing found!' },
  '.chosen-select-rtl'       : { rtl: true },
  '.chosen-select-width'     : { width: '95%' }
  }
  for (var selector in config) {
    $(selector).chosen(config[selector]);
  }

  function openReport(form, file) {
    getString = file + '?' + $("#"+form).serialize();
    window.open(getString);
  }
</script>

</body>

</html>
