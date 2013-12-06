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

  $client_package = $ssh::params::client_package
  $ssh_config     = $ssh::params::ssh_config
  $sshd_config    = $ssh::params::sshd_config
  $ssh_service    = $ssh::params::ssh_service

  if $::kernel == 'Linux' or $::kernel == 'SunOS' {
    package { $client_package:
        ensure => latest,
    }
  }

  file { $ssh_config:
    ensure    => file,
    owner     => root,
    group     => 0,
    mode      => 0644,
    require   => $kernel ? {
      "Darwin"  => undef,
      'freebsd' => undef,
      'openbsd' => undef,
      'solaris' => undef,
      'SunOS'   => undef,
      default   => Package[$client_package],
    }
  }
}
