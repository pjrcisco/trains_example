
require_relative "../../VSOM"
require_relative "../../Utility/Methods"

module API

  def self.get_all_uri
    "/job/getAllJobStatus"
  end 
  
  def self.get_uri
    "/job/getJobStatus"
  end

  module REST
  module Jobs
    def self.get_all(token, filter)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.get_all_uri),
        headers: Utility.apply_token(token),
        body: {
          "filter": filter
        }
      })
      vsom.post!
      vsom.results
    end

    def self.get(token, job_reference)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.get_uri),
        headers: Utility.apply_token(token),
        body: { "jobRef": job_reference }
      })
      vsom.post!
      vsom.results
    end
  end
  end
end