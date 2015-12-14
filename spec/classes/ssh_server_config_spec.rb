require 'spec_helper'

describe 'ssh::server::config' do
  let(:facts) {
    {
      :operatingsystem => 'OpenBSD',
      :kernel => 'OpenBSD',
      :concat_basedir => '/dne'
    }
  }

  it { should contain_class('ssh::server::config') }

  valid_keywords = [
    'AddressFamily',
    'AllowAgentForwarding',
    'AllowTcpForwarding',
    'AllowUsers',
    'AuthenticationMethods',
    'AuthorizedKeysCommand',
    'AuthorizedKeysCommandUser',
    'AuthorizedKeysFile',
    'AuthorizedPrincipalsFile',
    'Banner',
    'ChallengeResponseAuthentication',
    'ChrootDirectory',
    'Ciphers',
    'ClientAliveCountMax',
    'ClientAliveInterval',
    'Compression',
    'DenyGroups',
    'DenyUsers',
    'ForceCommand',
    'GatewayPorts',
    'GSSAPIAuthentication',
    'GSSAPIKeyExchange',
    'GSSAPICleanupCredentials',
    'GSSAPIStrictAcceptorCheck',
    'GSSAPIStoreCredentialsOnRekey',
    'HostbasedAuthentication',
    'HostbasedUsesNameFromPacketOnly',
    'HostCertificate',
    'HostKey',
    'IgnoreRhosts',
    'IgnoreUserKnownHosts',
    'IPQoS',
    'KerberosAuthentication',
    'KerberosOrLocalPasswd',
    'KerberosTicketCleanup',
    'KexAlgorithms',
    'KeyRegenerationInterval',
    'ListenAddress',
    'LoginGraceTime',
    'LogLevel',
    'MACs',
    'MaxAuthTries',
    'MaxSessions',
    'MaxStartups',
    'PasswordAuthentication',
    'PermitEmptyPasswords',
    'PermitOpen',
    'PermitRootLogin',
    'PermitTunnel',
    'PermitUserEnvironment',
    'PidFile',
    'Port',
    'PrintLastLog',
    'PrintMotd',
    'Protocol',
    'PubkeyAuthentication',
    'RevokedKeys',
    'RhostsRSAAuthentication',
    'RSAAuthentication',
    'SACLSupport',
    'ServerKeyBits',
    'StrictModes',
    'SyslogFacility',
    'TCPKeepAlive',
    'TrustedUserCAKeys',
    'UseDNS',
    'UseLogin',
    'UsePAM',
    'UsePrivilegeSeparation',
    'VersionAddendum',
    'X11DisplayOffset',
    'X11Forwarding',
    'X11UseLocalhost',
    'XAuthLocation',
  ]

  valid_keywords.each {|kw|
    context "with #{kw.downcase} set" do
      let(:params) { {kw.downcase.to_sym => String.new()} }
      it { should contain_concat__fragment('sshd_config').with_content(/^#{kw}/) }
    end
  }
end
