# Class: bind
#
# This module manages bind
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class bind {
   case $operatingsystem {
      ubuntu: { include bind::ubuntu },
      debian: { include bind::ubuntu },
      RedHat: { inlcude bind::redhat },
      centos: { include bind::redhat },
      default: { include bind::base }
   }
}

class bind::base {
   package {'bind9': ensure => installed }   

   service {'bind9':
      enable    => true,
      ensure    => running,
   }
   
   file { '/etc/bind/named.conf':
      source => ['bind:///files/etc/bind/named.conf', 
                           'bind:///modules/bind/etc/bind/named.conf'],
      owner => 'root',
      group => 'root',
      mode => '644',
      notify => Service['bind'],
      require => Package['bind'],
   }
   
   file { '/etc/bind/named.conf.default-zones':
      source => ['bind:///files/etc/bind/named.conf.default-zones', 
                           'bind:///modules/bind/etc/bind/named.conf.default-zones'],
      owner => 'root',
      group => 'root',
      mode => '644',
      notify => Service['bind'],
      require => Package['bind'],
   }
   
   file { '/etc/bind/named.conf.options':
      source => ['bind:///files/etc/bind/named.conf.options', 
                           'bind:///modules/bind/etc/bind/named.conf.options'],
      owner => 'root',
      group => 'root',
      mode => '644',
      notify => Service['bind'],
      require => Package['bind'],
   }
   
}

class bind::ubuntu inherits bind::base {
   file { '/etc/default/bind':
      source  => ['bind:///files/etc/default/bind',
                  'bind:///modules/bind/etc/default/bind.conf'],
      owner   => 'root',
      group   => 'root',
      mode    => '640',
      notify  => Service['bind'],
      require => Package['bind'],
   }
}
