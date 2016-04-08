require_relative 'Base'
require_relative '../Client'

module Tropo
  class Address
    def initialize(args={})
      @type    = args[:type]   || args["type"]
      @prefix  = args[:prefix] || args["prefix"]
      @number  = args[:number] || args["number"]
      @city    = args[:city]   || args["city"]
      @state   = args[:state]  || args["state"]
      @channel = args[:channel]|| args["channel"]
      @token   = args[:token]  || args["token"]
    end
  end
end