require 'src/Utility/Response'

class Phone < ActiveRecord::Base

  def self.register(params={})
    phone   = params[:phone]
    email   = params[:email]
    message = params[:message]
    if valid?
      new_phone(phone, email, message)
    else
      return Utility::Response.new({
        "status": "invalid phone"
      })
    end
  end

  private

  def self.valid?   # this function will check if the phone is valid
    return true     # due to laziness, returns true by default
  end
  
  def self.new_phone(phone, email, message)
    record = Phone.new(phone_number: phone, email: email, message: message)
    if record.save
      return Utility::Response.new({
        "status": 200
      })
    else
      return Utility::Response.new({
        "status": "unable to save the phone record"
      })
    end
    
  end

end
