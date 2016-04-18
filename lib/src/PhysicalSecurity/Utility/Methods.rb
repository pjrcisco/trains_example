require 'net/http'
require_relative '../VSOM'
module Utility
    
    def self.ip
     # "171.68.22.61"  # this is the IP accessible when using San Jose SSL/Blizzard
     "10.10.120.69"
     #{}"10.10.20.69"
     #{}"171.68.22.181"
    end

    def self.base_uri_json
     "https://#{ip}/ismserver/json"
    end

    def self.apply_token(token)
      { "x-ism-sid" => token }
    end

    def self.set_uri(resource)
      URI(base_uri_json + resource)
    end

    def self.encode_url_params(base_url, args={})
      uri = base_url + "?"
      args.each do |k, v|
        unless v.nil?
          uri = uri + k.to_s + "=" + v.to_s + "&"
        end
      end
      uri[0...-1]
    end

    def self.swap_ip(uri, ip)
      url = URI(uri)
      url.host = ip
      url.to_s
    end

    def self.create_vsom(token, uri, payload)
      vsom = VSOM.new({
        uri: Utility.set_uri(uri),
        headers: Utility.apply_token(token),
        body: payload
      })
      vsom.post!
      vsom.results
    end

    def self.create_vsom_to_file(token, file_name, uri, payload)
      vsom = VSOM.new({
        uri: Utility.set_uri(uri),
        headers: Utility.apply_token(token),
        body: payload
      })
      vsom.post_to_file(file_name)
      vsom.results
    end


end