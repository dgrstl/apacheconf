# == Class module_skeleton::install
#
class apacheconf::install (
  $vtier    = hiera('apacheconf::install::vtier', undef),
  $prefix   = hiera('apacheconf::install::prefix', '/opt/app/'),
  $daemon   = hiera('apacheconf::install::daemon', undef),
  $source   = hiera('apacheconf::install::source', undef),
  $version  = hiera('apacheconf::install::version', undef),
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

  file { $apacheLink :
    ensure  => 'link',
    path    => $apacheLink,
    target  => $apacheRoot,
    require => Exec['install Apache'],
  }

  file { $scriptDir :
    ensure  => 'directory',
    group   => "${vtier}n",
    owner   => $vtier,
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
    'WCS-SSL'   => {},
  }
  $defaults = { daemon => $daemon, vtier => $vtier, scriptDir => $scriptDir}
  create_resources(apacheconf::script, $scripts, $defaults)
}
