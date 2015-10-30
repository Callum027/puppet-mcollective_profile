# == Class: mcollective_profile::server
#
# MCollective server profile.
#
# === Parameters
#
# === Variables
#
# === Examples
#
# include ::mcollective_profile::server
#
# === Authors
#
# Callum Dickinson <callum@huttradio.co.nz>
#
# === Copyright
#
# Copyright 2015 Callum Dickinson.
#
class mcollective_profile::server
{
  if (!defined(Class['::mcollective_profile']))
  {
    fail('The ::mcollective_profile base class needs to be defined before this class')
  }

  ::Mcollective_profile::Wrapper <| tag == '::mcollective_profile::wrapper' |>
  {
    server => true,
  }
}
