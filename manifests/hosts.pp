# Class: ssh::hosts
#
# Distribute ssh-dss host keys from all hosts to all hosts.
#
class ssh::hosts {

  if $::sshdsakey {
    @@sshkey { "sshdsakey-${::hostname}":
      type => 'ssh-dss',
      key  => $::sshdsakey,
    }
  }

  if $::sshecdsakey {
    @@sshkey { "sshecdsakey-${::hostname}":
      type => 'ecdsa-sha2-nistp256',
      key  => $::sshecdsakey,
    }
  }

  if $::sshed25519key {
    @@sshkey { "sshed25519key-${::hostname}":
      type => 'ssh-ed25519',
      key  => $::sshed25519key,
    }
  }

  Sshkey <<| |>>
}
