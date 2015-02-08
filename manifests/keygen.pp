# Define: ssh::keygen
#
# Creates an SSH keypair at the target location.
#
define ssh::keygen (
  $type       = 'rsa',
  $size       = undef,
  $passphrase = '',
  $target     = '/root/.ssh/id_rsa',
) {

  validate_re($type, ['dsa', 'ecdsa', 'ed25519', 'rsa', 'rsa1'])

  case $type {
    'dsa': {
      if $size != '1024' {
        notify { 'Only SSH dsa keys of 1024 size are valid, setting as such': }
      }
      $size_final = '1024'
    }
    'ecdsa': {
      validate_re($size, ['256', '384', '521'])
      $size_final = $size
    }
    'ed25519': {
      if $size {
        notify { 'SSH ed25519 keys have a fixed length, size ignored': }
      }
      $size_final = undef
    }
    'rsa': {
      if ! $size {
        $size_final = '2048'
      } elsif $size > '768' {
        $size_final = $size
      } else {
        fail("RSA keys must be at least 768 bits")
      }
    }
    'rsa1': {
      $size_final = $size
    }
  }

  $args = [
    $type       ? { default => "-t ${type}" },
    $size_final ? { undef   => undef, default  => "-b ${size_final}" },
    $passphrase ? { default => "-N \"${passphrase}\"" },
    $target     ? { default => "-f ${target}" },
  ]

  $args_final = delete_undef_values($args)
  $command = join($args_final, ' ')

  exec { "Generate ssh key for ${name}":
    command => "/usr/bin/ssh-keygen ${command}",
    creates => "${target}.pub",
  }
}
