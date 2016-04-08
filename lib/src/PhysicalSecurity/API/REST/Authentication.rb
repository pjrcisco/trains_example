require_relative "../../VSOM"
require_relative "../../Utility/Methods"

module API

  def self.login_uri
    "/authentication/login"
  end

  module REST
  module Authentication

    def self.login(name, password)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.login_uri),
        body: {
          :username => name,
          :password => password
        }
      })
      vsom.post!
      unless vsom.results.nil?
        if vsom.results["status"]["errorType"]  == "SUCCESS"
          return  vsom.results['data']['uid'] 
        else
          return nil
        end
      end
    end

  end
  end

end 