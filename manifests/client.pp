class ssh::client {
  include ::ssh
  include ::ssh::client::config

  concat::fragment { 'ssh_config-header':
    order   => '00',
    target  => $ssh::ssh_config,
    content => template('ssh/ssh_config-header.erb'),
  }
}
