require_relative '../../../client'

module IOT
module API
module REST
module MQTTSensors

  class Event
    

    def self.send(uri, headers, body)
      client = IOT::Client.new({
        uri: URI(uri),
        headers: headers,
        body: body
      })
      client.post!
      client.results
    end
  end

end
end
end
end