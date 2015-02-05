require 'spec_helper'

describe 'ssh' do
  let(:facts) {
    {
      :operatingsystem => 'OpenBSD',
      :concat_basedir => '/dne'
    }
  }
  it { should contain_class('ssh') }
end

