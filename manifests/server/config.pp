# Class: ssh::server::config
#
# Provide the configuration paramaters necessary to configure the sshd(8)
# server and inject variables into the sshd_config file through the use of the
# concat erb template..
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

  include concat::setup

  $sshd_config   = $ssh::params::sshd_config

  concat::fragment { 'sshd_config':
    order   => '10',
    target  => $sshd_config,
    content => template('ssh/sshd_config.erb'),
  }
}
