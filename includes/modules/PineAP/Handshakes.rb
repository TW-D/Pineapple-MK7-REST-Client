module PineAP_Handshakes

    public def startHandshakesCapture(ap)
        self.request(
            'POST',
            'pineap/handshakes/start',
            ap.to_h(),
            '{"success":true}'
        )
    end

    public def getHandshakes()
        self.request(
            'GET',
            'pineap/handshakes',
            {},
            '{"handshakes":'
        )
    end

    public def stopHandshakesCapture()
        self.request(
            'POST',
            'pineap/handshakes/stop',
            {},
            '{"success":true}'
        )
    end

end