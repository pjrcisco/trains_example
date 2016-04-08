require_relative '../API/REST/Camera'
require_relative '../API/REST/CameraRecordings'
require_relative '../Utility/Methods'

require 'json'

module PhysicalSecurity
module Helper

  module Methods
    def self.get_camera_by_name(token, name)
      filter = { "byExactName": name }
      camera = API::REST::Camera.get_cameras_filtered(token, filter)
      if camera.nil? || camera["data"].nil? || camera["data"]["items"].nil?
        return nil
      else
        camera["data"]["items"][0]
      end
    end
    
    def self.get_recordings_by_camera(token, camera)
      filter  = {"byCameraAlternateId": camera["alternateId"] }
      entries = API::REST::CameraRecordings.get_camera_recording_catalog_entries(token, filter) 
      entries["data"]["items"]
    end

    def self.get_current_snapshot_url(token, entries)
      entry   = entries[0]
      s_token = API::REST::Camera.get_security_token(token, entry["cameraRef"])
      result  = API::REST::CameraRecordings.get_uri_for_current_thumbnail(token, entry["cameraRef"], entry["uid"])
      Utility.swap_ip(result["data"]["getUri"], "171.68.22.181")#Utility.ip)
      
    end

    def self.json(value)
      puts JSON.pretty_generate(value)
    end

  end

end
end