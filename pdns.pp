node default {

apt::source { 'powerdns':
  comment  => '4.x powerdns repository',
  location => 'http://repo.powerdns.com/ubuntu',
  release  => 'trusty-auth-master',
  repos    => 'main',
  pin      => '600',
  key      => {
    'id'     => 'D47975F8DAE32700A563E64FFF389421CBC8B383',
    'source' => 'http://repo.powerdns.com/CBC8B383-pub.asc',
  },
  include  => {
    'src' => false,
    'deb' => true,
  },
}

class { '::mysql::server':
  root_password           => 'strongpassword',
  remove_default_accounts => true,
  package_name            => 'mysql-server-5.6',
  override_options        => $override_options
}

class { '::mysql::client':
  package_name            => 'mysql-client-5.6',
}

mysql::db { 'pdns':
  user     => 'pdns',
  password => 'powerdns',
  host     => 'localhost',
}

# Install PowerDNS:
class { '::powerdns': 
  require  => [Apt::Source['powerdns'], Mysql::Db['pdns']],
}
->
class { '::powerdns::backend::gmysql':
  host     => '127.0.0.1',
  user     => 'pdns',
  password => 'powerdns',
  dbname   => 'pdns',
  port     => '3306',
}


}
