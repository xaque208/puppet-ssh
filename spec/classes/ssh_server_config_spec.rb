require 'spec_helper'

describe 'ssh::server::config' do
  on_supported_os.each do |os,facts|
    context "on #{os}" do
      let(:facts) { facts }
      it { should contain_class('ssh::server::config') }

      valid_keywords = [
        'AcceptEnv',
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

      space_separated_keywords = [
        'AcceptEnv',
        'AuthorizedKeysFile',
        'DenyGroups',
        'DenyUsers',
      ]

      valid_keywords.each {|kw|
        context "with #{kw.downcase} set" do
          let(:params) { {kw.downcase.to_sym => String.new()} }
          it { should contain_concat__fragment('sshd_config').with_content(/^#{kw} .*$/) }
        end
      }

      context 'with ciphers => []' do
        let(:params) { {:ciphers => ['chacha20-poly1305@openssh.com', 'aes256-ctr']} }

        it { should contain_concat__fragment('sshd_config').with_content(/^Ciphers chacha20-poly1305@openssh.com,aes256-ctr$/) }
      end

      context 'with denyusers => []' do
        let(:params) { {:acceptenv => ['AWS_*', 'TERM']} }

        it { should contain_concat__fragment('sshd_config').with_content(/^AcceptEnv AWS_\* TERM$/) }
      end

      context 'with denyusers => []' do
        let(:params) { {:denyusers => ['test1', 'test2']} }

        it { should contain_concat__fragment('sshd_config').with_content(/^DenyUsers test1 test2$/) }
      end

      context 'with denygroups => []' do
        let(:params) { {:denygroups => ['test1', 'test2']} }

        it { should contain_concat__fragment('sshd_config').with_content(/^DenyGroups test1 test2$/) }
      end

      context 'with authorizedkeysfile => []' do
        let(:params) { {:authorizedkeysfile => ['/path/one', '/path/two']} }

        it { should contain_concat__fragment('sshd_config').with_content(/^AuthorizedKeysFile \/path\/one \/path\/two$/) }
      end


    end
  end
end
