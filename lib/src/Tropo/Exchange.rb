require_relative 'Base'
require_relative '../Client'

module Tropo
  class Exchange
    def initialize(args={})
      @prefix      = args[:prefix]      || args["prefix"]
      @city        = args[:city]        || args["city"]
      @state       = args[:state]       || args["state"]
      @counrty     = args[:counrty]     || args["counrty"]
      @description = args[:description] || args["description"]
    end
  end
end
