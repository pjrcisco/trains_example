require_relative '../API/REST/People'
require_relative '../API/REST/Messages'
require 'json'

module Spark
module Helper
  
  module Methods

    def self.get_user_id_by_email(email)
      params = {
        "email": email,
        "max": 1
      }
      results = []
      res = API::REST::People.list(ENV["SPARK_TOKEN"], params)
      res["items"].each do |person|
        results << person
      end
      results[0]["id"]
    end

    def self.send_message(token, text, files, room_id, to_person_id, to_person_email)
      params = {}
      params["text"]          = text            if text.nil?            == false
      params["files"]         = files           if files.nil?           == false
      params["roomId"]        = room_id         if room_id.nil?         == false
      params["toPersonId"]    = to_person_id    if to_person_id.nil?    == false
      params["toPersonEmail"] = to_person_email if to_person_email.nil? == false
      res = API::REST::Messages.create(token, params)
    end




  end




end
end