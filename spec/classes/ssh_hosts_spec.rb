require 'spec_helper'

describe 'ssh::hosts' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      let(:params) { { host_aliases: ['foo'] } }

      it { is_expected.to contain_class('ssh::hosts') }

      if facts.dig(:ssh, :ecdsa)
        it { expect(exported_resources).to contain_sshkey('foo@ecdsa-sha2-nistp256').with(type: 'ecdsa-sha2-nistp256') }
      end

      if facts.dig(:ssh, :dsa)
        it { expect(exported_resources).to contain_sshkey('foo@ssh-dss').with(type: 'ssh-dss') }
      end

      if facts.dig(:ssh, :ed25519)
        it { expect(exported_resources).to contain_sshkey('foo@ssh-ed25519').with(type: 'ssh-ed25519') }
      end
    end
  end
end
