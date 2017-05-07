# This function validates a key size for a given type.
#
function ssh::validate_key_size(
  String $type,
  Integer $size
) {

  case $type {
    'dsa': {
      if $size != 1024 {
        notify { 'Only SSH dsa keys of 1024 size are valid, proceeding as such': }
      }
      $size_final = 1024
    }
    'ecdsa': {
      if $size in [256, 384, 521] {
        $size_final = $size
      } else {
        fail('ECDSA keys may only be of length 256, 384, or 521')
      }
    }
    'ed25519': {
      if $size != 0 {
        notify { 'SSH ed25519 keys have a fixed length, size ignored': }
      }
      $size_final = undef
    }
    'rsa': {
      if ! $size {
        $size_final = 2048
      } elsif $size > 768 {
        $size_final = $size
      } else {
        fail('RSA keys must be at least 768 bits')
      }
    }
    'rsa1': {
      $size_final = $size
    }
    default: {}
  }
}
