# Define: ssh::server::match
#
# Apply a set of keywords to matching tokens.
#
# Examples:
#
#   ssh::server::match { 'Group wheel':
#     forcecommand => '/usr/sbin/login_duo'
#   }
#
#   ssh::server::match { 'User bob':
#     forcecommand => '/sbin/nologin'
#   }
#
define ssh::server::match (
  $allowagentforwarding = undef,
  $allowgroups = undef,
  $allowtcpforwarding = undef,
  $allowusers = undef,
  $authenticationmethods = undef,
  $authorizedkeyscommand = undef,
  $authorizedkeyscommanduser = undef,
  $authorizedkeysfile = undef,
  $authorizedprincipalsfile = undef,
  $banner = undef,
  $chrootdirectory = undef,
  $denygroups = undef,
  $denyusers = undef,
  $forcecommand = undef,
  $gatewayports = undef,
  $gssapiauthentication = undef,
  $hostbasedauthentication = undef,
  $hostbasedusesnamefrompacketonly = undef,
  $kbdinteractiveauthentication = undef,
  $kerberosauthentication = undef,
  $maxauthtries = undef,
  $maxsessions = undef,
  $passwordauthentication = undef,
  $permitemptypasswords = undef,
  $permitopen = undef,
  $permitrootlogin = undef,
  $permittty = undef,
  $permittunnel = undef,
  $permituserrc = undef,
  $pubkeyauthentication = undef,
  $rekeylimit = undef,
  $rhostsrsaauthentication = undef,
  $rsaauthentication = undef,
  $x11displayoffset = undef,
  $x11forwarding = undef,
  $x11uselocalhost = undef,
) {

  include ssh::params
  include ssh::server

  $sshd_config = $ssh::params::sshd_config

  $valid_token = [
    'User',
    'Group',
    'Host',
    'Localaddress',
    'Localport',
    'Address',
  ]

  $valid_keywords = [
    'AllowAgentForwarding',
    'AllowGroups',
    'AllowTcpForwarding',
    'AllowUsers',
    'AuthenticationMethods',
    'AuthorizedKeysCommand',
    'AuthorizedKeysCommandUser',
    'AuthorizedKeysFile',
    'AuthorizedPrincipalsFile',
    'Banner',
    'ChrootDirectory',
    'DenyGroups',
    'DenyUsers',
    'ForceCommand',
    'GatewayPorts',
    'GSSAPIAuthentication',
    'HostbasedAuthentication',
    'HostbasedUsesNameFromPacketOnly',
    'KbdInteractiveAuthentication',
    'KerberosAuthentication',
    'MaxAuthTries',
    'MaxSessions',
    'PasswordAuthentication',
    'PermitEmptyPasswords',
    'PermitOpen',
    'PermitRootLogin',
    'PermitTTY',
    'PermitTunnel',
    'PermitUserRC',
    'PubkeyAuthentication',
    'RekeyLimit',
    'RhostsRSAAuthentication',
    'RSAAuthentication',
    'X11DisplayOffset',
    'X11Forwarding',
    'X11UseLocalHost'
  ]

  concat::fragment { "sshd_config_match-${name}":
    order   => '30',
    target  => $sshd_config,
    content => template('ssh/sshd_config-match.erb'),
  }
}
