# Puppet powered SSH config

[![Puppet Forge](https://img.shields.io/puppetforge/v/zleslie/ssh.svg)]() [![Build Status](https://travis-ci.org/xaque208/puppet-ssh.svg?branch=master)](https://travis-ci.org/xaque208/puppet-ssh)

A Puppet module for managing OpenSSH servers and configurations.


## Usage

### ssh::allowgroup

Easily allow a POSIX group in with `AllowGroups`.

```Puppet
ssh::allowgroup { 'admins': }
```

### ssh::hosts

Distribute SSH host keys to all systems in the fleet.

```Puppet
include ssh::hosts
```

### ssh::keygen

Easily define a key that should be generated at a specific location with
`ssh::keygen`.

```Puppet
ssh::keygen { 'Root':
  type   => 'ECDSA',
  size   => '521',
  target => '/root/.ssh/id_ecdsa',
}
```

### ssh::server

Manage the `sshd_config(5)` file and its daemon, `sshd(8)`.  See also the
`ssh::server::config` class.

```Puppet
include ssh::server
```

Configure some server configuration options with some `hiera` data.

```yaml
ssh::server::config::has_pam: 'yes'
ssh::server::config::usepam: 'yes'
ssh::server::config::ciphers:
  - 'chacha20-poly1305@openssh.com'
  - 'aes256-ctr'
  - 'aes192-ctr'
  - 'aes128-ctr'
ssh::server::config::kexalgorithms:
  - 'curve25519-sha256@libssh.org'
  - 'diffie-hellman-group-exchange-sha256'
ssh::server::config::macs:
  - 'hmac-sha2-512-etm@openssh.com'
  - 'hmac-sha2-256-etm@openssh.com'
  - 'hmac-ripemd160-etm@openssh.com'
  - 'umac-128-etm@openssh.com'
  - 'hmac-sha2-512'
  - 'hmac-sha2-256'
  - 'hmac-ripemd160'
  - 'umac-128@openssh.com'
```

