require_relative 'Routes'
require_relative '../Client'

module Tropo
  class Sessions
    def initialize(args={})
      @token    = args[:token]   || args["token"]
      @message  = args[:message] || args["message"]
      @numbers  = args[:numbers] || args["numbers"]
      @from     = args[:from]    || args["from"]
    end

    def body
      {
        "token": @token,
        "phone_numbers": @numbers,
        "the_message": @message
        #{}"from": @from
      }
    end
  end
end