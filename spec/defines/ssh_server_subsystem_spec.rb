require 'spec_helper'

describe 'ssh::server::subsystem' do
  on_supported_os.each do |os,facts|
    context "on #{os}" do
      let(:facts) { facts }

      case facts[:osfamily]
      when 'OpenBSD'
        let(:title) { 'sftp' }
        let(:params) { {:system => 'internal-sftp'} }
        it do
          should contain_concat__fragment('sshd_config-subsystem-sftp').with_content(/Subsystem sftp internal-sftp/)

        end
      else
      end
    end
  end
end

