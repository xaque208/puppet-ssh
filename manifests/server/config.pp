# Class: ssh::server::config
#
# Provide the configuration parameters necessary to configure sshd(8)
# through sshd_config(5) from a template.
#
class ssh::server::config (
  $port                     = '22',
  $protocol                 = '2',
  $useprivilegeseparation   = 'yes',
  $syslogfacility           = 'AUTH',
  $log_level                = 'INFO', # underscore here because puppet
  $passwordauthentication   = 'no',
  $permitemptypasswords     = 'no',
  $usepam                   = 'yes',
  $permitrootlogin          = 'no',
  $gssapiauthentication     = 'no',
  $gssapicleanupcredentials = 'yes',
  $subsystem                = {},
  $has_pam                  = false,
  $has_gssapi               = false,
){

  $sshd_config   = $ssh::params::sshd_config

  concat::fragment { 'sshd_config':
    order   => '10',
    target  => $sshd_config,
    content => template('ssh/sshd_config.erb'),
  }
}
