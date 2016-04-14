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
      response = PhysicalSecurity.start_recording(camera_params[:name])
      Utility::Response.new({ "result": response })
    else
      Utility::Response.invalid_token
    end
  end

  def self.snapshot(camera_params)
    if valid_token?(camera_params[:token])
      current_time = Time.now 
      file_name    = File.join(Rails.root, 'app/tmp/images/','jpg','#{current_time}.jpg')
      response     = PhysicalSecurity.get_snapshot(camera_params[:name], file_name, current_time)
      #if response.okay?
        # ENV["current_ip"] + "/" + "images/tmp/#{current_time}"
        # res = Spark.send_image("priel@cisco.com", "Motion has been detected on #{camera_params[:name]}", response.url)
      #else
      #end
      Utility::Response.new({ "result": response })
    else
      Utility::Response.invalid_token
    end
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
