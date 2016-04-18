# Class: ssh::install
#
# Install the OpenSSH client and server packages.
#
class ssh::install (
  $ensure        = 'latest',
  $needs_install = $ssh::params::needs_install,
  $ssh_packages  = $ssh::params::ssh_packages,
) inherits ssh::params {

  validate_re($ensure, ['present', 'absent', 'latest'])
  validate_bool($needs_install)

  if $needs_install == true {
    package { $ssh_packages:
      ensure => $ensure,
      notify => Service['sshd'],
    }
  }
}
