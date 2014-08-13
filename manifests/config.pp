# == Class apacheconf::config
#
# This class is called from apacheconf
#
class apacheconf::config (
  $daemon          = undef,
  $vtier           = undef,
  $vtierHome       = undef,
  $vtierGroup      = $vtier,
  $scriptDir       = undef,
  $confRoot        = undef,
  $logRoot         = undef,
  $apacheLink      = undef,
  $serverAdmin     = hiera('apacheconf::config::serverAdmin', 'root@localhost'),
  $defaultLogLevel = hiera('apacheconf::config::defaultLogLevel', 'info'),
) {

  $scripts = hiera_hash('apacheconf::config::scripts')
  $scriptsDefaults = {
    daemon     => $daemon,
    vtier      => $vtier,
    vtierGroup => $vtierGroup,
    scriptDir  => $scriptDir,
  }
  create_resources(apacheconf::script, $scripts, $scriptsDefaults)

  $httpdConfs = hiera_hash('apacheconf::config::httpdConfs')
  $httpdConfDefaults = {
    daemon      => $daemon,
    vtier       => $vtier,
    vtierGroup  => $vtierGroup,
    confRoot    => $confRoot,
    vtierHome   => $vtierHome,
    apacheLink  => $apacheLink,
    serverAdmin => $serverAdmin,
    logRoot     => $logRoot,
    logLevel    => $defaultLogLevel,
  }
  create_resources(apacheconf::httpdconf, $httpdConfs, $httpdConfDefaults)
}
