require 'spec_helper'

describe 'ssh::server::subsystem' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      case facts[:osfamily]
      when 'OpenBSD'
        let(:title) { 'sftp' }
        let(:params) { { system: 'internal-sftp' } }
        it do
          is_expected.to contain_concat__fragment('sshd_config-subsystem-sftp').with_content(%r{Subsystem sftp internal-sftp})
        end
      end
    end
  end
end
