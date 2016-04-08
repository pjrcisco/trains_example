class CameraEventController < ApplicationController
  before_action :validate_params

  def handle
    respond_to do |format|
      format.json {
        handle_camera_event
      }
    end
  end

  protected

  def validate_params
    params.require(:camera).require(:id)
    params.require(:camera).require(:name)
    params.require(:camera).require(:token)
  end


  private

  def handle_camera_event
    response = CameraEvent.handle(params[:camera])
    render :json => response.json
  end

end
