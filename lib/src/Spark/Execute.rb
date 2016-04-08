require 'src/Utility/Response'
require_relative 'Helper/Methods'
require 'json'

module Spark

  def self.send_image(email, message, url)
    id  = Helper::Methods.get_user_id_by_email(email)
    res = Helper::Methods.send_message(ENV["SPARK_TOKEN"], message, url, nil, id, nil)
  end

end
