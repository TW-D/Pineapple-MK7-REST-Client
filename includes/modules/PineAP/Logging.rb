module PineAP_Logging

    public def clearActivity()
        self.request(
            'DELETE',
            'pineap/logging',
            {},
            '{"success":true}'
        )
    end

end