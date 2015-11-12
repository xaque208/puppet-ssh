# Define: ssh::server::subsystem
#
# Add an ssh subsystem to sshd_config(5)
#
# Examples:
#
#   ssh::server::subsystem { 'sftp':
#     system => 'internal-sftp'
#   }
#
define ssh::server::subsystem (
  $system,
) {

  include ssh::params
  include ssh::server

  $sshd_config = $ssh::params::sshd_config

  concat::fragment { "sshd_config-subsystem-${name}":
    target  => $sshd_config,
    content => template('ssh/sshd_config-subsystem.erb'),
  }
}
