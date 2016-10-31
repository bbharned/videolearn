Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

root 'pages#index'

get 'signup', to: 'users#new'
resources :users, except: [:new]

get 'dashboard', to: 'pages#dashboard'
get 'lessonone', to: 'pages#lessonone'

get 'login', to: 'sessions#new'
post 'login', to: 'sessions#create'
delete 'logout', to: 'sessions#destroy'

end
