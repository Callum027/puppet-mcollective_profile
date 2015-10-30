# == Class: mcollective_profile::client
#
# MCollective client profile.
#
# === Parameters
#
# === Variables
#
# === Examples
#
# include ::mcollective_profile::client
#
# === Authors
#
# Callum Dickinson <callum@huttradio.co.nz>
#
# === Copyright
#
# Copyright 2015 Callum Dickinson.
#
class mcollective_profile::client
{
  if (!defined(Class['::mcollective_profile']))
  {
    fail('The ::mcollective_profile base class needs to be defined before this class')
  }

  ::Mcollective_profile::Wrapper <| title == '::mcollective_profile::wrapper' |>
  {
    client => true,
  }
}
