<nav class="navbar navbar-vertical fixed-left navbar-expand-md navbar-light bg-white" id="sidenav-main">
    <div class="container-fluid">
      <!-- Toggler -->
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#sidenav-collapse-main" aria-controls="sidenav-main" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <!-- Brand -->
      <a class="navbar-brand pt-0" href="#">
        <!--img src="../assets/img/brand/blue.png" class="navbar-brand-img" alt="..."-->
      </a>
      <!-- User -->
      <ul class="nav align-items-center d-md-none">
        <li class="nav-item dropdown">
          <a class="nav-link nav-link-icon" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="ni ni-bell-55"></i>
          </a>
          <div class="dropdown-menu dropdown-menu-arrow dropdown-menu-right" aria-labelledby="navbar-default_dropdown_1">
            <a class="dropdown-item" href="#">Action</a>
            <a class="dropdown-item" href="#">Another action</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#">Something else here</a>
          </div>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <div class="media align-items-center">
              <span class="avatar avatar-sm rounded-circle">
                <!--img alt="Image placeholder" src="../assets/img/theme/team-1-800x800.jpg"-->
              </span>
            </div>
          </a>
          <div class="dropdown-menu dropdown-menu-arrow dropdown-menu-right">
            <div class=" dropdown-header noti-title">
              <h6 class="text-overflow m-0">Welcome!</h6>
            </div>
            <a href="./examples/profile.html" class="dropdown-item">
              <i class="ni ni-single-02"></i>
              <span>My profile</span>
            </a>
            <a href="./examples/profile.html" class="dropdown-item">
              <i class="ni ni-settings-gear-65"></i>
              <span>Settings</span>
            </a>
            <a href="./examples/profile.html" class="dropdown-item">
              <i class="ni ni-calendar-grid-58"></i>
              <span>Activity</span>
            </a>
            <a href="./examples/profile.html" class="dropdown-item">
              <i class="ni ni-support-16"></i>
              <span>Support</span>
            </a>
            <div class="dropdown-divider"></div>
            <a href="#!" class="dropdown-item">
              <i class="ni ni-user-run"></i>
              <span>Logout</span>
            </a>
          </div>
        </li>
      </ul>
      <!-- Collapse -->
      <div class="collapse navbar-collapse" id="sidenav-collapse-main">
        <!-- Collapse header -->
        <div class="navbar-collapse-header d-md-none">
          <div class="row">
            <div class="col-6 collapse-brand">
              <a href="./index.html">
                <img src="./assets/img/brand/blue.png">
              </a>
            </div>
            <div class="col-6 collapse-close">
              <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#sidenav-collapse-main" aria-controls="sidenav-main" aria-expanded="false" aria-label="Toggle sidenav">
                <span></span>
                <span></span>
              </button>
            </div>
          </div>
        </div>
        <!-- Form -->
        <form class="mt-4 mb-3 d-md-none">
          <div class="input-group input-group-rounded input-group-merge">
            <input type="search" class="form-control form-control-rounded form-control-prepended" placeholder="Search" aria-label="Search">
            <div class="input-group-prepend">
              <div class="input-group-text">
                <span class="fa fa-search"></span>
              </div>
            </div>
          </div>
        </form>
        <!-- Navigation -->
        <ul class="navbar-nav">
          <?php foreach ($menu as $value) { ?>
            <li class="nav-item">
              <a class="nav-link" href="<?=$value['url']?>">
                <i class="<?=$value['i']?>"></i> <?=$value['name']?>
              </a>
            </li>
          <?php } ?>
        </ul>
        <!-- Divider -->
        <hr class="my-3">
        <!-- Heading -->

      </div>
    </div>
  </nav>

<!--
<aside class="mdc-persistent-drawer mdc-persistent-drawer--open">
  <nav class="mdc-persistent-drawer__drawer">
    <div class="mdc-persistent-drawer__toolbar-spacer">
      <a href="index.html" class="brand-logo">
        <img src="images/logo.svg" alt="logo">
      </a>
    </div>
    <div class="mdc-list-group">
      <nav class="mdc-list mdc-drawer-menu">
        <div class="mdc-list-item mdc-drawer-item">
          <a class="mdc-drawer-link" href="/cab">
            <i class="material-icons mdc-list-item__start-detail mdc-drawer-item-icon" aria-hidden="true">desktop_mac</i>
            Главная
          </a>
        </div>
        <div class="mdc-list-item mdc-drawer-item">
          <a class="mdc-drawer-link" href="/cab/statistics">
            <i class="material-icons mdc-list-item__start-detail mdc-drawer-item-icon" aria-hidden="true">track_changes</i>
            Статистики
          </a>
        </div>
        <div class="mdc-list-item mdc-drawer-item" href="#" data-toggle="expansionPanel" target-panel="ui-sub-menu">
          <a class="mdc-drawer-link" href="#">
            <i class="material-icons mdc-list-item__start-detail mdc-drawer-item-icon" aria-hidden="true">dashboard</i>
            Администраирование
            <i class="mdc-drawer-arrow material-icons">arrow_drop_down</i>
          </a>
          <div class="mdc-expansion-panel" id="ui-sub-menu">
            <nav class="mdc-list mdc-drawer-submenu">
              <div class="mdc-list-item mdc-drawer-item">
                <a class="mdc-drawer-link" href="/cab/profiles">
                  Профили
                </a>
              </div>
              <div class="mdc-list-item mdc-drawer-item">
                <a class="mdc-drawer-link" href="/cab/users">
                  Пользователи
                </a>
              </div>
              <div class="mdc-list-item mdc-drawer-item">
                <a class="mdc-drawer-link" href="/cab/salons">
                  Салоны
                </a>
              </div>
            </nav>
          </div>
        </div>




      </nav>
    </div>
  </nav>
</aside>

-->
