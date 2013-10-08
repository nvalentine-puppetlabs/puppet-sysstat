class sysstat(
  $interval = hiera('sysstat::interval', '10')
) inherits sysstat::params {

  validate_re($interval, '^[0-9]+$')
  
  File { 
    owner => 'root', 
    group => 'root', 
    mode => '0644', 
    require => Package[$package],
  }

  package { $package: ensure => installed, }

  file { $config: ensure => file, source => "puppet:///${module_name}/sysconfig-sysstat", }

  file { $cron_config: 
    ensure => file, 
    content => template("${module_name}/cron.erb"),
  }

  service { $service: 
    ensure => running, 
    enable => true,
    subscribe => File[$config, $cron_config],
  }
}
