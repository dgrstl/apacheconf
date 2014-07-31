define apacheconf::script(
  $daemon     = undef,
  $vtier      = undef,
  $vtierGroup = $vtier,
  $scriptDir  = $scriptDir,
) {

  #$fname_base = concat(['APACHE-'],[upcase($daemon)])
  $daemonupper = upcase($daemon)
  $fname_base  = "APACHE-${daemonupper}"
  #$fname_base = inline_template("<%= scope.lookupvar('f') %>")

  if ($name == 'MAIN') {
    $fname = $fname_base
  } else {
    $fname = "${fname_base}-${name}"
  }

  file { "${scriptDir}/${fname}":
    ensure  => 'file',
    owner   => $vtier,
    group   => $vtierGroup,
    mode    => '0744',
    content => template('apacheconf/script.erb'),
  }
}
