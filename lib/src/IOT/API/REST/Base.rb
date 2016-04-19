module IOT
module API

  def self.ip
    #{}"http://10.10.130.19"
    "http://localhost:3000"
    #{}"http://173.36.206.19"
  end

  def record_uri
    '/api/v1/camera/record'
  end

  def snapshot_uri
    '/api/v1/camera/snapshot'
  end

  def stop_uri
    '/api/v1/camera/stop'
  end


end
end