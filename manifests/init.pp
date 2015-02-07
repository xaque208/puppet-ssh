# Class: ssh
#
# This class installs and manages SSH
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class ssh {

  include ssh::params

  $ssh_config     = $ssh::params::ssh_config

  include ssh::install

  file { $ssh_config:
    ensure  => file,
    owner   => 'root',
    group   => '0',
    mode    => '0644',
    require => Class['ssh::install'],
  }
}
