# == Class module_skeleton::params
#
# This class is meant to be called from module_skeleton
# It sets variables according to platform
#
class module_skeleton::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'module_skeleton'
      $service_name = 'module_skeleton'
    }
    'RedHat', 'Amazon': {
      $package_name = 'module_skeleton'
      $service_name = 'module_skeleton'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
