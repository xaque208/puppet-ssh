# This class distributes public SSH host keys through the user of exported
# resources, and optionally collects ssh host keys other systems.
#
# @example
#   include ssh::hosts
#
class ssh::hosts (
  Array $host_aliases   = [$trusted['certname'], $trusted['hostname']],
  Boolean $collect_keys = true,
){

  validate_array($host_aliases)

  if $facts['sshdsakey'] {
    @@sshkey { "sshdsakey-${::hostname}":
      host_aliases => $host_aliases,
      type         => 'ssh-dss',
      key          => $::sshdsakey,
    }
  }

  if $facts['sshecdsakey'] {
    @@sshkey { "sshecdsakey-${::hostname}":
      host_aliases => $host_aliases,
      type         => 'ecdsa-sha2-nistp256',
      key          => $::sshecdsakey,
    }
  }

  if $facts['sshed25519key'] {
    @@sshkey { "sshed25519key-${::hostname}":
      host_aliases => $host_aliases,
      type         => 'ssh-ed25519',
      key          => $::sshed25519key,
    }
  }

  if $collect_keys {
    Sshkey <<| |>>
  }
}
