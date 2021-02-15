module Recon_Actions

    PROTOCOLS_FLAGS = {
        'WPA' => 0x01,
        'WPA2' => 0x02,
        'WEP' => 0x04
    }

    AKMS_FLAGS = {
        'WPA_AKM_PSK' => 0x800,
        'WPA_AKM_ENTERPRISE' => 0x1000,
        'WPA_AKM_ENTERPRISE_FT' => 0x2000,
        'WPA2_AKM_PSK' => 0x4000,
        'WPA2_AKM_ENTERPRISE' => 0x8000,
        'WPA2_AKM_ENTERPRISE_FT' => 0x10000
    }

    PAIRWISES_FLAGS = {
        'WPA_PAIRWISE_WEP40' => 0x08,
        'WPA_PAIRWISE_WEP104' => 0x10,
        'WPA_PAIRWISE_TKIP' => 0x20,
        'WPA_PAIRWISE_CCMP' => 0x40,
        'WPA2_PAIRWISE_WEP40' => 0x80,
        'WPA2_PAIRWISE_WEP104' => 0x100,
        'WPA2_PAIRWISE_TKIP' => 0x200,
        'WPA2_PAIRWISE_CCMP' => 0x400
    }

    public def startScan(time)
        self.request(
            'POST',
            'recon/start',
            {
                'live' => false,
                'scan_time' => time,
                'band' => "0"
            },
            '{"scanRunning":true,"scanID":'
        )
        sleep(time + 15)
        return @body
    end

    public def stopScan()
        self.request(
            'POST',
            'recon/stop',
            {},
            '{"success":true}'
        )
    end

    public def getResults(scanID)
        self.request(
            'GET',
            'recon/scans/' + scanID.to_s(),
            {},
            '{"APResults":'
        )
    end

    public def convertEncryption(bitmask)

        protocols = []
        PROTOCOLS_FLAGS.each() do |key, value|
            if ( (bitmask & PROTOCOLS_FLAGS[key]) != 0)
                protocols << key
            end
        end
    
        akms = []
        AKMS_FLAGS.each() do |key, value|
            if ( (bitmask & AKMS_FLAGS[key]) != 0)
                akms << key
            end
        end
    
        pairwises = []
        PAIRWISES_FLAGS.each() do |key, value|
            if ( (bitmask & PAIRWISES_FLAGS[key]) != 0)
                pairwises << key
            end
        end
    
        encryption = ""
        if (!protocols.empty?())
            encryption += protocols.join('/') + " "
            encryption += akms.map() { |akm| akm.gsub(Regexp.new('(?:'+protocols.join('|')+')_AKM_'), "") }.uniq().join() + " "
            encryption += "(" + pairwises.map() { |pairwise| pairwise.gsub(Regexp.new('(?:'+protocols.join('|')+')_PAIRWISE_'), "") }.uniq().join(' ') + ")"
        else
            encryption = "Open"
        end
    
        return encryption

    end
    
    public def deleteScan(scanID)
        self.request(
            'DELETE',
            'recon/scans/' + scanID.to_s(),
            {},
            '{"success":true}'
        )
    end

end
