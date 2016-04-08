require_relative "../../VSOM"
require_relative "../../Utility/Methods"


module API
  
  def self.create_full_motion_windows_uri
    "/camerabulkops/createFullMotionWindows"
  end

  def self.delete_cameras_uri
    "/camerabulkops/deleteCameras"
  end

  def self.associate_cameras_to_device_template_uri
    "/camerabulkops/associateCamerasToDeviceTemplate"
  end


  module REST
  module CameraBulkOps
  
    def self.create_full_motion_windows(token, device_references)
  
      vsom = VSOM.new({
        uri: Utility.set_uri(API.create_full_motion_windows_uri),
        headers: Utility.apply_token(token),
        body: { "deviceRefs": device_references }
      })
      vsom.post!
      vsom.results

    end

    def self.delete_cameras(token, device_references)
      _create_vsom(token, API.delete_cameras_uri, { "deviceRefs": device_references })
    end

    def self.associate_cameras_to_device_template(token, device_references, template_reference)
      payload = {
        "deviceRefs": device_references,
        "templateRef": template_reference
      }
      _create_vsom(token, API.associate_cameras_to_device_template_uri, payload)
    end





    # should be a private helper method for the creation of
    # vsom objects
    # that sends a post and return the response body
    def self._create_vsom(token, uri, payload)
      vsom = VSOM.new({
        uri: Utility.set_uri(uri),
        headers: Utility.apply_token(token),
        body: payload
      })
      vsom.post!
      vsom.results
    end


  end
  end
end