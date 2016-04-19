require_relative "../../VSOM"
require_relative "../../Utility/Methods"

module API

  def self.get_camera_recordings_info_uri
    "/camerarecording/getCameraRecordingsInfo"
  end

  def self.camera_recordings_start_ondemand_uri
    "/camerarecording/startOnDemandRecording"
  end

  def self.camera_recordings_stop_ondemand_uri
    "/camerarecording/stopOnDemandRecording"
  end

  def self.save_to_storage_uri
    "/camerarecording/copyCameraRecordings"
  end
  
  def self.get_server_recording_details_uri
    "/camerarecording/getServerRecordingDetails"
  end

  def self.get_camera_recording_catalog_entries_uri
    "/camerarecording/getRecordingCatalogEntries"
  end

  def self.get_first_last_recording_catalog_entry_uri
    "/camerarecording/getFirstLastForRecordingCatalogEntry"
  end

  def self.get_uri_for_thumbnails_uri
    "/camerarecording/getThumbnailsUri"
  end

  def self.get_thumbnails_uri
    "/camerarecording/getThumbnails"
  end

  module REST
  module CameraRecordings

    def self.get(token, camera_reference)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.get_camera_recordings_info_uri),
        headers: Utility.apply_token(token),
        body: { "cameraRef": camera_reference }
      })
      vsom.post!
      vsom.results
    end

    def self.save_to_storage(token, start_time, end_time, camera_reference)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.save_to_storage_uri),
        headers: Utility.apply_token(token),
        body: { 
          "request": {
            "cameraRef": camera_reference,
            "startTimeInMSec": start_time,
            "stopTimeInMSec": end_time
          }
        }
      })
      vsom.post!
      vsom.results
    end

    def self.start_on_demand(token, camera_reference)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.camera_recordings_start_ondemand_uri),
        headers: Utility.apply_token(token),
        body: { "cameraRef": camera_reference }
      })
      vsom.post!
      vsom.results
      #if vsom.results["status"]["errorType"] == "SUCCESS"
      #  return vsom.results["data"]
      #else
      #  puts "ERROR START ON DEMAND"
      #  return nil
    end

    def self.stop_on_demand(token, camera_reference)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.camera_recordings_stop_ondemand_uri),
        headers: Utility.apply_token(token),
        body: { "cameraRef": camera_reference }
      })
      vsom.post!
      vsom.results
    end

    def self.get_server_recording_details(token, camera_reference)
      payload = {
        "request": {
          "cameraRef": camera_reference,
          "skipGaps": false,
          "startTimeInMSec": 0,
          "endTimeInMSec": 0,
          "ignorePendingEntries": false
        }
      }
      Utility.create_vsom(token, API.get_server_recording_details_uri, payload)
    end

    def self.get_camera_recording_catalog_entries(token, filter)
      payload = {"filter": filter}
      res  = Utility.create_vsom(token, API.get_camera_recording_catalog_entries_uri, payload)
    end

    def self.get_first_last_recording_catalog_entry(token, camera_reference, recording_catalog_entry_id)
      payload = {
        "cameraRef": camera_reference,
        "recordingCatalogEntryId": recording_catalog_entry_id 
      }
      Utility.create_vsom(token, API.get_first_last_recording_catalog_entry_uri, payload)
    end

    def self.get_uri_for_thumbnails(token, camera_reference, recording_catalog_entry_id)
      payload = {
        "request": {
          "cameraRef": camera_reference,
          "recordingCatalogEntryUid": recording_catalog_entry_id,
          "numThumbnails":1,
          "forRecordings":false,
          "encoding": "JPG",
          "thumbnailResolution":"half",
          "thumbnailQuality":"medium",
          "tokenExpiryInSecs": 300
        }
      }
      Utility.create_vsom(token, API.get_uri_for_thumbnails_uri, payload)
    end

    def self.get_thumbnails(token, file_name, camera_reference, recording_catalog_entry_id, start_time, end_time)
      payload = {
        "request": {
          "cameraRef": camera_reference,
          "recordingCatalogEntryUid": recording_catalog_entry_id,
          "numThumbnails":1,
          "startTimeInMSec": start_time,
          "endTimeInMSec": end_time,
          "forRecordings":false,
          "encoding": "JPG",
          "thumbnailResolution":"half",
          "thumbnailQuality":"medium",
          "tokenExpiryInSecs": 300
        }
      }      
      Utility.create_vsom_to_file(token, file_name, API.get_thumbnails_uri, payload)
    end

    def self.get_uri_for_current_thumbnail(token, camera_reference, recording_catalog_entry_id)
      current_time = Time.now.to_i
      payload = {
        "request": {
          "cameraRef": camera_reference,
          "recordingCatalogEntryUid": recording_catalog_entry_id,
          "numThumbnails":1,
          "startTimeInMSec": current_time - 5000,
          "endTimeInMSec": current_time,
          "forRecordings":false,
          "encoding": "JPG",
          "thumbnailResolution":"half",
          "thumbnailQuality":"medium",
          "tokenExpiryInSecs": 300
        }
      }
      Utility.create_vsom(token, API.get_uri_for_thumbnails_uri, payload)
    end

  end
  end

end