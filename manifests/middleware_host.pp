# == Class: mcollective_profile::middleware_host
#
# MCollective middleware host profile. Uses the RabbitMQ broker.
#
# === Parameters
#
# === Variables
#
# === Examples
#
# include ::mcollective_profile::middleware_host
#
# === Authors
#
# Callum Dickinson <callum@huttradio.co.nz>
#
# === Copyright
#
# Copyright 2015 Callum Dickinson.
#
class mcollective_profile::middleware_host
(
  $ssl_ca_cert                = $::mcollective_profile::ssl_ca_cert,
  $ssl_server_cert            = $::mcollective_profile::ssl_server_cert,
  $ssl_server_private         = $::mcollective_profile::ssl_server_private,

  $middleware_port            = $::mcollective_profile::middleware_port,
  $middleware_ssl_port        = $::mcollective_profile::middleware_ssl_port,
  $middleware_user            = $::mcollective_profile::middleware_user,
  $middleware_password        = $::mcollective_profile::middleware_password,

  $middleware_admin_user      = 'admin',
  $middleware_admin_password  = 'secret',

  $rabbitmq_config_dir        = '/etc/rabbitmq',
  $rabbitmq_vhost             = '/mcollective',
  $rabbitmq_delete_guest_user = false,
)
{
  if (!defined(Class['::mcollective_profile']))
  {
    fail('The ::mcollective_profile base class needs to be defined before this class')
  }

  file
  { "${rabbitmq_config_dir}/ca.pem":
    owner  => 'rabbitmq',
    group  => 'rabbitmq',
    mode   => '0444',
    source => $ssl_ca_cert,
    notify => Class['::rabbitmq::service'],
  }

  file
  { "${rabbitmq_config_dir}/server_cert.pem":
    owner  => 'rabbitmq',
    group  => 'rabbitmq',
    mode   => '0444',
    source => $ssl_server_cert,
    notify => Class['::rabbitmq::service'],
  }

  file
  { "${rabbitmq_config_dir}/server_private.pem":
    owner  => 'rabbitmq',
    group  => 'rabbitmq',
    mode   => '0400',
    source => $ssl_server_private,
    notify => Class['::rabbitmq::service'],
  }

  class
  { '::rabbitmq':
    config_stomp      => true,
    delete_guest_user => $rabbitmq_delete_guest_user,
    ssl               => true,
    stomp_port        => $middleware_port,
    ssl_stomp_port    => $middleware_ssl_port,
    ssl_cacert        => "${rabbitmq_config_dir}/ca.pem",
    ssl_cert          => "${rabbitmq_config_dir}/server_cert.pem",
    ssl_key           => "${rabbitmq_config_dir}/server_private.pem",
  }

  contain ::rabbitmq

  rabbitmq_plugin
  { 'rabbitmq_stomp':
    ensure => 'present',
    notify => Service['rabbitmq-server'],
  }

  rabbitmq_vhost
  { $rabbitmq_vhost:
    ensure => 'present',
    notify => Service['rabbitmq-server'],
  }

  rabbitmq_user
  { $middleware_user:
    ensure   => 'present',
    admin    => false,
    password => $middleware_password,
    notify   => Service['rabbitmq-server'],
  }

  rabbitmq_user
  { $middleware_admin_user:
    ensure   => 'present',
    admin    => true,
    password => $middleware_admin_password,
    notify   => Service['rabbitmq-server'],
  }

  rabbitmq_user_permissions
  { "${middleware_user}@${rabbitmq_vhost}":
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
    notify               => Service['rabbitmq-server'],
  }

  rabbitmq_user_permissions
  { "${middleware_admin_user}@${rabbitmq_vhost}":
    configure_permission => '.*',
    notify               => Service['rabbitmq-server'],
  }

  rabbitmq_exchange
  { "mcollective_broadcast@${rabbitmq_vhost}":
    ensure   => 'present',
    type     => 'topic',
    user     => $middleware_admin_user,
    password => $middleware_admin_password,
  }

  rabbitmq_exchange
  { "mcollective_directed@${rabbitmq_vhost}":
    ensure   => 'present',
    type     => 'direct',
    user     => $middleware_admin_user,
    password => $middleware_admin_password,
  }
}