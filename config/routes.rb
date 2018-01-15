Rails.application.routes.draw do
  root to: "pages#home"

  get '/search', to: 'pages#search'

  namespace :api, defaults: { format: :json } do
    resources :quotes, only: [ :show ]
  end

end
