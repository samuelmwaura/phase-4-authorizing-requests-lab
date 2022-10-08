Rails.application.routes.draw do
  resources :articles, only: [:index, :show]  
  resources :members_only_articles, only: [:index, :show]

  #Routes for the login functionality - create a user session, fetch a logged in user session, delete a users session to log them out.
  get "/me", to: "users#show"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
