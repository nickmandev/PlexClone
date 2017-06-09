Rails.application.routes.draw do
  scope module: :plex  do
    resources :users, :videos, :comments
    post 'authenticate', to: 'authentication#authenticate'

    get 'collection/:name', to: 'videos#user_by_name'

  end

end
