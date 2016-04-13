Rails.application.routes.draw do

  root 'home#index'
  post 'api/v1/camera_event' => 'camera_event#handle'
  post 'register_phone'      => 'phone#register'

  post 'api/v1/camera/record'   => 'camera_event#record'
  post 'api/v1/camera/snapshot' => 'camera_event#snapshot'
  post 'api/v1/camera/stop'     => 'camera_event#stop'


  get 'api/v1/camera_event' => 'camera_event#handle_get'

end
