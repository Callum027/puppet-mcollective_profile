define mcollective_profile::wrapper
(
  $middleware_hosts,
  $middleware_ssl,
  $middleware_port,
  $middleware_ssl_port,
  $middleware_user,
  $middleware_password,

  $connector,

  $securityprovider,

  $psk,

  $ssl_client_certs,
  $ssl_ca_cert,
  $ssl_server_public,
  $ssl_server_private,

  $server = false,
  $client = false,
) {
  assert_private("This class should be called via the mcollective_profile base class")

  class
  { '::mcollective':
    middleware_hosts    => $middleware_hosts,
    middleware_ssl      => $middleware_ssl,
    middleware_port     => $middleware_port,
    middleware_ssl_port => $middleware_ssl_port,

    connector           => $connector,

    securiyprovider     => $securityprovider,

    psk                 => $psk,

    ssl_client_certs    => $ssl_client_certs,
    ssl_ca_cert         => $ssl_ca_cert,
    ssl_server_public   => $ssl_server_public,
    ssl_server_private  => $ssl_server_private,

    server              => $server,
    client              => $client,
  }

  contain ::mcollective
}
