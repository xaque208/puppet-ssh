require 'spec_helper'

describe 'ssh::server::match' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      let(:title) { 'Group nerds' }

      it { is_expected.to contain_class('ssh::server') }

      valid_keywords = %w[
        AcceptEnv
        AllowAgentForwarding
        AllowGroups
        AllowTcpForwarding
        AllowUsers
        AuthenticationMethods
        AuthorizedKeysCommand
        AuthorizedKeysCommandUser
        AuthorizedKeysFile
        AuthorizedPrincipalsFile
        Banner
        ChrootDirectory
        DenyGroups
        DenyUsers
        ForceCommand
        GatewayPorts
        GSSAPIAuthentication
        HostbasedAuthentication
        HostbasedUsesNameFromPacketOnly
        KbdInteractiveAuthentication
        KerberosAuthentication
        LogLevel
        MaxAuthTries
        MaxSessions
        PasswordAuthentication
        PermitEmptyPasswords
        PermitOpen
        PermitRootLogin
        PermitTTY
        PermitTunnel
        PermitUserRC
        PubkeyAcceptedKeyTypes
        PubkeyAuthentication
        RekeyLimit
        RhostsRSAAuthentication
        RSAAuthentication
        X11DisplayOffset
        X11Forwarding
        X11UseLocalHost
      ]

      valid_keywords.each do |kw|
        context "with #{kw.downcase} set" do
          case kw.downcase
          when 'LogLevel'
            let(:params) { { log_level: 'INFO' } }
          else
            let(:params) { { kw.downcase.to_sym => '' } }
          end

          it { is_expected.to contain_concat__fragment('sshd_config_match-Group nerds').with_content(%r{^\s+#{kw} .*$}) }
          it { is_expected.to contain_concat__fragment('sshd_config_match-Group nerds').with(target: '/etc/ssh/sshd_config', content: %r{^Match Group nerds$}) }
        end
      end

      context 'with order set' do
        let(:title) { 'Group nerds' }
        let(:params) do
          {
            order: 31
          }
        end

        case facts[:osfamily]
        when 'OpenBSD'
          it do
            is_expected.to contain_class('ssh::server')
            is_expected.to contain_concat__fragment('sshd_config_match-Group nerds').with(target: '/etc/ssh/sshd_config',
                                                                                          content: %r{^Match Group nerds$},
                                                                                          order: 31)
          end
        end
      end
    end
  end
end
