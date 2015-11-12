# Puppet powered SSH config

[![Build Status](https://travis-ci.org/xaque208/puppet-ssh.svg?branch=master)](https://travis-ci.org/xaque208/puppet-ssh)

A Puppet module for managing SSH server configurations.


## Usage

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




