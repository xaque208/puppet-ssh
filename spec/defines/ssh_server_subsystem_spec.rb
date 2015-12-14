require 'spec_helper'

describe 'ssh::server::subsystem' do
  let(:title) { 'sftp' }
  let(:params) { {:system => 'internal-sftp'} }
  let(:facts) {
    {
      :operatingsystem => 'OpenBSD',
      :kernel => 'OpenBSD',
      :concat_basedir => '/dne'
    }
  }
  it { should contain_concat__fragment('sshd_config-subsystem-sftp').with_content(/Subsystem sftp internal-sftp/) }
end

