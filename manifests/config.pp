# == define jenkins::config
#
# Set $value in /etc/default/jenkins/$name
#
# === Requires
#
# augeas
#
# === Params
#
# [*value*]
#   value to be set
#
# === Examples
#
define jenkins::config($value) 
{
    #TODO: add an hash with valid values for file /etc/default/jenkins
    # and check for valid parameter

    # default dependencies and notifications
    Augeas {
        require => Class["jenkins::install"],
        notify  => Class["jenkins::service"],
    }

    augeas { "jenkins config $name":
        changes =>  [
            "set /files/etc/default/jenkins/$name $value",
            ],
    }
}
