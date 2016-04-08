require_relative 'Base'
require_relative '../Client'

module Tropo
  class Sessions
    def initialize(args={})
      @href          = args[:href]          || args["href"]
      @name          = args[:name]          || args["name"]
      @voice_url     = args[:voice_url]     || args["voice_url"]
      @messaging_url = args[:messaging_url] || args["messaging_url"]
      @platform      = args[:platform]      || args["platform"]
      @partition     = args[:partition]     || args["partition"]
    end
  end
end