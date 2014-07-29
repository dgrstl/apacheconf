# == Class module_skeleton::params
#
# This class is meant to be called from module_skeleton
# It sets variables according to platform
#
class apacheconf::params {
  case $::osfamily {
    'RedHat': {
      $vtier  = 't1c1m1116'
      $daemon = 'bce8'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
