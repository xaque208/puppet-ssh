require 'spec_helper'

describe 'ssh::hosts' do
  on_supported_os.each do |os,facts|
    context "on #{os}" do
      let(:facts) { facts }
      let(:params) { {:host_aliases => ['foo']} }

      it { should contain_class('ssh::hosts') }

      if facts.keys.include? :sshecdsakey
        it { expect(exported_resources).to contain_sshkey('sshecdsakey-foo') }
      end

      if facts.keys.include? :sshdsakey
        it { expect(exported_resources).to contain_sshkey('sshdsakey-foo') }
      end

      if facts.keys.include? :sshed25519key
        it { expect(exported_resources).to contain_sshkey('sshed25519key-foo') }
      end

    end
  end
end
