# Class: ssh::params
#
class ssh::params {

  $ssh_dir     = '/etc/ssh'
  $sshd_config = "${ssh_dir}/sshd_config"
  $ssh_config  = "${ssh_dir}/ssh_config"
  $known_hosts = "${ssh_dir}/ssh_known_hosts"

  case $::kernel {
    'openbsd': {
      $root_group = 'wheel'
    }
    'freebsd': {
      $root_group = 'wheel'
    }
    default: {
      $root_group = 'root'
    }
  }

  case $::operatingsystem {
    'centos', 'redhat', 'fedora': {
      $needs_install  = true
      $ssh_packages   = [ 'openssh-clients', 'openssh-server' ]
      $ssh_service    = 'sshd'
    }
    'sles': {
      $needs_install  = true
      $ssh_packages   = 'openssh'
      $ssh_service    = 'sshd'
    }
    'ubuntu', 'debian': {
      $needs_install  = true
      $ssh_packages   = [ 'openssh-client', 'openssh-server' ]
      $ssh_service    = 'ssh'
    }
    'darwin': {
      $needs_install = false
      $ssh_packages  = undef
      $ssh_service   = 'com.openssh.sshd'
    }
    'freebsd': {
      $needs_install = false
      $ssh_packages  = undef
      $ssh_service   = 'sshd'
    }
    'openbsd': {
      $needs_install = false
      $ssh_packages  = undef
      $ssh_service   = 'sshd'
    }
    'solaris','sunos': {
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
