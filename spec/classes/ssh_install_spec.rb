require 'spec_helper'

describe 'ssh::install' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      it { is_expected.to contain_class('ssh::install') }

      case facts[:osfamily]
      when 'Debian'
        it { is_expected.to contain_package('openssh-client') }
        it { is_expected.to contain_package('openssh-server') }
      when 'RedHat'
        it { is_expected.to contain_package('openssh-clients') }
        it { is_expected.to contain_package('openssh-server') }
      when 'Solaris'
        it { is_expected.to contain_package('network/ssh') }
      when 'Suse'
        it { is_expected.to contain_package('openssh') }
      end
    end
  end
end
