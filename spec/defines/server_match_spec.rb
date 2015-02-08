
require 'spec_helper'

describe 'ssh::server::match' do
  context "when on openbsd" do
    let(:facts) {
      {
        :operatingsystem => 'OpenBSD',
        :kernel => 'OpenBSD',
        :concat_basedir => '/dne'
      }
    }
    let(:title) { 'Group nerds' }
    it do
      should contain_class('ssh::server')
      should contain_concat__fragment('sshd_config_match-Group nerds').with({
        :target => '/etc/ssh/sshd_config'
      })
    end
  end
end
