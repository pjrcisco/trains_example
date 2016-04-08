module Resources

  class Recording
    def initialize(args={})
      @type               = args[:recordingType]
      @num                = args[:streamNum]
      @dur                = args[:duration]
      @expire_time        = args[:expireTime]
      @event_expire_time  = args[:expireTime]
      @storage_estimation = args[:storageEstimation]
      @start_immediate    = args[:startImmediate]
      @record_iframe      = args[:recordIframe]
      @archive_to_lts     = args[:archiveToLTS]
      @lts_retention_time = args[:ltsRetentionTime]
      @zero_video_loss    = args[:zeroVideoLossEnabled]
    end

    def to_hash
    {
      "recordingType": @type,
      "streamNum": @num,
      "duration": @dur,
      "expireTime": @expire_time,
      "eventExpireTime": @event_expire_time,
      "storageEstimation": @storage_estimation,
      "startImmediate": @start_immediate,
      "recordIframe": @record_iframe,
      "archiveToLTS": @archive_to_lts,
      "ltsRetentionTime": @lts_retention_time,
      "zeroVideoLossEnabled": @zero_video_loss
    }
    end

    def self.default
      recording = Recording.new({
        "recordingType":"LOOP",
        "streamNum":1,
        "duration":86400,
        "expireTime":1,
        "eventExpireTime":30,
        "storageEstimation":true,
        "startImmediate":true,
        "recordIframe":false,
        "archiveToLTS":false,
        "ltsRetentionTime":0,
        "zeroVideoLossEnabled":false
      })
      recording.to_hash
    end
  end


end