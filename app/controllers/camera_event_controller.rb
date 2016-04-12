class CameraEventController < ApplicationController
  before_action :validate_params, only: [:handle]

  def handle
    respond_to do |format|
      format.json {
        handle_camera_event
      }
    end
  end

  def handle_get
    respond_to do |format|

    format.html{
      render :json =>{status: 200}
    }

    format.json{
      render :json => {status: 200}
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
