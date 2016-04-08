module Resources
module Rest
  
  class CameraSettings
    def initialize(args={})
      @vendor = args[:vendor] || args["vendor"]
      @model  = args[:model]  || args["model"]
      @firmwareVersion = args[:firmwareVersion] || args["firmwareVersion"]
      @createFullMotionWindow = args[:createFullMotionWindow] || args["createFullMotionWindow"]
    end
  end

end
end