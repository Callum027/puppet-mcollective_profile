# == Resource: mcollective_profile::user
#
# Define an MCollective user resource, compatible with mcollective_profile.
#
# === Parameters
#
# Check the documentation for the puppet/mcollective module's user resource.
#
# === Variables
#
# === Examples
#
# ::mcollective_profile::user
# { 'puppet':
#   certificate => '/etc/ssl/certs/puppet.pem',
#   private_key => '/etc/ssl/private/puppet.pem',
# }
#
# === Authors
#
# Callum Dickinson <callum@huttradio.co.nz>
#
# === Copyright
#
# Copyright 2015 Callum Dickinson.
#
define mcollective_profile::user
(
  $ensure            = 'present',
  $manage_user       = false,

  $username          = $name,
  $callerid          = $name,
  $group             = $name,
  $homedir           = "/home/${name}",

  $certificate       = undef,
  $private_key       = undef,

  $ssl_ca_cert       = $::mcollective_profile::ssl_ca_cert,
  $ssl_server_public = $::mcollective_profile::ssl_server_public,

  $middleware_hosts  = $::mcollective_profile::middleware_hosts,
  $middleware_ssl    = $::mcollective_profile::middleware_ssl,

  $securityprovider  = $::mcollective_profile::securityprovider,
  $connector         = $::mcollective_profile::connector,
)
{
  if ($manage_user == true)
  {
    user
    { $name:
      ensure     => $ensure,

      home       => $homedir,
      managehome => true,

      password   => '!',
      shell      => '/usr/sbin/nologin',

      before     => ::Mcollective::User[$name],
    }
  }

  if ($ensure == 'present' or $ensure == present)
  {
    ::mcollective::user
    { $name:
      username          => $username,
      callerid          => $callerid,
      group             => $group,
      homedir           => $homedir,

      certificate       => $certificate,
      private_key       => $private_key,

      ssl_ca_cert       => $ssl_ca_cert,
      ssl_server_public => $ssl_server_public,

      middleware_hosts  => $middleware_hosts,
      middleware_ssl    => $middleware_ssl,

      securityprovider  => $securityprovider,
      connector         => $connector,

      require           => Class['::mcollective_profile::client'],
    }

    if (defined(Class['::mcollective_profile::server']))
    {
      Class['::mcollective_profile::server'] -> ::Mcollective::User[$name]
    }
  }
}
