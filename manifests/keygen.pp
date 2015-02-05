# Define: ssh::keygen
#
# Creates an SSH keypair at the target location.
#
define ssh::keygen (
  $type       = 'rsa',
  $size       = '4096',
  $passphrase = '',
  $target     = '/root/.ssh/id_rsa',
) {

  exec { "Generate ssh key for ${name}":
    command => "/usr/bin/ssh-keygen -t ${type} -b ${size} -N \"${passphrase}\" -f ${target}",
    creates => "${target}.pub",
  }
}
