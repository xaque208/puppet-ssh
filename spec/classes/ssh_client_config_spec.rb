require 'spec_helper'

describe 'ssh::client::config' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      it { is_expected.to contain_class('ssh::client::config') }

      valid_keywords = %w[
        AddKeysToAgent
        AddressFamily
        BatchMode
        BindAddress
        CanonicalDomains
        CanonicalizeFallbackLocal
        CanonicalizeHostname
        CanonicalizeMaxDots
        CanonicalizePermittedCNAMEs
        CertificateFile
        ChallengeResponseAuthentication
        CheckHostIP
        Cipher
        Ciphers
        ClearAllForwardings
        Compression
        CompressionLevel
        ConnectionAttempts
        ConnectTimeout
        ControlMaster
        ControlPath
        ControlPersist
        DynamicForward
        EnableSSHKeysign
        EscapeChar
        ExitOnForwardFailure
        FingerprintHash
        ForwardAgent
        ForwardX11
        ForwardX11Timeout
        ForwardX11Trusted
        GatewayPorts
        GlobalKnownHostsFile
        GSSAPIAuthentication
        GSSAPIDelegateCredentials
        HashKnownHosts
        HostbasedAuthentication
        HostbasedKeyTypes
        HostKeyAlgorithms
        HostKeyAlias
        HostName
        IdentitiesOnly
        IdentityAgent
        IdentityFile
        IgnoreUnknown
        Include
        IPQoS
        KbdInteractiveAuthentication
        KbdInteractiveDevices
        KexAlgorithms
        LocalCommand
        LocalForward
        LogLevel
        MACs
        NoHostAuthenticationForLocalhost
        NumberOfPasswordPrompts
        PasswordAuthentication
        PermitLocalCommand
        PKCS11Provider
        Port
        PreferredAuthentications
        Protocol
        ProxyCommand
        ProxyJump
        ProxyUseFdpass
        PubkeyAcceptedKeyTypes
        PubkeyAuthentication
        RekeyLimit
        RemoteForward
        RequestTTY
        RevokedHostKeys
        RhostsRSAAuthentication
        RSAAuthentication
        SendEnv
        ServerAliveCountMax
        ServerAliveInterval
        StreamLocalBindMask
        StreamLocalBindUnlink
        StrictHostKeyChecking
        TCPKeepAlive
        Tunnel
        TunnelDevice
        UpdateHostKeys
        UsePrivilegedPort
        User
        UserKnownHostsFile
        VerifyHostKeyDNS
        VersionAddendum
        VisualHostKey
        XAuthLocation
      ]

      space_separated_keywords = %w[
        GlobalKnownHostsFile
        IPQoS
        SendEnv
        UserKnownHostsFile
      ]

      it "should validate space separated keywords #{space_separated_keywords}"

      valid_keywords.each do |kw|
        context "with #{kw.downcase} set" do
          let(:params) { { kw.downcase.to_sym => '' } }

          it { is_expected.to contain_concat__fragment('ssh_config').with_content(%r{^#{kw} .*$}) }
        end
      end

      context 'with ciphers => []' do
        let(:params) { { ciphers: ['chacha20-poly1305@openssh.com', 'aes256-ctr'] } }

        it { is_expected.to contain_concat__fragment('ssh_config').with_content(%r{^Ciphers chacha20-poly1305@openssh.com,aes256-ctr$}) }
      end

      context 'with globalknownhostsfile => []' do
        let(:params) { { globalknownhostsfile:  ['/path/one', '/path/two'] } }

        it { is_expected.to contain_concat__fragment('ssh_config').with_content(%r{^GlobalKnownHostsFile /path/one /path/two$}) }
      end

      context 'with ipqos => []' do
        let(:params) { { ipqos: %w[lowdelay throughput] } }

        it { is_expected.to contain_concat__fragment('ssh_config').with_content(%r{^IPQoS lowdelay throughput$}) }
      end

      context 'with sendenv => []' do
        let(:params) { { sendenv: ['AWS_*', 'TERM'] } }

        it { is_expected.to contain_concat__fragment('ssh_config').with_content(%r{^SendEnv AWS_\* TERM$}) }
      end

      context 'with userknownhostsfile => []' do
        let(:params) { { userknownhostsfile:  ['/path/one', '/path/two'] } }

        it { is_expected.to contain_concat__fragment('ssh_config').with_content(%r{^UserKnownHostsFile /path/one /path/two$}) }
      end
    end
  end
end
