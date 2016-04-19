require 'src/Utility/Response'
require_relative 'Helper/Methods'
require 'json'

module Spark

  def self.send_image(email, message, url)
    id  = Helper::Methods.get_user_id_by_email(email)
    if id.nil?
      ::Utility::Response.errors("unable to retrieve id by email")
    else
      res = Helper::Methods.send_message(ENV["SPARK_TOKEN"], message, url, nil, id, nil)
      ::Utility::Response.new({
        "result": res
      })
    end
  end

end
