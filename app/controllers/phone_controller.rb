class PhoneController < ApplicationController
  before_action :validate_params

  def register
    respond_to do |format|
      format.json {
        register_phone
      }
    end


  end

  protected
  def validate_params
    params.require(:phone)
    params.require(:message)
    params.require(:email)
  end

  private

  def register_phone
    response = Phone.register params
    render :json => response.json
  end

end
