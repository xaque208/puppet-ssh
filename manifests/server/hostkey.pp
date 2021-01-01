# Define: ssh::server::hostkey
#
# Add an ssh hostkey to sshd_config(5)
#
# Examples:
#
#   ssh::server::hostkey { 'rsa':
#     path => '/etc/ssh/ssh_host_rsa_key'
#   }
#
define ssh::server::hostkey (
  Stdlib::Absolutepath $path,
  Integer[40, 99] $order = 40,
) {
  include ssh
  include ssh::server

  concat::fragment { "sshd_config-hostkey-${name}":
    content => template('ssh/sshd_config-hostkey.erb'),
    order   => $order,
    target  => $ssh::sshd_config,
  }
}
