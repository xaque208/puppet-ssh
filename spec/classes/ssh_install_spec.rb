require 'spec_helper'

describe 'ssh::install' do

  on_supported_os.each do |os,facts|
    let(:facts) { facts }

    it { is_expected.to contain_class('ssh::install') }
    context 'when needs_install is true'  do
      let(:params) { {:needs_install => true, :ssh_packages => 'openssh'} }
      it { is_expected.to contain_package('openssh') }
    end

    context 'when needs_install is false'  do
      let(:params) { {:needs_install => false, :ssh_packages => 'openssh'} }
      it { is_expected.not_to contain_package('openssh') }
    end
  end
end
