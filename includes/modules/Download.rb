module Download_Actions

    public def handshake(bssid, type, destination)
        self.download(
            'POST',
            'download',
            {
                'filename' => "/tmp/handshakes/#{bssid.gsub(':', '-')}_#{type}.pcap"
            },
            destination
        )
    end

end