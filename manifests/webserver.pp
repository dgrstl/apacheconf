define apacheconf::webserver(
  $ensure     = running,
  $provider   = base,
  $enable     = true,
  $hasstatus  = true,
  $hasrestart = true,
  $scriptBase = undef,
  $daemon     = undef,
) {

  if ($name == 'MAIN') {
    $script = $scriptBase
  } else {
    $script = "${script}-${name}"
  }

  service { "${daemon}-${name}" :
    ensure     => $ensure,
    provider   => $provider,
    enable     => $enable,
    hasstatus  => $hasstatus,
    hasrestart => $hasrestart,
    start      => "${script} start",
    stop       => "${script} stop",
    restart    => "${script} restart",
  }
}
