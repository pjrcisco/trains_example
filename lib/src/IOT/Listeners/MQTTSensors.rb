require 'rubygems'
require 'mqtt'
require 'json'
require 'thread/pool'

require_relative '../API/REST/MQTTSensors/Event'
require_relative '../API/REST/Base'

module IOT
module Listener

  class Sensor
    attr_reader :name, :action, :semaphore
    def initialize(name, action)
      @name   = name
      @action = action
      @ready  = true
      @semaphore = Mutex.new
    end

    def ready?
      @ready
    end

    def execute
      if @ready
        @ready = false
          body = {
            "camera":{
              "name": "6400E-01",
              "id": 2,
              "token": 2
            } 
          } 
        IOT::API::REST::MQTTSensors::Event.send("http://10.10.30.19" + @action , nil, body)
        #Thread.new{
        #  uri = "http://10.10.30.19" + @action 
        #  puts uri
        ##  body = {
        #    "camera":{
        #      "name": "6400E-01",
        #      "id": 2,
        #      "token": 2
        #    } 
        #  } 
        #  puts IOT::API::REST::MQTTSensors::Event.send(uri, nil, body)
          sleep(5)
          @ready = true
        }
      end
    end

  end

  module MQTTSensors
    def self.listen
      trig1    = IOT::Listener::Sensor.new("dist-2", '/api/v1/camera/record')
      trig2    = IOT::Listener::Sensor.new("dist-1", '/api/v1/camera/snapshot')
      trig3    = IOT::Listener::Sensor.new("light",  '/api/v1/camera/stop')
      client = MQTT::Client.connect(:host => '173.36.206.30', :port => 7777)
      client.get('devnet/2') do |topic,message|
          content = JSON.parse(message)
          if content["trig"] = "dist-2"
          puts "--->"
          #if content["trig"] != "none"
            case content["trig"]
              when trig1.name
                trig1.execute
              when trig2.name
                trig2.execute
              when trig3.name
                trig3.execute
            end
          end
      end
    end
  end


end
end
IOT::Listener::MQTTSensors.listen