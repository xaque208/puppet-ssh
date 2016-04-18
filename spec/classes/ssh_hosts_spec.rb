require 'spec_helper'

describe 'ssh::hosts' do
  on_supported_os.each do |os,facts|
    let(:facts) { facts }
    let(:params) { {:host_aliases => ['foo']} }

    it { should contain_class('ssh::hosts') }

    it { expect(exported_resources).to contain_sshkey('sshecdsakey-foo') }
    it { expect(exported_resources).to contain_sshkey('sshed25519key-foo') }
    it { expect(exported_resources).to contain_sshkey('sshdsakey-foo') }
  end
end
