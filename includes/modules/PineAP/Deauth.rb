module PineAP_Deauth

    public def deauthAP(bssid, channel, clients)
        self.request(
            'POST',
            'pineap/deauth/ap',
            {
                'bssid' => bssid,
                'multiplier' => 5,
                'channel' => channel,
                'clients' => clients
            },
            '{"success":true}'
        )
    end

    public def deauthClient(bssid, channel, mac)
        self.request(
            'POST',
            'pineap/deauth/client',
            {
                'bssid' => bssid,
                'multiplier' => 5,
                'channel' => channel,
                'mac' => mac
                
            },
            '{"success":true}'
        )
    end

end