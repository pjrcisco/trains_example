require_relative "../../VSOM"
require_relative "../../Utility/Methods"
module API

  def self.create_clip_uri
    "/clip/createClip"
  end

  def self.get_clip_infos_uri
    "/clip/getClipInfos"
  end

  module REST
  module Clip
    def self.create(token, payload)
      Utility.create_vsom(token, API.create_clip_uri, payload)
    end
    
    def self.get_clip_infos(token, camera_refs, server_refs)
      payload = {
        "filter": {
          "byCameraRefs": camera_refs,
          "byServerRefs": server_refs
        }
      }
      Utility.create_vsom(token, API.get_clip_infos_uri, payload)
    end

  end
  end

end
