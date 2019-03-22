# This define handles generation of SSH keys through the use of the
# ssh-keygen(8) command.
#
# @example
#   ssh::keygen { 'Root RSA':
#     type => 'rsa',
#     size => 4096
#   }
#
define ssh::keygen (
  Enum['dsa', 'ecdsa', 'ed25519', 'rsa', 'rsa1'] $type = 'rsa',
  Optional[Integer] $size                              = undef,
  Optional[String] $passphrase                         = undef,
  Optional[String] $target                             = undef,
  String $user                                         = 'root',
) {

  if !$size {
    $size_final = ssh::default_key_size($type)
  } else {
    $size_final = ssh::validate_key_size($type, $size)
  }

  if !$target {
    $user_home = $user ? {
      'root'  => '/root',
      default => "/home/${user}",
    }
    $target_final = "${user_home}/.ssh/id_${type}"
  } else {
    $target_final = $target
  }

  $args = [
    $type       ? { default => "-t ${type}" },
    $size_final ? { undef   => undef, default  => "-b ${size_final}" },
    $passphrase ? { default => "-N \"${passphrase}\"" },
    $target     ? { default => "-f ${target_final}" },
  ]

  $args_final = delete_undef_values($args)
  $command = join($args_final, ' ')

  exec { "Generate ${type} SSH key for ${name}":
    command => "/usr/bin/ssh-keygen ${command}",
    creates => "${target_final}.pub",
    user    => $user,
  }
}
