Rails.application.routes.draw do
  scope module: :plex  do
    resources :users, :videos, :comments, :comments_response
    post 'authenticate', to: 'authentication#authenticate'

    get 'collection/:name', to: 'videos#user_by_name'

    post 'users-avatar/', to: 'users#update_avatar'
  end

end
