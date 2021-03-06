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
      res = PhysicalSecurity.start_recording(camera_params[:name])
      if res.errors?
        return Utility::Response.errors(res)
      else
        return res
      end
    else
      return Utility::Response.invalid_token
    end
  end

  def self.snapshot(camera_params)
    if valid_token?(camera_params[:token])
      current_time = Time.now 
      file_name    = File.join(Rails.root, 'app/tmp/images/','jpg','#{current_time}.jpg')
      res          = PhysicalSecurity.get_snapshot(camera_params[:name], file_name, current_time)
      if res.errors?
        return res
      else
        Spark.send_image("priel@cisco.com", "Motion #{camera_params[:name]}", res.url)
      end
    else
      Utility::Response.invalid_token
    end
  end

#Utility::Response.new({ "result": res })
#      end
      #if response.okay?
        # ENV["current_ip"] + "/" + "images/tmp/#{current_time}"
        # res = Spark.send_image("priel@cisco.com", "Motion has been detected on #{camera_params[:name]}", response.url)
      #else
      #end
      #Utility::Response.new({ "result": response })
   # else
   #   Utility::Response.invalid_token
   # end
 # end

  def self.stop(camera_params)
    if valid_token?(camera_params[:token])
      Tropo.tropo_session("+19257755171", "Hello Patrick, The train has stopped")
    else
      Utility::Response.invalid_token
    end
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
