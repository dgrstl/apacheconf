# == Class: apacheconf::install
#
# Install Apache from source tarball into $vtierHome
#
# === Parameters
#
# [*source*]
#   Location of Apache tarball for installation
# [*version*]
#   Apache version
# [*vtier*]
#   Service account name which owns Apache on this node
# [*vtierHome*]
#   Root directory for Apache installation
# [*vtierGroup*]
#   Service account group name which owns Apache on this node
# [*daemon*]
#   Daemon name (e.g. BCE[1-n], etc.)
# [*scriptDir*]
#   Directory for instance start/stop scripts
# [*confRoot*]
#   Root directory for instance httpd.conf files. Each instance
#   will have an http.conf in ${vtierHome}/${apacheRoot}/conf/${daemon}/
# [*logRoot*]
#   Root directory for instance log directories.  Each instance
#   will log to ${logRoot}/${daemon}
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
