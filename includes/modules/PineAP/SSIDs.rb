module PineAP_SSIDs

    public def addSSID(ssid)
        self.request(
            'PUT',
            'pineap/ssids/ssid',
            {
                'ssid' => ssid
            },
            '{"success":true}'
        )
    end

    public def clearPool()
        self.request(
            'DELETE',
            'pineap/ssids',
            {},
            '{"success":true}'
        )
    end

end