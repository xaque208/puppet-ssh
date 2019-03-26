require 'spec_helper'

describe 'ssh::keygen' do
  on_supported_os.each do |_os, facts|
    let(:facts) { facts }
    let(:title) { 'Root' }

    context 'when paramaters are valid' do
      let(:params) do
        {
          type: 'rsa',
          size: 2048,
          target: '/root/.ssh/id_rsa'
        }
      end

      it do
        is_expected.to contain_exec('Generate rsa SSH key for Root').with(command: '/usr/bin/ssh-keygen -t rsa -b 2048 -f /root/.ssh/id_rsa')
      end

      context 'when bad key type is passed' do
        let(:params) do
          {
            type: 'asd',
            size: 2048,
            target: '/root/.ssh/id_rsa'
          }
        end

        it { is_expected.to raise_error(Puppet::PreformattedError, %r{Enum}) }
      end

      context 'when bad key size is passed' do
        let(:params) do
          {
            type: 'rsa',
            size: 512
          }
        end

        it { is_expected.to raise_error(Puppet::Error, %r{RSA keys must be at least 768 bits}) }
      end

      context 'when ed25519 key size is passed' do
        let(:params) do
          {
            type: 'ed25519',
            size: 512
          }
        end

        it do
          is_expected.to contain_exec('Generate ed25519 SSH key for Root').with(command: '/usr/bin/ssh-keygen -t ed25519 -f /root/.ssh/id_ed25519')
          is_expected.to contain_notify('SSH ed25519 keys have a fixed length, size ignored')
        end
      end

      context 'when bad ecdsa key size is passed' do
        let(:params) do
          {
            type: 'ecdsa',
            size: 512
          }
        end

        it { is_expected.to raise_error(Puppet::Error, %r{ECDSA keys may only be of length 256, 384, or 521}) }
      end

      context 'when bad dsa key size is passed' do
        let(:params) do
          {
            type: 'dsa',
            size: 512
          }
        end

        it { is_expected.to contain_notify('Only SSH dsa keys of 1024 size are valid, proceeding as such') }
        it do
          is_expected.to contain_exec('Generate dsa SSH key for Root').with(command: '/usr/bin/ssh-keygen -t dsa -b 1024 -f /root/.ssh/id_dsa')
        end
      end

      context 'when dsa key is requested' do
        let(:params) do
          {
            type: 'dsa'
          }
        end

        it do
          is_expected.to contain_exec('Generate dsa SSH key for Root').with(command: '/usr/bin/ssh-keygen -t dsa -b 1024 -f /root/.ssh/id_dsa')
        end
      end

      context 'when a passphrase is passed' do
        let(:params) do
          {
            passphrase: 'this is my secret passphrase'
          }
        end

        it do
          is_expected.to contain_exec('Generate rsa SSH key for Root').with(command: %r{-N "this is my secret passphrase"})
        end
      end

      context 'with a custom user' do
        let(:params) do
          {
            user: 'charlie'
          }
        end
        let(:title) { 'Charlie' }

        it do
          is_expected.to contain_exec('Generate rsa SSH key for Charlie').with(user: 'charlie', command: '/usr/bin/ssh-keygen -t rsa -b 2048 -f /home/charlie/.ssh/id_rsa')
        end
      end
    end
  end
end
