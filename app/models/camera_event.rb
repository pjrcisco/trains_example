require 'src/Utility/Response'
require 'src/Tropo/Execute'
require 'src/Spark/Execute'
require 'src/PhysicalSecurity/Execute'
class CameraEvent < ActiveRecord::Base

  def self.handle(camera_params)
    if valid_token?(camera_params[:token])
      #Tropo.execute(camera_params)
      response = PhysicalSecurity.get_current_snapshot_url(camera_params[:name])
      if response.status == 200
        res = Spark.send_image("priel@cisco.com", "Motion has been detected on #{camera_params[:name]}", response.url)
        Utility::Response.new({"status": res})
      else
        return response
      end
    else
      Utility::Response.new({ "status": "invalid token" })
    end
  end


def self.record(camera_params)
  if valid_token?(camera_params[:token])
    response  = PhysicalSecurity.start_recording(camera_params[:name])
    Utility::Response.new({ "result": response })
    #response = PhysicalSecurity.get_current_snapshot_url(camera_params[:name])
    #if response.status == 200
      #Utility::Response.new({"status": res})
  else
    Utility::Response.new({ "status": "invalid token" })
  end
#PhysicalSecurity.get_current_snapshot_url(camera_params[:name])
end

  def self.snapshot(camera_params)
  end

  def self.stop(camera_params)
  end


  private

  def self.valid_token?(token)
    if token.to_s == "12345"
      true
    else
      false
    end
  end

end
