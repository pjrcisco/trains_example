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


  def record
    respond_to do |format|
      format.json {
        record_camera
      }
    end
  end

  def snapshot
    respond_to do |format|
      format.json {
        snapshot_camera
      }
    end
  end

  def stop
    respond_to do |format|
      format.json {
        stop_camera
      }
    end
  end

  protected

  def validate_params
    params.require(:camera).require(:id)
    params.require(:camera).require(:token)
  end


  private

  def record_camera
    response = CameraEvent.record(params[:camera])
    render :json => response.json
  end

  def snapshot_camera
    response = CameraEvent.snapshot(params[:camera])
    render :json => response.json
  end

  def stop_camera
    response = CameraEvent.stop(params[:camera])
    render :json => response.json
  end


  def handle_camera_event
    response = CameraEvent.handle(params[:camera])
    render :json => response.json
  end

end
