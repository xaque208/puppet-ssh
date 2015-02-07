require 'spec_helper'

describe 'ssh' do
  context "when on openbsd" do
    let(:facts) {
      {
        :operatingsystem => 'OpenBSD',
        :kernel => 'OpenBSD',
        :concat_basedir => '/dne'
      }
    }
    it { should contain_class('ssh') }
  end

  context "when on debian" do
    let(:facts) {
      {
        :operatingsystem => 'Debian',
        :kernel => 'Debian',
        :concat_basedir => '/dne'
      }
    }
    it { should contain_class('ssh') }
  end
end

