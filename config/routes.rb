Rails.application.routes.draw do
  scope module: :plex  do
    resources :users
    post 'authenticate', to: 'authentication#authenticate'
  end

end
