# == Resource: mcollective_profile::actionpolicy
#
# Define an MCollective action policy resource, compatible with mcollective_profile.
#
# === Parameters
#
# Check the documentation for the puppet/mcollective module's actionpolicy resource.
#
# === Variables
#
# === Examples
#
# ::mcollective_profile::actionpolicy
# { 'puppet':
#   default => 'deny',
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
define mcollective_profile::actionpolicy
(
  $ensure  = 'present',
  $default = 'deny',
)
{
  if ($ensure == 'present' or $ensure == present)
  {
    ::mcollective::actionpolicy
    { $name:
      default => $default,
      require => Class['::mcollective_profile::server'],
    }
  }
}
