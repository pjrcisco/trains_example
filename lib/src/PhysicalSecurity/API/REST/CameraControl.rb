require_relative "../../VSOM"
require_relative "../../Utility/Methods"
require 'net/http'


module API

  def self.base_camera_control_uri
    "https://10.10.20.69/ums/ManagedDevices/CameraControls"
  end

  module REST
  module CameraControl
  
    def self.do_ptz(token, device_id, params={})
      results = _create_vsom(token, device_id, params, "doPTZ")
    end

    def self.set_ptz_preset(token, device_id, params={})
      results = _create_vsom(token, device_id, params, "setPreset")
    end

    def self.go_to_ptz_preset(token, device_id, params={})
      results = _create_vsom(token, device_id, params, "gotoPreset")
    end
    
    def self.set_white_balance(token, device_id, params={})
      results = _create_vsom(token, device_id, params, "setWhiteBalance")
    end
    
    def self.set_iris(token, device_id, params={})
      results = _create_vsom(token, device_id, params, "setIris")
    end

    def self.set_focus(token, device_id, params={})
      results = _create_vsom(token, device_id, params, "setFocus")
    end

    def self.set_sharpness(token, device_id, params={})
      results = _create_vsom(token, device_id, params, "setSharpness")
    end

    def self.set_contrast(token, device_id, params={})
      results = _create_vsom(token, device_id, params, "setContrast")
    end

    def self.set_saturation(token, device_id, params={})
      results = _create_vsom(token, device_id, params, "setSaturation")
    end

    def self.set_hue(token, device_id, params={})
      results = _create_vsom(token, device_id, params, "setHue")
    end

    def self.set_digital_zoom(token, device_id, params={})
      results = _create_vsom(token, device_id, params, "setDigitalZoom")
    end

    def self.set_auto_iris(token, device_id, params={})
      results = _create_vsom(token, device_id, params, "setAutoIris")
    end

    def self.set_auto_focus(token, device_id, params={})
      results = _create_vsom(token, device_id, params, "setAutoFocus")
    end

    def self.set_night_options(token, device_id, params={})
      results = _create_vsom(token, device_id, params, "setNightOptions")
    end

    def self.set_blacklight_compensation(token, device_id, params={})
      results = _create_vsom(token, device_id, params, "setBlacklightCompensation")
    end

    def self.set_analog_output(token, device_id, params={})
      results = _create_vsom(token, device_id, params, "setAnalogOutput")
    end

    def self.set_camera_orientation(token, device_id, params={})
      results = _create_vsom(token, device_id, params, "setCameraOrientation")
    end

    def self.set_on_screen_display(token, device_id, params={})
      results = _create_vsom(token, device_id, params, "setOnScreenDisplay")
    end

    # private factory method
    def self._create_vsom(token, device_id, params={}, action)
      base_uri = API.base_camera_control_uri + "/#{device_id}/#{action}"
      puts base_uri
      uri = Utility.encode_url_params(base_uri, params)    
      vsom = VSOM.new({
        uri: URI(uri),
        headers: Utility.apply_token(token)
      })

      puts URI(uri)
      puts "======="
      vsom.get!
      vsom.results
    end



  end
  end
end
