require_relative "../../VSOM"
require_relative "../../Utility/Methods"

module API
  def self.get_cameras_uri
    "/camera/getCameras"
  end

  def self.get_camera_features_uri
    '/camera/getCameraFeatures'
  end

  def self.get_streaming_details_uri
    "/camera/getStreamingDetails"
  end
  
  def self.get_camera_and_template_details_uri
    "/camera/getCameraAndTemplateDetails"
  end

  def self.get_security_token_uri
    "/camera/getSecurityToken"
  end

  def self.get_recordings_by_camera_uri
    "/camera/v1_0/getRecordingsByCamera"
  end

  def self.get_pending_cameras_uri
    "/camera/getPendingCameras"
  end 

  def self.get_camera_event_urls_uri
    "/camera/getCameraEventURLs"
  end

  def self.get_cdp_neighbors_uri
    "/camera/getCdpNeighbors"
  end

  module REST
  module Camera

    def self.get_cameras(token)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.get_cameras_uri),
        headers: Utility.apply_token(token),
        body: {
          :filter => {
            :byObjectType => "device_vs_camera",
            :pageInfo => {
              :start => "0",
              :limit => "100"
            }
          }
        }
      })
      vsom.post!
      vsom.results
    end

    def self.get_cameras_filtered(token, filter)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.get_cameras_uri),
        headers: Utility.apply_token(token),
        body: {
          filter: filter
        }
      })
      vsom.post!
      vsom.results
    end

    def self.get_camera_id(token, index)
      results = get_cameras(token)
      id      = results['data']['items'][index]['uid']
    end

    def self.get_camera_features(token, id)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.get_camera_features_uri),
        headers: Utility.apply_token(token),
        body: {
          "cameraRef": {
            "refUid": id,
            "refObjectType": "device_vs_camera_ip",
          }
        }
      })
      vsom.post!
      vsom.results
    end

    def self.get_streaming_details(token, id)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.get_streaming_details_uri),
        headers: Utility.apply_token(token),
        body: {
          "cameraStreamingDetailsRequest":{
            "cameraRefs": [{
              "refUid": id,
              "refObjectType": "device_vs_camera_ip"
            }],
            "tokenExpiryInSecs": 1000,
            "requestedStreams": "videostream1",
            "recordingStartTimeInSecs": 0,
            "tokenType": "h2",
            "loadStreamProfile": TRUE
          }
        }
      })
      vsom.post!
      #puts JSON.pretty_generate(vsom.results)
      vsom.results
    end

    
    def self.get_streaming_details_url(token, id)
      results = get_streaming_details(token, id)
      streaming_url = results['data']['cameraStreamingDetails'][0]['streamInfos'][0]['streamingFullURL']
    end


    def self.get_camera_and_template_details(token, device_reference)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.get_camera_and_template_details_uri),
        headers: Utility.apply_token(token),
        body: { "deviceRef": device_reference }
      })
      vsom.post!
      vsom.results
    end
  
    def self.get_security_token(token, camera_reference)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.get_security_token_uri),
        headers: Utility.apply_token(token),
        body: {
          "cameraRef": camera_reference,
          "tokenExpiryInSecs": "300"
        }
      })
      vsom.post!
      vsom.results
    end

    def self.get_recordings_by_camera(token, device_reference)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.get_recordings_by_camera_uri),
        headers: Utility.apply_token(token),
        body: {
          "deviceRef": device_reference
        }
      })
      vsom.post!
      vsom.results
    end

    def self.get_pending_cameras(token)
      payload = { "filter": {"byObjectType": "device_vs_camera"} }
      Utility.create_vsom(token, API.get_pending_cameras_uri, payload)
    end


    def self.get_streaming_details_test(token, payload)
      Utility.create_vsom(token, API.get_streaming_details_uri, payload)
    end

    def self.get_camera_event_urls(token, device_reference)
      payload = {"deviceRef": device_reference}
      Utility.create_vsom(token, API.get_camera_event_urls_uri, payload)
    end

    def self.get_cdp_neighbors(token, camera_reference)
      payload = {"cameraRef": camera_reference}
      Utility.create_vsom(token, API.get_cdp_neighbors_uri, payload)
    end


  end
  end

end