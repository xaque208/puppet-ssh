require 'spec_helper'

describe 'ssh::server::match' do
  on_supported_os.each do |os,facts|
    context "on #{os}" do
      let(:facts) { facts }

      case facts[:osfamily]
      when 'OpenBSD'
        let(:title) { 'Group nerds' }
        it do
          should contain_class('ssh::server')
          should contain_concat__fragment('sshd_config_match-Group nerds').with({
            :target => '/etc/ssh/sshd_config',
            :content => /^Match Group nerds$/,
          })
        end
      else
      end

      context 'with order set' do
        let(:title) { 'Group nerds' }
        let(:params) {
          {
            :order => 31
          }
        }
        case facts[:osfamily]
        when 'OpenBSD'
          it do
            should contain_class('ssh::server')
            should contain_concat__fragment('sshd_config_match-Group nerds').with({
              :target => '/etc/ssh/sshd_config',
              :content => /^Match Group nerds$/,
              :order => 31,
            })
          end
        else
        end
      end

    end
  end
end
