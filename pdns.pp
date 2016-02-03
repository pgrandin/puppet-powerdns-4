node default {

apt::source { 'powerdns':
  comment  => '4.x powerdns repository',
  location => 'http://repo.powerdns.com/ubuntu trusty-auth-master',
  release  => 'main',
  repos    => 'main',
  pin      => '600',
  key      => {
    'id'     => 'D47975F8DAE32700A563E64FFF389421CBC8B383',
    'server' => 'subkeys.pgp.net',
  },
  include  => {
    'src' => false,
    'deb' => true,
  },
}


class { '::mysql::server':
  root_password           => 'strongpassword',
  remove_default_accounts => true,
  override_options        => \$override_options
}

mysql::db { 'pdns':
  user     => 'pdns',
  password => 'powerdns',
  host     => 'localhost',
}

# Install PowerDNS:
class { '::powerdns': }

class { '::powerdns::backend::gmysql':
  host     => '127.0.0.1',
  user     => 'pdns',
  password => 'powerdns',
  dbname   => 'pdns',
  port     => '3306',
}


}
