Rails.application.routes.draw do

  root 'home#index'
  post 'api/v1/camera_event' => 'camera_event#handle'
  post 'register_phone'      => 'phone#register'



  get 'api/v1/camera_event' => 'camera_event#handle_get'

end
