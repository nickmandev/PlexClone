Rails.application.routes.draw do
  scope module: :plex  do
    resources :users, :videos
    post 'authenticate', to: 'authentication#authenticate'

    get 'stream', to: 'videos_controller#stream'
  end

end
