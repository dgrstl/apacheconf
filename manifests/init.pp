# == Class: apacheconf
#
# Configure 1 or more Apache HTTPD instances as follows:
#  - Install: Untar Apache tarball to $vtierHome
#  - Configure: Create 1 start/stop script for each instance in
#               ${vtierHome}/Apache/CONTROL
#               Create 1 httpd.conf file for each instance in
#               ${vtierHome}/Apache/conf/${daemon}
#               Create 1 log directory for each instance in
#               ${vtierHome}/Apache/logs
#  - Service: Start each instance
#
# === Parameters
#
# [*prefix*]
#   Prefix for $vtierHome which is the installation root for Apache
# [*vtier*]
#   Service account name which owns Apache on this node
# [*vtierGroup*]
#   Service account group name which owns Apache on this node
# [*daemon*]
#   Daemon name (e.g. BCE[1-n], etc.)
# [*source*]
#   Location of Apache tarball for installation
# [*version*]
#   Apache version
#
class apacheconf (
  $prefix          = hiera('apacheconf::prefix', '/opt/app/'),
  $vtier           = hiera('apacheconf::vtier', undef),
  $vtierGroup      = hiera('apacheconf::vtierGroup', $vtier),
  $daemon          = hiera('apacheconf::daemon', undef),
  $source          = hiera('apacheconf::source', undef),
  $version         = hiera('apacheconf::version', undef),
) inherits apacheconf::params {

  $vtierHome  = "${prefix}/${vtier}"
  $apacheRoot = "${vtierHome}/Apache${version}"
  $apacheLink = "${vtierHome}/Apache"
  $scriptDir  = "${apacheRoot}/CONTROL"
  $confRoot   = "${apacheRoot}/conf"
  $logRoot    = "${apacheRoot}/logs"

  class { 'apacheconf::install':
    source     => $source,
    version    => $version,
    vtier      => $vtier,
    vtierHome  => $vtierHome,
    vtierGroup => $vtierGroup,
    daemon     => $daemon,
    scriptDir  => $scriptDir,
    confRoot   => $confRoot,
    logRoot    => $logRoot,
    apacheRoot => $apacheRoot,
    apacheLink => $apacheLink,
  } ->
  class { 'apacheconf::config':
    daemon     => $daemon,
    vtier      => $vtier,
    vtierHome  => $vtierHome,
    vtierGroup => $vtierGroup,
    scriptDir  => $scriptDir,
    confRoot   => $confRoot,
    logRoot    => $logRoot,
    apacheLink => $apacheLink,
  } #~>
  #class { 'apacheconf::service':
  #  daemon    => upcase($daemon),
  #  scriptDir => $scriptDir,
  #}
  -> Class['apacheconf']
}
