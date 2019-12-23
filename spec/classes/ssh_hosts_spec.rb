require 'spec_helper'

describe 'ssh::hosts' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      let(:params) { { host_aliases: ['foo'] } }

      it { is_expected.to contain_class('ssh::hosts') }

      if facts.dig(:ssh, :ecdsa)
        it { expect(exported_resources).to contain_sshkey('sshecdsakey-foo') }
      end

      if facts.dig(:ssh, :dsa)
        it { expect(exported_resources).to contain_sshkey('sshdsakey-foo') }
      end

      if facts.dig(:ssh, :ed25519)
        it { expect(exported_resources).to contain_sshkey('sshed25519key-foo') }
      end
    end
  end
end
