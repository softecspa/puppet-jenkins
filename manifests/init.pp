# = Jenkins module
#
# == Requires
#
# camptocamp/puppet-apt
#
# == Source
# https://wiki.jenkins-ci.org/display/JENKINS/Puppet
class jenkins(
    $http_port=8080, 
    $home="/var/lib/jenkins",
    $user="jenkins"
) {

    include jenkins::install, jenkins::service

    jenkins::config { "HTTP_PORT":      value  => $http_port }
    jenkins::config { "JENKINS_HOME":   value  => $home } 
    jenkins::config { "JENKINS_USER":   value  => $user }

    file { "/usr/local/bin/puppet-test":
      ensure  => present,
      group   => "admin",
      mode    =>  775,
      source  => "puppet:///modules/jenkins/bin/puppet-test",
    }

}
