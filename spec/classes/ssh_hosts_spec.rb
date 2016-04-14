require 'spec_helper'

describe 'ssh::hosts' do
  let(:facts) {
    {
      :hostname => 'flort',
      :operatingsystem => 'OpenBSD',
      :kernel => 'OpenBSD',
      :concat_basedir => '/dne',
      :sshdsakey => 'fffffffffffffffffffffff',
      :sshecdsakey => 'fffffffffffffffffffffffffff',
      :sshed25519key => 'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
      :sshfp_dsa => 'SSHFP 2 1 ffffffffffffffffffffffffffffffffffffffff',
      :sshfp_ecdsa => 'SSHFP 3 1 ffffffffffffffffffffffffffffffffffffffff',
      :sshfp_ed25519 => 'SSHFP 4 1 ffffffffffffffffffffffffffffffffffffffff',
      :sshfp_rsa => 'SSHFP 1 1 ffffffffffffffffffffffffffffffffffffffff',
    }
  }

  it { should contain_class('ssh::hosts') }

  it { expect(exported_resources).to contain_sshkey('sshecdsakey-flort') }
  it { expect(exported_resources).to contain_sshkey('sshed25519key-flort') }
  it { expect(exported_resources).to contain_sshkey('sshdsakey-flort') }

end
