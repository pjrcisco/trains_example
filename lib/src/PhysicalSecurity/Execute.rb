require 'src/Utility/Response'
require_relative 'Helper/Methods'
require_relative 'API/REST/Authentication'
require 'json'

module PhysicalSecurity

  def self.get_current_snapshot_url(name)
    token  = API::REST::Authentication.login("admin", ENV["VSOM_PASSWORD"])
    camera = Helper::Methods.get_camera_by_name(token, name)
    if camera.nil?
      return Utility::Response.new({ "status": "camera not found" })
    end
    recordings = Helper::Methods.get_recordings_by_camera(token, camera)
    if recordings.nil?
      return Utility::Response.new({ "status": "no camera recordings found" })
    end
    url = Helper::Methods.get_current_snapshot_url(token, recordings)
    if url.nil?
      return Utility::Response.new({ "status": "unable to get snapshot url" })
    else
      return Utility::Response.new({ "status": 200, "url": url })
    end
  end

  def self.start_recording(name)
    token = API::REST::Authentication.login("admin", ENV["VSOM_PASSWORD"])
    res   = PhysicalSecurity::Helper::Methods.start_recording(token, name)
    unless res.nil? || res["status"].nil? || res["status"]["errorType"] != "SUCCESS"
      return Utility::Response.new({ "data": res["data"] })
    end
    return Utility::Response.error(res)
  end

  def self.stop_recording(name)
    token = API::REST::Authentication.login("admin", ENV["VSOM_PASSWORD"])
    res   = PhysicalSecurity::Helper::Methods.stop_recording(token, name)
    unless res.nil? || res["status"].nil? || res["status"]["errorType"] != "SUCCESS"
      return Utility::Response.new({ "data": res["data"] })
    end
    return Utility::Response.error(res)
  end

  def self.get_snapshot(name, file_name, start_time)
    token = API::REST::Authentication.login("admin", ENV["VSOM_PASSWORD"])
    res   = PhysicalSecurity::Helper::Methods.get_snapshot(token, name, file_name, start_time)
    unless res.nil? || res[:status].nil? || res[:status].to_s != "200"
      return Utility::Response.new({ "data": res["data"] })
    end
    return Utility::Response.error(res)
  end

end
