# Class: ssh::params
#
class ssh::params {

  $ssh_dir     = '/etc/ssh'
  $sshd_config = "${ssh_dir}/sshd_config"
  $ssh_config  = "${ssh_dir}/ssh_config"
  $known_hosts = "${ssh_dir}/ssh_known_hosts"

  case $::kernel {
    'OpenBSD': {
      $root_group = 'wheel'
    }
    'FreeBSD': {
      $root_group = 'wheel'
    }
    default: {
      $root_group = 'root'
    }
  }

  case $::operatingsystem {
    'CentOS', 'RedHat', 'Fedora': {
      $needs_install  = true
      $ssh_packages   = [ 'openssh-clients', 'openssh-server' ]
      $ssh_service    = 'sshd'
    }
    'SLES': {
      $needs_install  = true
      $ssh_packages   = 'openssh'
      $ssh_service    = 'sshd'
    }
    'Ubuntu', 'Debian': {
      $needs_install  = true
      $ssh_packages   = [ 'openssh-client', 'openssh-server' ]
      $ssh_service    = 'ssh'
    }
    'Darwin': {
      $needs_install = false
      $ssh_packages  = undef
      $ssh_service   = 'com.openssh.sshd'
    }
    'FreeBSD': {
      $needs_install = false
      $ssh_packages  = undef
      $ssh_service   = 'sshd'
    }
    'OpenBSD': {
      $needs_install = false
      $ssh_packages  = undef
      $ssh_service   = 'sshd'
    }
    'Solaris','SunOS': {
      $needs_install  = true
      $ssh_packages   = 'network/ssh'
      $ssh_service    = 'ssh'
    }
    default: {
      fail("module ${module_name} does not support ${::operatingsystem}")
    }
  }

  $service_hasrestart =  $::kernel ? {
    'Darwin' => false,
    default  => true,
  }
}
