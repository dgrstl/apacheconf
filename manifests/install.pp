# == Class module_skeleton::install
#
class apacheconf::install (
  $vtier    = hiera('apacheconf::install::vtier', undef),
  $prefix   = hiera('apacheconf::install::prefix', '/opt/app/'),
  $daemon   = hiera('apacheconf::install::daemon', undef),
  $source   = hiera('apacheconf::install::source', undef),
  $version  = hiera('apacheconf::install::version', undef),
  $serverAdmin = hiera('apacheconf::install::serverAdmin', 'root@localhost'),
  $defaultLogLevel = hiera('apacheconf::install::defaultLogLevel', 'info'),
  ) {

  $vtierHome  = "${prefix}/${vtier}"
  $apacheRoot = "${vtierHome}/Apache${version}"
  $apacheLink = "${vtierHome}/Apache"
  $scriptDir  = "${apacheRoot}/CONTROL"
  $confRoot    = "${apacheRoot}/conf"

  exec { 'install Apache':
    command => "tar xvf ${source}/Apache${version}.tar.gz",
    cwd     => $vtierHome,
    creates => $apacheRoot,
    path    => '/bin',
  }

  # might need to create $apacheLink/logs/$daemon but apache may do it
  file { $apacheLink :
    ensure  => 'link',
    path    => $apacheLink,
    target  => $apacheRoot,
    require => Exec['install Apache'],
  }

  file { $scriptDir :
    ensure  => 'directory',
    owner   => $vtier,
    group   => "${vtier}n",
    require => Exec['install Apache'],
  }

  file { $confRoot :
    ensure  => 'directory',
    owner   => $vtier,
    group   => "${vtier}n",
    require => Exec['install Apache'],
  }

  $scripts = {
    'MAIN'      => {},
    'CAMAIN1'   => {},
    'CASTAGING' => {},
    'FM-SSL'    => {},
    'FM-PCC'    => {},
    'FM-SJ-SSL' => {},
    'SSL'       => {},
    'WCA-SSL'   => {},
  }
  $scriptsDefaults = {
    daemon    => $daemon,
    vtier     => $vtier,
    scriptDir => $scriptDir,
  }
  create_resources(apacheconf::script, $scripts, $scriptsDefaults)

  $httpdConfs = {
    'MAIN'    => {
      port    => '8780',
      wlsHost => 'zltv1009.vci.att.com',
      wlsPort => '7008',
    },
    'CAMAIN1'   => {
      port    => '8760',
      wlsHost => 'zltv1018.vci.att.com',
      wlsPort => '7038',
    },
    'CASTAGING' => {
      port    => '8750',
      wlsHost => 'zldv0990.vci.att.com',
      wlsPort => '7056',
    },
    'FM-SSL'    => {
      port    => '8790',
      wlsHost => 'zldv0987.vci.att.com',
      wlsPort => '7018',
    },
    'PCC'    => {
      port    => '9470',
      wlsHost => 'zltv1009.vci.att.com',
      wlsPort => '7028',
    },
    'SJ-SSL' => {
      port    => '8770',
      wlsHost => 'd1c1m34.vci.att.com',
      wlsPort => '7068',
    },
    'SSL'       => {
      port    => '8890',
      wlsHost => 'zltv1009.vci.att.com',
      wlsPort => '7008',
    },
    'WCA-SSL'   => {
      port    => '9990',
      wlsHost => 'zltv1009.vci.att.com',
      wlsPort => '7028',
    },
  }
  $httpdConfDefaults = {
    daemon      => $daemon,
    vtier       => $vtier,
    confRoot    => $confRoot,
    vtierHome   => $vtierHome,
    apacheLink  => $apacheLink,
    serverAdmin => $serverAdmin,
    logLevel  => $defaultLogLevel,
  }
  create_resources(apacheconf::httpdconf, $httpdConfs, $httpdConfDefaults)
}
