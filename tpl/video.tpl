<html lang="ru" class="h-100">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Пример на bootstrap 4: Прижатый футер отображается в нижней части страницы, когда содержимое окна слишком короткое. Панель навигации в верхней части. Версия v4.3.1.">

    <title>Прижатый футер с меню | Sticky Footer Navbar. Версия v4.3.1</title>

    <!-- Bootstrap core CSS -->
<link href="/assets/vendor/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" >



    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>
    <!-- Custom styles for this template -->
    <link href="sticky-footer-navbar.css" rel="stylesheet">


</head>

  <body class="d-flex flex-column h-100">




    <header>
  <!-- Fixed navbar -->
  <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <a class="navbar-brand" href="#"></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav mr-auto">

        <li class="nav-item">
          <a class="btn btn-secondary " href="/">Войти</a>
        </li>

      </ul>

    </div>
  </nav>
</header>

<!-- Begin page content -->
<div class="container-fluid mt--7">
  <div class="container" style="margin-top: 30px;">
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

<footer class="footer mt-auto py-3">
  <div class="container">
    <span class="text-muted"><p class="mt-5 mb-3 text-muted"><a href="https://exeptional.ru" class="font-weight-bold ml-1" target="_blank" style="color: #6c757d; font-weight: 100 !important;">e<span style="color: green;">[x]</span>eptional software</a> &copy; <?=date("Y")?></p></span>
  </div>
</footer>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>

<script>window.jQuery || document.write('<script src="/docs/4.3.1/assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
<script src="/assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js" ></script>

</body>
</html>
