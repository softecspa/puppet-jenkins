# = Define Jenkins::Plugin
#
# Donwnload plugins for Jenkins from the official plugins repository
#
# Pay attention: you can specify plugin version, but version are not
# updated automatically
#
# == Requires
#
# wget
#
define jenkins::plugin(
    $ensure=present,
    $version="latest"
    )
{
    $baseurl='http://updates.jenkins-ci.org'
    $local_file="${jenkins::home}/plugins/${name}.hpi"
  
    if $ensure == "present"
    {
        if $version=="latest"
        {
            $remote_url="$baseurl/latest/${name}.hpi"
        }
        else
        {
            $remote_url="$baseurl/download/plugins/${name}/$version/${name}.hpi"
        }

        exec { "download_${name}":
            command => "/usr/bin/wget -q -O ${local_file} ${remote_url}",
            logoutput => on_failure,
            creates => "${local_file}",
            notify  =>  Class["jenkins::service"],
        }

        file { $local_file:
            owner       => "${jenkins::user}",
            group       => "nogroup",
            require     => Exec["download_${name}"],
        }
    }
    else
    {
        file { $local_file:
            ensure  => absent,
        }

        file { "${jenkins::home}/plugins/${name}":
            ensure  => absent,
        }
    }
}
