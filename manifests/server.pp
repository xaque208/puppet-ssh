# This class handles the configuration and servic ehandling for the SSH
# daemon.  The configuration parameters for sshd(8) are handled through the
# ssh::server::config class.
#
# @example
#   include ssh::server
#
class ssh::server {
  include ssh
  include ssh::install
  include ssh::server::config

  concat { $ssh::sshd_config:
    owner   => 'root',
    group   => '0',
    mode    => '0640',
    require => Class['ssh::install'],
    notify  => Service['sshd'],
  }

  concat::fragment { 'sshd_config-header':
    order   => '00',
    target  => $ssh::sshd_config,
    content => template('ssh/sshd_config-header.erb'),
  }

  include ssh::server::config

  service { 'sshd':
    ensure     => running,
    name       => $ssh::ssh_service,
    enable     => true,
    hasstatus  => true,
    hasrestart => $ssh::service_hasrestart,
  }

  file { $ssh::ssh_dir:
    ensure => directory,
    owner  => 'root',
    group  => '0',
    mode   => '0755',
  }

  file { $ssh::known_hosts:
    ensure => present,
    owner  => 'root',
    group  => '0',
    mode   => '0644',
  }

  # If root login is permitted, then the root group granted access.
  $permitrootlogin = $ssh::server::config::permitrootlogin

  if $permitrootlogin != 'no' {
    ssh::allowgroup { $ssh::root_group: }
  }
}
