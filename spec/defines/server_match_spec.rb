require 'spec_helper'

describe 'ssh::server::match' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      case facts[:osfamily]
      when 'OpenBSD'
        let(:title) { 'Group nerds' }

        it do
          is_expected.to contain_class('ssh::server')
          is_expected.to contain_concat__fragment('sshd_config_match-Group nerds').with(target: '/etc/ssh/sshd_config',
                                                                                        content: %r{^Match Group nerds$})
        end
      end

      context 'with order set' do
        let(:title) { 'Group nerds' }
        let(:params) do
          {
            order: 31
          }
        end

        case facts[:osfamily]
        when 'OpenBSD'
          it do
            is_expected.to contain_class('ssh::server')
            is_expected.to contain_concat__fragment('sshd_config_match-Group nerds').with(target: '/etc/ssh/sshd_config',
                                                                                          content: %r{^Match Group nerds$},
                                                                                          order: 31)
          end
        end
      end
    end
  end
end
