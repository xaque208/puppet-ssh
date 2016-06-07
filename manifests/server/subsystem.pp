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

  include ssh
  include ssh::server

  concat::fragment { "sshd_config-subsystem-${name}":
    target  => $ssh::sshd_config,
    content => template('ssh/sshd_config-subsystem.erb'),
  }
}
