require_relative 'Base'
require_relative '../Client'

module Tropo
  class Signals
    def initialize(args={})
      @signal = args[:signal] || args["signal"]
      @status = args[:status] || args["status"]
    end
  end
end