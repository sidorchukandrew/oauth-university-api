Rails.application.routes.draw do
  resources :guides, :series, :roles
  resources :permissions, only: [:index]
  patch 'series', action: :update_bulk, controller: "series"
  delete 'series', action: :delete_bulk, controller: "series"
  get 'aws/images/signed_url', action: :get_presigned_url, controller: "images"
  delete 'aws/images', action: :delete_image, controller: "images"

  post 'auth/login', action: :login, controller: "auth"
  get '/users/me', action: :me, controller: "users"

end
