# This class handles the installation and removal of the SSH packages if any
# are present.
#
class ssh::install (
  $ensure = 'present',
) {

  validate_re($ensure, ['present', 'absent', 'latest'])
  include ::ssh

  if size($ssh::ssh_packages) > 0 {
    package { $ssh::ssh_packages:
      ensure => $ensure,
    }
  }
}
