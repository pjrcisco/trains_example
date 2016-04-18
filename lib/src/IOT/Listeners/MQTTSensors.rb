require 'rubygems'
require 'mqtt'
require 'json'
require 'thread/pool'

require_relative '../API/REST/MQTTSensors/Event'
require_relative '../API/REST/Base'

module IOT
module Listener

  class Sensor
    attr_reader :name, :uri, :headers, :body
    def initialize(args={})
      @name    = args[:name]    || args["name"]
      @uri     = args[:uri]     || args["uri"]
      @body    = args[:body]    || args["body"]
      @headers = { "content-type": "application/json" }
      @ready   = true
      
    end

    def ready?
      @ready
    end

    def execute
      if @ready
        @ready = false
        Thread.new{
          res  = IOT::API::REST::MQTTSensors::Event.send(@uri , @headers, @body)
          puts res
          sleep(5)
          @ready = true
        }
      end
    end

  end

  module MQTTSensors

    def self.default_camera
      body = {
        "camera":{
          "name": "CIVS-IPC-6400E-01",
          "id": 12345,
          "token": 12345
        } 
      }
    end
    
    def self.default_host
      "173.36.206.19"
    end

    def self.listen
      trig1    = IOT::Listener::Sensor.new({                  ##### record
        name: "dist-1",
        uri: "http://#{default_host}/api/v1/camera/record",
        body: default_camera
      })
      trig2    = IOT::Listener::Sensor.new({                  ##### snapshot
        name: "light",
        uri: "http://#{default_host}/api/v1/camera/snapshot",
        body: default_camera
      })
      trig3    = IOT::Listener::Sensor.new({                  ##### stop
        name: "dist-2",
        uri: "http://#{default_host}/api/v1/camera/stop",
        body: default_camera
      })

      client   = MQTT::Client.connect(:host => '173.36.206.30', :port => 7777)
      client.get('devnet/2') do |topic,message|
          content = JSON.parse(message)
          #puts JSON.pretty_generate(content)
          #if content["trig"] = "dist-2"
          if content["trig"] != "none"
            case content["trig"]
              when trig1.name
                #puts trig1.name
                trig1.execute
              when trig2.name
              #  puts trig2.name
                trig2.execute
              when trig3.name
                #puts trig3.name
                trig3.execute
            end
          end
      end
    end

  end

end
end