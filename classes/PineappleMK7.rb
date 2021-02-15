require('json')
require('net/ssh')
require('fileutils')
require('rest-client')
include(RestClient)

require_relative('../includes/system/Authentication.rb')
require_relative('../includes/system/LED.rb')

require_relative('../includes/Requesting.rb')
require_relative('../includes/Downloading.rb')

require_relative('../includes/modules/Recon.rb')
require_relative('../includes/modules/PineAP.rb')
require_relative('../includes/modules/Helpers.rb')
require_relative('../includes/modules/Download.rb')
require_relative('../includes/modules/Notifications.rb')

# custom mode module
require_relative('../includes/modes/Custom.rb')

module PineappleMK7

    class System

        attr_accessor(:host, :port, :mac)
        attr_writer(:password)

        include(Authentication)

        include(LED)

    end

    class Modules

        module Download
            extend(Downloading)
            extend(Download_Actions)
        end

        module Helpers
            extend(Requesting)
            extend(Helpers_Actions)
        end

        module Notifications
            extend(Requesting)
            extend(Notifications_Actions)
        end

        module PineAP
            extend(Requesting)
            extend(PineAP_Actions)
        end

        module Recon
            extend(Requesting)
            extend(Recon_Actions)
        end

    end

    class Modes

        # example of a mode module
        module Custom
            extend(Requesting)
            extend(Custom_Actions)
        end

    end

end