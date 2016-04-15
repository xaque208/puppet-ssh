require 'spec_helper'

describe 'ssh::keygen' do

  on_supported_os.each do |os,facts|
    let(:facts) { facts }
    let(:title) { 'Root' }

    context 'when paramaters are valid' do
      let(:params) {
        {
          :type   => 'rsa',
          :size   => '2048',
          :target => '/root/.ssh/id_rsa',
        }
      }
      it do
        should contain_exec('Generate ssh key for Root').with({
          :command => '/usr/bin/ssh-keygen -t rsa -b 2048 -N "" -f /root/.ssh/id_rsa'
        })
      end

      context 'when bad key type is passed' do
        let(:params) {
          {
            :type   => 'asd',
            :size   => '2048',
            :target => '/root/.ssh/id_rsa',
          }
        }
        it { should raise_error(Puppet::Error, /"asd" does not match/) }
      end

      context 'when bad key size is passed' do
        let(:params) {
          {
            :type   => 'rsa',
            :size   => '512',
          }
        }
        it { should raise_error(Puppet::Error, /RSA keys must be at least 768 bits/) }
      end

      context 'when ed25519 key size is passed' do
        let(:params) {
          {
            :type   => 'ed25519',
            :size   => '512',
          }
        }
        it do
          should contain_exec('Generate ssh key for Root').with({
            :command => '/usr/bin/ssh-keygen -t ed25519 -N "" -f /root/.ssh/id_rsa'
          })
          should contain_notify('SSH ed25519 keys have a fixed length, size ignored')
        end
      end

      context 'when bad ecdsa key size is passed' do
        let(:params) {
          {
            :type   => 'ecdsa',
            :size   => '512',
          }
        }
        it { should raise_error(Puppet::Error, /"512" does not match/) }
      end

      context 'when bad dsa key size is passed' do
        let(:params) {
          {
            :type   => 'ecdsa',
            :size   => '512',
          }
        }
        it { should raise_error(Puppet::Error, /"512" does not match/) }
      end

      context 'when dsa key is requested' do
        let(:params) {
          {
            :type => 'dsa',
          }
        }
        it do
          should contain_exec('Generate ssh key for Root').with({
            :command => '/usr/bin/ssh-keygen -t dsa -b 1024 -N "" -f /root/.ssh/id_rsa'
          })
        end
      end
    end
  end
end
