# == Class: apacheconf::install
#
# Install Apache from source tarball into $vtierHome
#
# === Parameters
#
#
class apacheconf::install (
  $source          = undef,
  $version         = undef,
  $vtier           = undef,
  $vtierHome       = undef,
  $vtierGroup      = undef,
  $daemon          = undef,
  $scriptDir       = undef,
  $confRoot        = undef,
  $logRoot         = undef,
  $apacheRoot      = undef,
  $apacheLink      = 'Apache',
  ) {

  exec { 'install Apache':
    command => "tar xvf ${source}/Apache${version}.tar.gz",
    cwd     => $vtierHome,
    creates => $apacheRoot,
    path    => '/bin',
  }

  file { $logRoot :
    ensure  => 'directory',
    owner   => $vtier,
    group   => $vtierGroup,
    require => Exec['install Apache'],
  }

  file { $apacheLink :
    ensure  => 'link',
    path    => $apacheLink,
    target  => $apacheRoot,
    require => Exec['install Apache'],
  }

  file { $scriptDir :
    ensure  => 'directory',
    owner   => $vtier,
    group   => $vtierGroup,
    require => Exec['install Apache'],
  }

  file { $confRoot :
    ensure  => 'directory',
    owner   => $vtier,
    group   => $vtierGroup,
    require => Exec['install Apache'],
  }
}
