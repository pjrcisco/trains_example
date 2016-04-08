require 'json'
module Utility
  class Response

    def initialize(args={})
      @data = args
    end

    def json
      @data.to_json
    end

    def status
      @data[:status] || @data["status"]
    end
  
    def url
      @data[:url] || @data["url"]
    end

  end
end