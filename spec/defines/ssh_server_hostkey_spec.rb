require 'spec_helper'

describe 'ssh::server::hostkey' do
  on_supported_os.each do |_os, facts|
    let(:facts) { facts }
    let(:title) { 'rsa' }

    context 'with default params' do
      let(:params) { { path: '/path/to/rsa_hostkey' } }

      it { is_expected.to contain_concat__fragment('sshd_config-hostkey-rsa').with_content(%r{HostKey \/path\/to\/rsa_hostkey}) }
    end

    context 'with order set' do
      let(:params) do
        {
          path: '/path/to/rsa_hostkey',
          order: 45
        }
      end

      it do
        is_expected.to contain_concat__fragment('sshd_config-hostkey-rsa').with(content: %r{HostKey \/path\/to\/rsa_hostkey},
                                                                                order: 45)
      end
    end
  end
end
