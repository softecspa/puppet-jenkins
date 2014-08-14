# = Jenkins install calss
#
# == Requires
#
# camptocamp/puppet-apt
#
#TODO: manage directory permissions for jobs
#TODO: place workspace in the right path on aws
class jenkins::install {

  include apt_puppetlabs

  apt_puppetlabs::source {'jenkins':
    location    => 'http://pkg.jenkins-ci.org/debian-stable',
    release     => '',
    repos       => 'binary/',
    include_src => false,
    key         => 'D50582E6',
    key_source  => 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key'
  }


  include subversion
  include git

  Package {
    ensure => latest,
  }

  package { 'jenkins':
    require => Apt_puppetlabs::Source['jenkins'],
  }

  package { 'openjdk-6-jdk': }

  package { 'maven2': }

  package { 'ant': }

  softec_apt::ppa{'natecarlson/maven3':
    key     => '3DD9F856',
    mirror  => true
  }

  package { 'maven3':
    require => Softec_apt::Ppa['natecarlson/maven3'],
  }

}
