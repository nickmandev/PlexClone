Rails.application.routes.draw do
  scope module: :plex  do
    resources :users, :sessions
  end

end
