# Class: ssh::install
#
# Install the OpenSSH client and server packages.
#
class ssh::install (
  $ensure        = 'latest',
  $needs_install = $ssh::params::needs_install,
  $ssh_packages  = $ssh::params::ssh_packages,
) inherits ssh::params {

  if $needs_install == true {
    package { $ssh_packages:
      ensure => $ensure,
      notify => Service['sshd'],
    }
  }
}
