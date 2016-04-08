Rails.application.routes.draw do

  root 'home#index'
  post 'api/v1/camera_event' => 'camera_event#handle'
  post 'register_phone'      => 'phone#register'

end
