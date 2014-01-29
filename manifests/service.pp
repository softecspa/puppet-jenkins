# = Jenkins service subclass
#
class jenkins::service {
    service {"jenkins":
        enable  => true,
        ensure  => "running",
        hasrestart=> true,
        require => Class["jenkins::install"],
    }
}
