require 'spec_helper'

describe 'ssh::keygen' do
  let(:facts) {
    {
      :operatingsystem => 'OpenBSD',
      :kernel => 'OpenBSD',
      :concat_basedir => '/dne'
    }
  }
  let(:title) { 'Root' }
  let(:params) {
    {
      :type => 'rsa',
      :size=>'2048',
      :target=> '/root/.ssh/id_rsa',
    }
  }
  it do
    should contain_exec('Generate ssh key for Root').with({
      :command => '/usr/bin/ssh-keygen -t rsa -b 2048 -N "" -f /root/.ssh/id_rsa'
    })
  end
end


