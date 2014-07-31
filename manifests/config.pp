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
  $apacheLink      = undef,
  $serverAdmin     = hiera('apacheconf::config::serverAdmin', 'root@localhost'),
  $defaultLogLevel = hiera('apacheconf::config::defaultLogLevel', 'info'),
) {
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
    daemon     => $daemon,
    vtier      => $vtier,
    vtierGroup => $vtierGroup,
    scriptDir  => $scriptDir,
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
    vtierGroup  => $vtierGroup,
    confRoot    => $confRoot,
    vtierHome   => $vtierHome,
    apacheLink  => $apacheLink,
    serverAdmin => $serverAdmin,
    logLevel    => $defaultLogLevel,
  }
  create_resources(apacheconf::httpdconf, $httpdConfs, $httpdConfDefaults)
}
