# /etc/puppet/modules/kmod/manifests/init.pp

# Class: kmod
# 
# This class manages /etc/modules file
# 
class kmod {

    define add_module ($ensure) {

        case $ensure {
            "enabled","present","load": {
                augeas {
                    "kmod_$title":
                        context => "/files/etc/modules",
                        incl    => "/files/etc/modules",
                        lens    => "linevars.aug",
                        changes => "set entry[last()+1] $name",
                        onlyif  => "match entry[.='$name'] size == 0",
                        notify  => Exec["modprobe_$title"];
                }

                exec {
                    "modprobe_$title":
                        command     => "/sbin/modprobe ${name} || :",
                        refreshonly => true;
                }
            }
            "absent": {
                augeas {
                    "kmod_$title":
                        context => "/files/etc/modules",
                        incl    => "/files/etc/modules",
                        lens    => "linevars.aug",
                        changes => "rm entry[.='$name']";
                }
            }
            default: {
                fail("kmod class ensure:$ensure is wrong")
            }
        }


    }

}

