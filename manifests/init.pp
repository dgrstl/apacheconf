# == Class: module_skeleton
#
# Full description of class module_skeleton here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class apacheconf (
  $prefix          = hiera('apacheconf::prefix', '/opt/app/'),
  $vtier           = hiera('apacheconf::vtier', undef),
  $vtierGroup      = hiera('apacheconf::vtierGroup', $vtier),
  $daemon          = hiera('apacheconf::daemon', undef),
  $source          = hiera('apacheconf::source', undef),
  $version         = hiera('apacheconf::version', undef),
  $serverAdmin     = hiera('apacheconf::serverAdmin', 'root@localhost'),
  $defaultLogLevel = hiera('apacheconf::defaultLogLevel', 'info'),
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
  } ~>
  #class { 'apacheconf::service':
  #  daemon    => upcase($daemon),
  #  scriptDir => $scriptDir,
  #}
}
