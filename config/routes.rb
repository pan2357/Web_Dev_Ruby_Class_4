Rails.application.routes.draw do
  resources :posts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'create_fast', to: 'users#create_fast'
  get 'main', to: 'users#main'
  post 'main', to: 'users#login'
  get '/users/:user_id/create_post', to: 'users#create_post', as: 'post_create'
  post '/users/:user_id/create_post', to: 'users#create_post_process'
  get '/users/:user_id/edit_post/:post_id', to: 'users#edit_post', as: 'post_edit'
  patch '/users/:user_id/edit_post/:post_id', to: 'users#edit_post_process'
  delete 'users/:user_id/delete_post/:post_id', to: 'users#delete_post', as: 'post_delete'
end
