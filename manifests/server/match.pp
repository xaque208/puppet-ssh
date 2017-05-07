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
  $acceptenv                       = undef,
  $allowagentforwarding            = undef,
  $allowgroups                     = undef,
  $allowtcpforwarding              = undef,
  $allowusers                      = undef,
  $authenticationmethods           = undef,
  $authorizedkeyscommand           = undef,
  $authorizedkeyscommanduser       = undef,
  $authorizedkeysfile              = undef,
  $authorizedprincipalsfile        = undef,
  $banner                          = undef,
  $chrootdirectory                 = undef,
  $denygroups                      = undef,
  $denyusers                       = undef,
  $forcecommand                    = undef,
  $gatewayports                    = undef,
  $gssapiauthentication            = undef,
  $hostbasedauthentication         = undef,
  $hostbasedusesnamefrompacketonly = undef,
  $kbdinteractiveauthentication    = undef,
  $kerberosauthentication          = undef,
  $maxauthtries                    = undef,
  $maxsessions                     = undef,
  $passwordauthentication          = undef,
  $permitemptypasswords            = undef,
  $permitopen                      = undef,
  $permitrootlogin                 = undef,
  $permittty                       = undef,
  $permittunnel                    = undef,
  $permituserrc                    = undef,
  $pubkeyauthentication            = undef,
  $rekeylimit                      = undef,
  $rhostsrsaauthentication         = undef,
  $rsaauthentication               = undef,
  $x11displayoffset                = undef,
  $x11forwarding                   = undef,
  $x11uselocalhost                 = undef,
  Integer[30, 99] $order           = 30,
) {

  include ::ssh::server

  $valid_token = [
    'User',
    'Group',
    'Host',
    'Localaddress',
    'Localport',
    'Address',
  ]

  $valid_keywords = [
    'AcceptEnv',
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
    'PubkeyAcceptedKeyTypes',
    'PubkeyAuthentication',
    'RekeyLimit',
    'RhostsRSAAuthentication',
    'RSAAuthentication',
    'X11DisplayOffset',
    'X11Forwarding',
    'X11UseLocalHost',
  ]

  # Keywords that are joined by spaces in the presence of multiple
  # values
  $space_separated_keywords = [
    'AcceptEnv',
    'AuthorizedKeysFile',
    'DenyGroups',
    'DenyUsers',
  ]

  concat::fragment { "sshd_config_match-${name}":
    order   => $order,
    target  => $ssh::sshd_config,
    content => template('ssh/sshd_config-match.erb'),
  }
}
