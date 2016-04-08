require_relative "../../VSOM"
require_relative "../../Utility/Methods"

module API
  
  def self.get_tree_uri
    "/location/getLocationTree"
  end

  module REST
  module Location
    def self.get_tree(token, filter)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.get_tree_uri),
        headers: Utility.apply_token(token),
        body: { "treeFilter": filter }
      })
      vsom.post!
      vsom.results
    end
  end
  end
end