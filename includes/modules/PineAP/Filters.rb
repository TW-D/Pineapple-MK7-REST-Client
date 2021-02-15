module PineAP_Filters

    public def filterClient(mode)
        self.request(
            'PUT',
            'pineap/filters/client/mode',
            {
                'mode' => mode
            },
            '{"success":true}'
        )
    end

    public def filterSSID(mode)
        self.request(
            'PUT',
            'pineap/filters/ssid/mode',
            {
                'mode' => mode
            },
            '{"success":true}'
        )
    end

end