# == Resource: mcollective_profile::plugin
#
# Define an MCollective plugin resource, compatible with mcollective_profile.
#
# === Parameters
#
# Check the documentation for the puppet/mcollective module's plugin resource.
#
# === Variables
#
# === Examples
#
# ::mcollective::plugin
# { 'puppet':
#   package => true,
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
define mcollective_profile::plugin
(
  $ensure     = 'present',

  $source     = undef,
  $package    = false,
  $type       = 'agent',
  $has_client = true,
)
{
  if ($ensure == 'present' or $ensure == present)
  {
    if (!defined(Class['::mcollective_profile::server']))
    {
      fail('The ::mcollective_profile::server class needs to be defined before this resource can be declared')
    }

    realize ::Mcollective_profile::Wrapper['::mcollective_profile::wrapper']

    ::mcollective::plugin
    { $name:
      source     => $source,
      package    => $package,
      type       => $type,
      has_client => $has_client,

      require    => ::Mcollective_profile::Wrapper['::mcollective_profile::wrapper'],
    }
  }
}
