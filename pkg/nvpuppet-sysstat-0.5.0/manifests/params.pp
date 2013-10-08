class sysstat::params {
  case $::osfamily {
    'redhat': {
      $package = 'sysstat'
      $service = 'sysstat'
      $config = '/etc/sysconfig/sysstat'
      $cron_config = '/etc/cron.d/sysstat'
    }
    default: {fail("OS family ${::osfamily} not supported!")}
  }
}
