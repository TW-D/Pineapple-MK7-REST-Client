module Helpers_Actions

    public def lookupOUI(mac)
        self.request(
            'GET',
            "helpers/lookupOUI/#{mac.gsub(':', '')[0..5]}",
            {},
            '{"available":true,"vendor":'
        )
    end

end