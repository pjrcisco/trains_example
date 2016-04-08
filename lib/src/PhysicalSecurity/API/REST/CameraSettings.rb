  require_relative "../../VSOM"
require_relative "../../Utility/Methods"

module API
  def self.get_camera_settings_uri
    "/camerasettings/getCameraSettings"
  end

  def self.create_camera_settings_uri
    "/camerasettings/createCameraSettings"
  end

  def self.delete_camera_settings_uri
    "/camerasettings/deleteCameraSettings"
  end

  def self.get_camera_settings_details_uri
    "/camerasettings/getCameraSettingsDetails"
  end

  def self.is_camera_settings_exist_uri
    "/camerasettings/isCameraSettingsExists"
  end
  
  def self.update_camera_settings_uri
    "/camerasettings/updateCameraSettings"
  end

  module REST
  module CameraSettings
    def self.get_camera_settings(token, reference_name)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.get_camera_settings_uri),
        headers: Utility.apply_token(token),
        body: {
          "filter":{
            "refName"=> reference_name
          }
        }
      })
      vsom.post!
      if vsom.results["status"]["errorType"] == "SUCCESS"
        vsom.results["data"]["items"]
      else
        nil
      end

    end


    def self.create_camera_settings(token, settings)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.create_camera_settings_uri),
        headers: Utility.apply_token(token),
        body: {
          "cameraSettings": settings
        }
      })
      vsom.post!
      if vsom.results["status"]["errorType"] == "SUCCESS"
        vsom.results["data"]
      else
        nil
      end
    end

  
    def self.delete_camera_settings(token, settings_reference)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.delete_camera_settings_uri),
        headers: Utility.apply_token(token),
        body: {
          "cameraSettingsRef": settings_reference
        }
      })
      vsom.post!
      vsom.results
    end


    def self.get_camera_settings_details(token, settings_reference)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.get_camera_settings_details_uri),
        headers: Utility.apply_token(token),
        body: {
          "cameraSettingsRef": settings_reference
        }
      })
      vsom.post!
      if vsom.results["status"]["errorType"] == "SUCCESS"
        vsom.results["data"]
      else
        nil
      end
    end
    
    def self.camera_settings_exist?(token, name)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.is_camera_settings_exist_uri),
        headers: Utility.apply_token(token),
        body: {
          "cameraSettingsName": name
        }
      })
      vsom.post!
      if vsom.results["status"]["errorType"] == "SUCCESS"
        vsom.results["data"]
      else
        false
      end
    end

    def self.update_camera_settings(token, settings)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.update_camera_settings_uri),
        headers: Utility.apply_token(token),
        body: {
          "cameraSettings": settings
        }
      })
      vsom.post!
      if vsom.results["status"]["errorType"] == "SUCCESS"
        vsom.results["data"]
      else
        nil
      end
    end

  end
  end

end
