require_relative '../API/REST/Camera'
require_relative '../API/REST/CameraRecordings'
require_relative '../Utility/Methods'

require 'json'

module PhysicalSecurity
module Helper

  module Methods
    def self.get_camera_by_name(token, name)
      filter = {"byExactName": name }
      camera = API::REST::Camera.get_cameras_filtered(token, filter)
      if camera.nil? || camera["data"].nil? || camera["data"]["items"].nil? || camera["data"]["items"][0].nil?
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

    def self.get_recordings_by_camera_name(token, name)
      camera_ref = _get_camera_ref_by_name(token, name)
      filter  = {"byCameraRef": camera_ref }
      entries = API::REST::CameraRecordings.get_camera_recording_catalog_entries(token, filter)
      entries 
      #entries["data"]["items"]
    end

    def self.get_current_snapshot_url(token, entries)
      entry   = entries[0]
      s_token = API::REST::Camera.get_security_token(token, entry["cameraRef"])
      result  = API::REST::CameraRecordings.get_uri_for_current_thumbnail(token, entry["cameraRef"], entry["uid"])
      Utility.swap_ip(result["data"]["getUri"], "171.68.22.181")#Utility.ip)      
    end

    def self.get_camera_events_urls_by_name(token, name)
      reference  = get_camera_by_name(token, name)
      unless reference.nil?
        device_ref = {
          "refUid": reference["alternateId"],
          "refName": reference["name"],
          "refObjectType": reference["objectType"],
          "refVsomUid": reference["vsomUid"]
        }
        result    = API::REST::Camera.get_camera_event_urls(token, device_ref)
        json result
        result
      end
    end

    def self.get_camera_cdp_neighbors_by_name(token, name)
      reference  = get_camera_by_name(token, name)
      unless reference.nil?
        device_ref = {
          "refUid": reference["alternateId"],
          "refName": reference["name"],
          "refObjectType": reference["objectType"],
          "refVsomUid": reference["vsomUid"]
        }
        result    = API::REST::Camera.get_cdp_neighbors(token, device_ref)
        json result
        result
      end
    end


    def self.start_recording(token, name)
      camera_ref = _get_camera_ref_by_name(token, name)
      result     = API::REST::CameraRecordings.start_on_demand(token, camera_ref)
    end

    def self.stop_recording(token, name)
      camera_ref = _get_camera_ref_by_name(token, name)
      result     = API::REST::CameraRecordings.stop_on_demand(token, camera_ref)
    end
  
    def self.get_first_last_recording_by_camera_name(token, name)
      recordings = get_recordings_by_camera_name(token, name)
      puts name
      
      #puts recordings
      #json recordings
      #rec_id     = recordings["data"]["items"][0]["recordingAlternateId"]
      rec_id     = recordings["data"]["items"][0]["uid"]
      camera_ref = _get_camera_ref_by_name(token, name)
      API::REST::CameraRecordings.get_first_last_recording_catalog_entry(token, camera_ref, rec_id)
    end

    def self.get_uri_for_current_thumbnail_by_camera_name(token, name)
      recording  =  get_first_last_recording_by_camera_name(token, name)
      camera_ref = _get_camera_ref_by_name(token, name)
      id         = recording["data"]["uid"]
      API::REST::CameraRecordings.get_uri_for_current_thumbnail(token, camera_ref, id)
    end

    def self.get_snapshot(token, camera_name, file_name, start_time)
      c_ref = _get_camera_ref_by_name(token, camera_name)
      unless c_ref.nil?
        rec = get_first_last_recording_by_camera_name(token, camera_name)
        id  = rec["data"]["uid"]
        API::REST::CameraRecordings.get_thumbnails(token, file_name, c_ref, id, start_time, start_time+1000)
      end
    end

    def self.get_streaming_url(token, id)
      API::REST::Camera.get_streaming_details_url(token, id)
    end


    def self._get_camera_ref_by_name(token, name)
      reference  = get_camera_by_name(token, name)
      unless reference.nil?
        device_ref = {
          "refUid": reference["alternateId"],
          "refName": reference["name"],
          "refObjectType": reference["objectType"],
          "refVsomUid": reference["vsomUid"]
        }
      end
    end



    def self.json(value)
      puts JSON.pretty_generate(value)
    end

  end

end
end