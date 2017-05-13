Rails.application.routes.draw do
  scope module: :plex  do
    resources :users, :videos
    post 'authenticate', to: 'authentication#authenticate'
  end

end
