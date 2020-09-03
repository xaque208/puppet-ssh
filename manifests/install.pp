# This class handles the installation and removal of the SSH packages if any
# are present.
#
class ssh::install (
  Enum['present', 'absent', 'latest'] $ensure = 'present',
) {
  include ssh

  if length($ssh::ssh_packages) > 0 {
    package { $ssh::ssh_packages:
      ensure => $ensure,
    }
  }
}
