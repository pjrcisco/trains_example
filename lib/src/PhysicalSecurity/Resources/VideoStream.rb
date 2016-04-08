module Resources
  
  class VideoStream
    def initialize(args={})
      @num               = args[:streamNum]
      @viewable          = args[:viewable]
      @motion_configured = args[:motionConfigured]
      @recordable        = args[:recordable]
      @profile           = args[:videoStreamProfile]
    end
    def to_hash
      {
        "streamNum": @num,
        "viewable": @viewable,
        "motionConfigured": @motion_configured,
        "recordable": @recordable,
        "videoStreamProfile": @profile
      }
    end

    def self.default
      vs = VideoStream.new({
        "streamNum": 1,
        "viewable": true,
        "motion_configured": true,
        "recordable": true,
        "videoStreamProfile": {
          "videoQuality":"medium",
          "format":"NTSC",
          "ltsRetentionDays":0,
          "suspendableProxy":false
        }
      })
      vs.to_hash
    end
  end

end