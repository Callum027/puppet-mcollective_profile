# == Class: mcollective_profile
#
# Class where the MCollective configuration is defined.
#
# === Parameters
#
# Check the documentation for the puppet/mcollective module.
# It is a subset of that module, mainly pertaining to middleware hosts
# and security.
#
# === Variables
#
# === Examples
#
#  class { 'mcollective_profile':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Callum Dickinson <callum@huttradio.co.nz>
#
# === Copyright
#
# Copyright 2015 Callum Dickinson.
#
class mcollective_profile
(
  $middleware_hosts,
  $middleware_ssl      = true,
  $middleware_port     = '61613',
  $middleware_ssl_port = '61614',
  $middleware_user     = 'mcollective',
  $middleware_password = 'marionette',

  $connector           = 'rabbitmq',

  $securityprovider    = 'ssl',

  $psk                 = undef,

  $ssl_ca_cert         = undef,
  $ssl_client_certs    = undef,
  $ssl_server_private  = undef,
  $ssl_server_public   = undef,
)
{
  @::mcollective_profile::wrapper
  { '::mcollective_profile::wrapper':
    middleware_hosts   => $middleware_hosts,
    middleware_ssl     => $middlware_ssl,
    middlware_port     => $middleware_port,
    middlware_ssl_port => $middleware_ssl_port,
    middlware_user     => $middleware_user,
    middlware_password => $middleware_password,

    connector          => $connector,

    securityprovider   => $securityprovider,

    psk                => $psk,

    ssl_ca_cert        => $ssl_ca_cert,
    ssl_client_certs   => $ssl_client_certs,
    ssl_server_private => $ssl_server_private,
    ssl_server_public  => $ssl_server_public,
  }
}
