# == Class: mcollective_profile::params
#
# System-specific configuration parameters.
#
# === Parameters
#
# === Variables
#
# === Examples
#
# === Authors
#
# Callum Dickinson <callum@huttradio.co.nz>
#
# === Copyright
#
# Copyright 2015 Callum Dickinson.
#
class mcollective_profile::params
{
  case $::osfamily
  {
    'Debian':
    {
      # RabbitMQ configuration.
      $rabbitmq_config_dir = '/etc/rabbitmq'
    }

    # RedHat support will come at a later time!

    default:
    {
      fail("Sorry, but this site module does not support the ${::osfamily} OS family at this time")
    }
  }
}
