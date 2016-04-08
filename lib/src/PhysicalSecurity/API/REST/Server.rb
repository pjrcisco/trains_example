require_relative '../../Utility/Methods'

module API
  def self.discover_cameras_uri
    "/server/discoverCameras"
  end

  def self.get_servers_uri
    "/server/getServers"
  end

  module REST
  module Server

    def self.discover_cameras(token, ums_reference)
      payload = {
        "umsRef": ums_reference,
        "vendor":["Cisco Systems, Inc.", "Bosch Security Systems, Inc.",
                  "Axis Communications", "Arecont Inc."]
      }
      Utility.create_vsom(token, API.discover_cameras_uri, payload)
    end
    
    def self.get_servers(token)
      payload = { "filter": { "byObjectType":"device_vs_server" } }
      Utility.create_vsom(token, API.get_servers_uri, payload)
    end



  end
  end

end
