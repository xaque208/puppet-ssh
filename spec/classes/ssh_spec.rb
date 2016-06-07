require 'spec_helper'

describe 'ssh' do
  on_supported_os.each do |os,facts|
    context "on #{os}" do
      let(:facts) { facts }
      it { should contain_class('ssh') }
    end
  end
end
