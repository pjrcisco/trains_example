module Resources
module REST
module References

  class BaseObjectRef
    def initialize(args={})
      @name        = args[:refName]       || args["refName"]
      @object_type = args[:refObjectType] || args["refObjectType"]
      @id          = args[:refUid]        || args["refUid"]
      @vsomUid     = args[:refVsomUid]    || args["refVsomUid"]
    end

    def to_hash
      {
        "refUid": @id,
        "refName": @name,
        "refObjectType": @object_type,
        "refVsomUid": @vsomUid,
      }
    end

  end


end
end
end