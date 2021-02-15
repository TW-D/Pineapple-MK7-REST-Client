#
# Title:
#
# Description:
#
#
# Author:
# Version:      1.0
# Category:
# Target:
#
# REQUIREMENTS
# ============
# -
# -
#

require_relative('../classes/PineappleMK7.rb')
include(PineappleMK7)

######## INITIALIZATION ########

system = System.new()
system.host = "172.16.42.1"
system.port = "1471"
system.mac = "00:13:37:DD:EE:FF"
system.password = "P@55w0rD"

puts("[>] Authentication")
logged = system.login()

if (logged)

    ######## SETUP ########

    # LED SETUP
    system.setup()

    ######## ATTACK ########

    # LED ATTACK
    system.attack()

    # LED SPECIAL
    system.special()

    ######## CLEANUP ########

    # LED CLEANUP
    system.cleanup()

    ######## FINISH ########

    # LED FINISH
    system.finish()

else

    # LED FAIL
    system.failed()

end

# LED OFF
system.off()