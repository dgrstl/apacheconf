# == Class apacheconf::service
#
# This class is meant to be called from apacheconf
# It ensure the service is running
#
class apacheconf::service (
  $scriptDir = undef,
  $daemon    = undef,
) {

  $webservers = hiera_hash('apacheconf::config::scripts')
  $webserverDefaults = {
    ensure     => running,
    provider   => base,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    scriptBase => "${scriptDir}/APACHE-${daemon}",
    daemon     => $daemon,
  }
  create_resources(apacheconf::webserver, $webservers, $webserverDefaults)
}
