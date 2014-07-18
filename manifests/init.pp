# == Class: module_skeleton
#
# Full description of class module_skeleton here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class module_skeleton (
  $package_name = $module_skeleton::params::package_name,
  $service_name = $module_skeleton::params::service_name,
) inherits module_skeleton::params {

  # validate parameters here

  class { 'module_skeleton::install': } ->
  class { 'module_skeleton::config': } ~>
  class { 'module_skeleton::service': } ->
  Class['module_skeleton']
}
