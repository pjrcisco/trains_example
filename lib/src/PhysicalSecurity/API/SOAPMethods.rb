require "savon"
require 'json'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
module API

  def self.base_uri_soap
    "https://10.10.20.69/ismserver/soap"
  end

  def self.authentication_wsdl
    "/authentication?wsdl"
  end

  def self.camera_wsdl
    "/camera?wsdl"
  end

  def self.login_uri
    "/authentication/login"
  end
  
  def self.get_streaming_details_uri
    "/camera/getStreamingDetails"
  end

  def self.get_cameras_uri
    "/camera/getCameras"
  end

  def self.get_camera_features_uri
    '/camera/getCameraFeatures'
  end

  
  module SOAPMethods

    def self.login(name, password)
      wsdl     = API.base_uri_soap + API.authentication_wsdl
      endpoint = API.base_uri_soap + API.login_uri
      client   = Savon.client(ssl_verify_mode: :none, wsdl: wsdl, endpoint: endpoint)
      response = client.call(:login, message: {
        username: "admin",
        password: "P@ssw0rd1"
      })
      #puts JSON.pretty_generate(response.body)
      data = response.body
      unless data[:login_response].nil? || data[:login_response][:return].nil?
        return data[:login_response][:return][:uid]
      end
    end

    
    def self.get_cameras(token)
      wsdl     = API.base_uri_soap + API.camera_wsdl
      endpoint = API.base_uri_soap + API.get_cameras_uri
      client   = Savon.client(headers: {"x-ism-sid" => token}, ssl_verify_mode: :none, wsdl: wsdl, endpoint: endpoint)
      response = client.call(:get_cameras, message:{
        :filter => {
          :byObjectType => "device_vs_camera",
          :pageInfo => {
            :start => "0",
            :limit => "100"
          }
        }
      })
      response.body
    end

    def self.get_camera_id(token, index)
      cameras = get_cameras(token)
      #puts JSON.pretty_generate(cameras)
      id      = cameras[:get_cameras_response][:return][:items][index][:uid]
    end

    def self.get_camera_features(token, id)
      wsdl     = API.base_uri_soap + API.camera_wsdl
      endpoint = API.base_uri_soap + API.get_camera_features_uri
      client   = Savon.client(headers: {"x-ism-sid" => token}, ssl_verify_mode: :none, wsdl: wsdl, endpoint: endpoint)
      response = client.call(:get_camera_features, message:{
        "cameraRef": {
          "refUid": id,
          "refObjectType": "device_vs_camera_ip",
        }
      })
      #puts JSON.pretty_generate(response.body)
      response.body

    end
  
    def self.get_streaming_details(token, id)
      wsdl     = API.base_uri_soap + API.camera_wsdl
      endpoint = API.base_uri_soap + API.get_streaming_details_uri
      client   = Savon.client(headers: {"x-ism-sid" => token}, ssl_verify_mode: :none, wsdl: wsdl, endpoint: endpoint)
      response = client.call(:get_streaming_details, message:{
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
        })
      #puts JSON.pretty_generate(response.body)
      response.body
    end

    def self.get_streaming_details_url(token, id)
      results       = get_streaming_details(token, id)
      streaming_url = results[:get_streaming_details_response][:return][:camera_streaming_detail][:stream_infos][:streaming_full_url]
    end


  end




end