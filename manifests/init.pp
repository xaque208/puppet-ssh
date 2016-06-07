# This class serves as a data collection class for the rest of the modules
# here, as well as managing the permissions on the SSH configuration
# directory.  This class should need to be included explicitly, as it is
# included by the classes that require it.
#
# @param ssh_dir The path to the directory containing the config files
# @param sshd_config The path to the sshd_config(5) file
# @param ssh_config The path to the ssh_config(5) file
# @param known_hosts The path to the known_hosts file for the system
# @param root_group The name of the root group
# @param ssh_packages A list of packages to install
#
# @example
#   include ssh
#
class ssh (
  String $ssh_dir,
  String $sshd_config,
  String $ssh_config,
  String $known_hosts,
  String $root_group,
  Array $ssh_packages,
){

  include ssh::install

  file { $ssh_config:
    ensure  => file,
    owner   => 'root',
    group   => '0',
    mode    => '0644',
    require => Class['ssh::install'],
  }
}
