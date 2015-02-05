# Class: ssh::hosts
#
# Distribute ssh-dss host keys from all hosts to all hosts.
#
class ssh::hosts {

  @@sshkey { $::hostname:
    type => 'ssh-dss',
    key  => $::sshdsakey,
  }

  Sshkey <<| |>>
}
