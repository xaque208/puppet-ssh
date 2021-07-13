# This class distributes public SSH host keys through the user of exported
# resources, and optionally collects ssh host keys other systems.
#
# @example
#   include ssh::hosts
#
class ssh::hosts (
  Array[String] $host_aliases = [$trusted['certname'], $trusted['hostname']],
  Boolean $collect_keys       = true,
) {
  $first = $host_aliases[0]
  $rest  = $host_aliases[1, -1]

  if $facts.dig('ssh','dsa','key') {
    @@sshkey { "${first}@ssh-dss":
      host_aliases => $rest,
      type         => 'ssh-dss',
      key          => $facts['ssh']['dsa']['key'],
    }
  }

  if $facts.dig('ssh','ecdsa','key') {
    @@sshkey { "${first}@ecdsa-sha2-nistp256":
      host_aliases => $rest,
      type         => 'ecdsa-sha2-nistp256',
      key          => $facts['ssh']['ecdsa']['key'],
    }
  }

  if $facts.dig('ssh','ed25519','key') {
    @@sshkey { "${first}@ssh-ed25519":
      host_aliases => $rest,
      type         => 'ssh-ed25519',
      key          => $facts['ssh']['ed25519']['key'],
    }
  }

  if $collect_keys {
    Sshkey <<| |>>
  }
}
