<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="Ya Statistic">
  <meta name="author" content="Exeptional Software">
  <title>Парикмахерская Я </title>
  <!-- Favicon -->
  <link href="../assets/img/brand/favicon.png" rel="icon" type="image/png">
  <!-- Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
  <!-- Icons -->
  <link href="../assets/vendor/nucleo/css/nucleo.css" rel="stylesheet">
  <link href="../assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet">
  <!-- Argon CSS -->
  <link type="text/css" href="../assets/css/argon.css?v=1.0.0" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>

  <!-- Argon Scripts -->
  <!-- Core -->
  <script src="../assets/vendor/jquery/dist/jquery.min.js"></script>
  <script src="../assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
  <!-- Optional JS -->
  <script src="../assets/vendor/chart.js/dist/Chart.min.js"></script>
  <script src="../assets/vendor/chart.js/dist/Chart.extension.js"></script>
  <!-- Argon JS -->
  <script src="../assets/js/argon.js?v=1.0.0"></script>

  <!--link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script-->
  <script src="../assets/js/chosen.jquery.js"></script>
  <link type="text/css" href="../assets/css/chosen.css" rel="stylesheet">

  <!-- Latest compiled and minified CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/css/bootstrap-select.min.css">

  <!-- Latest compiled and minified JavaScript -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/bootstrap-select.min.js"></script>

  <script src="../assets/galery/js/lc_lightbox.lite.js" type="text/javascript"></script>
  <link rel="stylesheet" href="../assets/galery/css/lc_lightbox.css" />
  <!-- SKINS -->
  <link rel="stylesheet" href="../assets/galery/skins/minimal.css" />
  <!-- ASSETS -->
  <script src="../assets/galery/lib/AlloyFinger/alloy_finger.min.js" type="text/javascript"></script>


</head>

<body>
  <style>
    .ticketsTable {
      cursor: pointer;
    }

    .ticketsTable:hover {
      background: #eee;
    }


    .form-group {
      margin-bottom: 0.5rem !important;
    }

    .modal-body {
      padding-top: 5px;
      padding-bottom: 5px;
    }

    .modal-footer {
      padding-top: 5px;
    }

    .modal-header {
      padding-bottom: 5px;
    }

    a.chosen-single {
      font-size: 1rem !important;
      line-height: 1.5 !important;
      width: 100% !important;
      height: calc(2.75rem + 2px) !important;
      padding: .625rem .75rem !important;
      transition: all .2s cubic-bezier(.68, -.55, .265, 1.55) !important;
      color: #8898aa !important;
      border: 1px solid #cad1d7 !important;
      border-radius: .375rem !important;
      background: #fff !important;
      background-clip: padding-box !important;
      box-shadow: none !important;
    }

    div.chosen-container {
      width: 140px !important;
      margin-left: 10px;
    }

    elem, .elem * {
	box-sizing: border-box;
	margin: 0 !important;
}
.elem {
	display: inline-block;
	font-size: 0;
	width: 33%;
	border: 20px solid transparent;
	border-bottom: none;
	background: #fff;
	padding: 10px;
	height: auto;
	background-clip: padding-box;
}
.elem > span {
	display: block;
	cursor: pointer;
	height: 0;
	padding-bottom:	70%;
	background-size: cover;
	background-position: center center;
}


.lcl_fade_oc.lcl_pre_show #lcl_overlay,
.lcl_fade_oc.lcl_pre_show #lcl_window,
.lcl_fade_oc.lcl_is_closing #lcl_overlay,
.lcl_fade_oc.lcl_is_closing #lcl_window {
	opacity: 0 !important;
}
.lcl_fade_oc.lcl_is_closing #lcl_overlay {
	-webkit-transition-delay: .15s !important;
	transition-delay: .15s !important;
}

.status {

    padding: 5px;
    padding-top: 3px;
    border-radius: 7px;
    padding-bottom: 3px;
    font-weight: 700;
}
  </style>
  <style>
  .single-purchase-row {
    cursor: pointer;
  }

  .single-purchase-row:hover {
    background: #eee;
  }
  </style>
