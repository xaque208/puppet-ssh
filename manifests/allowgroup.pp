# Class: ssh::allowgroup
#
# Allows a group the ability to shell into a give node.
#
define ssh::allowgroup (
  $chroot        = false,
  $tcpforwarding = false
) {

  include ::ssh::server

  $sshd_config = $ssh::sshd_config

  if $chroot == true {
    include ::ssh::chroot
    file { "/var/chroot/${name}":
      ensure => directory,
      owner  => root,
      group  => root,
      mode   => '0755',
    }

    file { "/var/chroot/${name}/drop":
      ensure => directory,
      owner  => root,
      group  => $name,
      mode   => '0775';
    }

    $allowtcp = $tcpforwarding ? {
      true    => 'yes',
      default => 'no',
    }

    concat::fragment { "sshd_config_chroot_group-${name}":
      target  => $sshd_config,
      content => template('ssh/allowgroup.erb'),
    }
  }

  concat::fragment { "sshd_config_AllowGroups-${name}":
    order   => '20',
    target  => $sshd_config,
    content => "AllowGroups ${name}\n",
  }
}
