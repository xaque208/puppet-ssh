# Class: ssh::params
#
# Sets varables for the SSH class
#
class ssh::params {

  $ssh_dir           = '/etc/ssh'
  $sshd_config       = "${ssh_dir}/sshd_config"
  $ssh_config        = "${ssh_dir}/ssh_config"
  $known_hosts       = "${ssh_dir}/ssh_known_hosts"

  case $::operatingsystem {
    'centos', 'redhat', 'fedora': {
      $client_package = 'openssh-clients'
      $server_package = 'openssh-server'
      $ssh_service    = 'sshd'
    }
    'sles': {
      $client_package = 'openssh'
      $server_package = 'openssh'
      $ssh_service    = 'sshd'
    }
    'ubuntu', 'debian': {
      $client_package = 'openssh-client'
      $server_package = 'openssh-server'
      $ssh_service    = 'ssh'
    }
    'darwin': {
      $ssh_service = 'com.openssh.sshd'
    }
    'freebsd': {
      $ssh_service = 'sshd'
    }
    'solaris','sunos': {
      $client_package = 'network/ssh'
      $server_package = 'network/ssh'
      $ssh_service    = 'ssh'
    }
    default: {
      fail("module ssh does not support operatingsystem ${::operatingsystem}")
    }
  }
}
