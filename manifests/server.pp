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
) {

  include ssh
  include ssh::install
  include ssh::server::config

  include ssh::params
  include concat::setup

  $ssh_service     = $ssh::params::ssh_service
  $ssh_packages    = $ssh::params::ssh_pckages
  $sshd_config     = $ssh::params::sshd_config
  $needs_install   = $ssh::params::needs_install
  $root_group      = $ssh::params::root_group

  concat { $sshd_config:
    owner   => '0',
    group   => '0',
    mode    => '0640',
    require => Class['ssh::install'],
    notify  => Service['sshd'],
  }

  concat::fragment { 'sshd_config-header':
    order   => '00',
    target  => $sshd_config,
    content => template('ssh/sshd_config-header.erb'),
  }

  include ssh::server::config

  service { 'sshd':
    ensure     => running,
    name       => $ssh_service,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  file { $ssh::params::ssh_dir:
    ensure => directory,
    owner  => 'root',
    group  => '0',
    mode   => '0755',
  }

  file { $ssh::params::known_hosts:
    ensure => present,
    owner  => 'root',
    group  => '0',
    mode   => '0644',
  }

  # If root login is permitted, then the root group granted access.
  $permitrootlogin = $ssh::server::config::permitrootlogin

  if $permitrootlogin != 'no' {
    ssh::allowgroup { $root_group: }
  }
}
