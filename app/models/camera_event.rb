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


  private

  def self.valid_token?(token)
    if token.to_s == ENV["CAMERA_1_TOKEN"]
      true
    else
      false
    end
  end

end
