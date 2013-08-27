# Class: ssh::server
#
# This class installs and manages SSH servers
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class ssh::server(
  $permit_root_login     = 'no',
  $permit_x11_forwarding = 'no',
) {
  include ssh
  include ssh::params
  include concat::setup

  $permit_root_login_values     = [ 'no', 'without-password', 'forced-commands-only', 'yes' ]
  $permit_x11_forwarding_values = [ 'no', 'yes' ]

  unless $permit_root_login in $permit_root_login_values {
    fail("Invalid value '${permit_root_login}' for permit_root_login")
  }
  unless $permit_x11_forwarding in $permit_x11_forwarding_values {
    fail("Invalid value '${permit_x11_forwarding}' for permit_x11_forwarding")
  }

  $ssh_service    = $ssh::params::ssh_service
  $server_package = $ssh::params::server_package
  $sshd_config    = $ssh::params::sshd_config

  if $kernel == "Linux" {
    if !defined(Package[$server_package]) {
      package { $server_package:
        ensure  => latest,
        notify  => Service['sshd'],
      }
    }
  }

  concat::fragment { 'sshd_config-header':
    order   => '00',
    target  => $sshd_config,
    content => template("ssh/sshd_config.erb"),
  }
  concat { $sshd_config:
    mode    => '0640',
    require => $kernel ? {
      "Darwin" => undef,
      'freebsd' => undef,
      'openbsd' => undef,
      default  => Package[$server_package],
    },
    notify  => Service['sshd'],
  }
  service { 'sshd':
    name       => $ssh_service,
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  file { $ssh::params::ssh_dir:
    ensure => directory,
    owner  => 0,
    group  => 0,
    mode   => '0755',
  }

  file { $ssh::params::known_hosts:
    ensure => present,
    owner  => 0,
    group  => 0,
    mode   => '0644',
  }
}
