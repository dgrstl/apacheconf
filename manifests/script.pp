define apacheconf::script($daemon, $vtier) {

  $fname_base = concat(['APACHE-'],[upcase($daemon)])

  if ($name == 'MAIN') {
    $fname = $fname_base
  } else {
    $fname = "${fname_base}-${name}"
  }

  file { "/opt/app/${vtier}/Apache/CONTROL/${fname}":
    owner   => $vtier,
    group   => "${vtier}n",
    mode    => '0744',
    content => template('apacheconf/script.erb'),
  }
}
