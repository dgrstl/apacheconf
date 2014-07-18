# == Class module_skeleton::install
#
class module_skeleton::install {

  package { $module_skeleton::package_name:
    ensure => present,
  }
}
