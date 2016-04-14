class ImagesController < ApplicationController

  def get
    get_image
  end

  private
  
  def get_image
    file_name  = File.join(Rails.root, 'app/tmp/images/',"#{params[:id]}.jpg")
    if File.exist?(file_name)
      send_file file_name
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

end
