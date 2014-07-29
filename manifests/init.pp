# == Class: module_skeleton
#
# Full description of class module_skeleton here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class apacheconf (
) inherits apacheconf::params {

  class { 'apacheconf::install': } ->
  class { 'apacheconf::config': } ~>
  class { 'apacheconf::service': } ->
  Class['apacheconf']
}
