# This class distributes public SSH host keys through the user of exported
# resources, and optionally collects ssh host keys other systems.
#
# @example
#   include ssh::hosts
#
class ssh::hosts (
  Array[String] $host_aliases = [$trusted['certname'], $trusted['hostname']],
  Boolean $collect_keys       = true,
){

  if $facts.dig('ssh','dsa','key') {
    @@sshkey { "sshdsakey-${host_aliases[0]}":
      host_aliases => $host_aliases,
      type         => 'ssh-dss',
      key          => $facts['ssh']['dsa']['key'],
    }
  }

  if $facts.dig('ssh','ecdsa','key') {
    @@sshkey { "sshecdsakey-${host_aliases[0]}":
      host_aliases => $host_aliases,
      type         => 'ecdsa-sha2-nistp256',
      key          => $facts['ssh']['ecdsa']['key'],
    }
  }

  if $facts.dig('ssh','ed25519','key') {
    @@sshkey { "sshed25519key-${host_aliases[0]}":
      host_aliases => $host_aliases,
      type         => 'ssh-ed25519',
      key          => $facts['ssh']['ed25519']['key'],
    }
  }

  if $collect_keys {
    Sshkey <<| |>>
  }
}
