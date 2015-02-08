require 'spec_helper'

describe 'ssh::keygen' do
  let(:facts) {
    {
      :operatingsystem => 'OpenBSD',
      :kernel => 'OpenBSD',
      :concat_basedir => '/dne'
    }
  }

  context 'when paramaters are valid' do
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

    context 'when bad key type is passed' do
      let(:title) { 'Root' }
      let(:params) {
        {
          :type => 'asd',
          :size=>'2048',
          :target=> '/root/.ssh/id_rsa',
        }
      }
      it { should raise_error(Puppet::Error, /"asd" does not match/) }
    end
  end
end


