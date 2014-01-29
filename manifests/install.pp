# = Jenkins install calss
#
# == Requires
#
# camptocamp/puppet-apt
#
#TODO: manage directory permissions for jobs
#TODO: place workspace in the right path on aws
class jenkins::install {

  include apt

  apt::key { 'D50582E6':
    source  => 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key',
  }

  apt::sources_list { 'jenkins':
    content => 'deb http://pkg.jenkins-ci.org/debian-stable binary/',
    require => Apt::Key['D50582E6'],
  }

  include subversion
  include git

  Package {
    ensure => latest,
  }

  package { 'jenkins':
    require => Apt::Sources_list['jenkins'],
  }

  package { 'openjdk-6-jdk': }

  package { 'maven2': }

  package { 'ant': }

  apt::ppa { 'natecarlson/maven3': 
    key => '3DD9F856',
    mirror => true
  }

  package { 'maven3':
    require => Apt::Ppa['natecarlson/maven3'],
  }

}
