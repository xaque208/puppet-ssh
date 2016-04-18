require 'spec_helper'

describe 'ssh::allowgroup' do
  on_supported_os.each do |os,facts|
    let(:facts) { facts }
    let(:title) { 'wheel' }

    context "with default params" do
      it { is_expected.to contain_concat__fragment('sshd_config_AllowGroups-wheel').with_content("AllowGroups wheel\n") }
    end

  end
end

