module PineAP_Clients

    public def getClients()
        self.request(
            'GET',
            'pineap/clients',
            {},
            ''
        )
    end

end