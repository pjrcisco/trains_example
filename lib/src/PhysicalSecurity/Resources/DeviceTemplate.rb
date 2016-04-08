require_relative './VideoStream'
require_relative './Recording'
require_relative './PolicyParameter'

module Resources

  class DeviceTemplate
    def initialize(args={})
      @name        = args[:name]             || args["name"]
      @description = args[:description]      || args["description"]
      @location    = args[:ownerLocationRef] || args["ownerLocationRef"]
      @vsom_uid    = args[:vsomUid]          || args["vsomUid"]
      @url         = args[:url]              || args["url"]
    end

    def to_hash
    {
      "systemDefined":false,
      "shared": true,
      "generic":true,
      "numAssocDevices":0,  
      "ownerLocationRef": @location,
      "videoStreams":[ Resources::VideoStream.default ],
      "recordings":[ Resources::Recording.default ],
      "participateInFailover":false,
      "preBuffer":0,
      "postBuffer":0,
      "lastModified":0,
      "enableRecordNow":true,
      "mergeRecordings":false,
      "name": @name,
      "tags":"tags",
      "description": @description,
      "vsomUid": @vsomUid,
      "objectType":"vs_deviceTemplate",
      "policyParameter":Resources::PolicyParameter.default(@url)
    }
    end
  end

end


