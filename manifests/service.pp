# == Class module_skeleton::service
#
# This class is meant to be called from module_skeleton
# It ensure the service is running
#
class module_skeleton::service {

  service { $module_skeleton::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
