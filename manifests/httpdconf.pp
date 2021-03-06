define apacheconf::httpdconf(
  $daemon,
  $vtier,
  $vtierGroup,
  $vtierHome,
  $confRoot,
  $logRoot,
  $apacheLink,
  $port,
  $wlsHost,
  $wlsPort,
  $logLevel,
  $serverAdmin,
  ) {

  if ($name == 'MAIN') {
    $confDir = "${confRoot}/${daemon}"
    $logDir  = "${logRoot}/${daemon}"
  } else {
    $confDir = "${confRoot}/${daemon}-${name}"
    $logDir  = "${logRoot}/${daemon}-${name}"
  }

  file { $confDir :
    ensure  => 'directory',
    owner   => $vtier,
    group   => $vtierGroup,
    mode    => '0644',
  }

  file { $logDir :
    ensure  => 'directory',
    owner   => $vtier,
    group   => $vtierGroup,
    mode    => '0644',
  }

  # Apache LoadModules and Locations used in the httpdconf.erb template below
  $loadModules = hiera_array('apacheconf::templates::httpdconf::loadmodules')
  $locations = hiera_array('apacheconf::templates::httpdconf::locations')

  file { "${confDir}/httpd_${daemon}.conf" :
    ensure  => 'file',
    owner   => $vtier,
    group   => $vtierGroup,
    mode    => '0644',
    content => template('apacheconf/httpdconf.erb'),
  }
}
