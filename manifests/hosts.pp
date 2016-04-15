# Class: ssh::hosts
#
# Distribute ssh-dss host keys from all hosts to all hosts.
#
class ssh::hosts (
  $host_aliases = [$trusted['certname'], $trusted['hostname']],
){

  validate_array($host_aliases)

  if $::sshdsakey {
    @@sshkey { "sshdsakey-${::hostname}":
      host_aliases => $host_aliases,
      type         => 'ssh-dss',
      key          => $::sshdsakey,
    }
  }

  if $::sshecdsakey {
    @@sshkey { "sshecdsakey-${::hostname}":
      host_aliases => $host_aliases,
      type         => 'ecdsa-sha2-nistp256',
      key          => $::sshecdsakey,
    }
  }

  if $::sshed25519key {
    @@sshkey { "sshed25519key-${::hostname}":
      host_aliases => $host_aliases,
      type         => 'ssh-ed25519',
      key          => $::sshed25519key,
    }
  }

  Sshkey <<| |>>
}
