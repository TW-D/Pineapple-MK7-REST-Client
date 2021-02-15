module PineAP_Settings

    public def enable()
        self.request(
            'PUT',
            'pineap/settings',
            {
                'mode' => "advanced",
                'settings' => {
                    'enablePineAP' => true,
                    'autostartPineAP' => false,
                    'armedPineAP' => false,
                    'ap_channel' => "11",
                    'karma' => false,
                    'logging' => false,
                    'connect_notifications' => false,
                    'disconnect_notifications' => false,
                    'capture_ssids' => false,
                    'beacon_responses' => false,
                    'broadcast_ssid_pool' => false,
                    'pineap_mac' => PineappleMK7::System::MAC,
                    'target_mac' => "FF:FF:FF:FF:FF:FF",
                    'beacon_response_interval' => "NORMAL",
                    'beacon_interval' => "NORMAL"
                }
            },
            '{"success":true}'
        )
    end

    public def setRogue()
        self.request(
            'PUT',
            'pineap/settings',
            {
                'mode' => "advanced",
                'settings' => {
                    'enablePineAP' => true,
                    'autostartPineAP' => false,
                    'armedPineAP' => false,
                    'ap_channel' => "11",
                    'karma' => true,
                    'logging' => false,
                    'connect_notifications' => false,
                    'disconnect_notifications' => false,
                    'capture_ssids' => false,
                    'beacon_responses' => true,
                    'broadcast_ssid_pool' => true,
                    'pineap_mac' => PineappleMK7::System::MAC,
                    'target_mac' => "FF:FF:FF:FF:FF:FF",
                    'beacon_response_interval' => "AGGRESSIVE",
                    'beacon_interval' => "AGGRESSIVE"
                }
            },
            '{"success":true}'
        )
    end

    public def disable()
        self.request(
            'PUT',
            'pineap/settings',
            {
                'mode' => "advanced",
                'settings' => {
                    'enablePineAP' => false,
                    'autostartPineAP' => false,
                    'armedPineAP' => false,
                    'ap_channel' => "11",
                    'karma' => false,
                    'logging' => false,
                    'connect_notifications' => false,
                    'disconnect_notifications' => false,
                    'capture_ssids' => false,
                    'beacon_responses' => false,
                    'broadcast_ssid_pool' => false,
                    'pineap_mac' => PineappleMK7::System::MAC,
                    'target_mac' => "FF:FF:FF:FF:FF:FF",
                    'beacon_response_interval' => "NORMAL",
                    'beacon_interval' => "NORMAL"
                }
            },
            '{"success":true}'
        )
    end
    
end