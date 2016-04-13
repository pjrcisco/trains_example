module IOT
module API

  def self.ip
    "http://10.10.30.19"
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