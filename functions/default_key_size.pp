function ssh::default_key_size (
  String $type
) {
  case $type {
    'dsa': {
      1024
    }
    'ecdsa': {
      521
    }
    'ed25519': {
      undef
    }
    'rsa': {
      2048
    }
    'rsa1': {
      2048
    }
    default: {}
  }
}
