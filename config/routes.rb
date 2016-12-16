Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

get 'password_resets/new'

get 'password_resets/edit'

root 'pages#index'

get 'signup', to: 'users#new'
resources :users, except: [:new]
resources :videos
resources :quizzes
resources :questions
resources :answers, except: [:show]

get 'dashboard', to: 'pages#dashboard'

get 'login', to: 'sessions#new'
post 'login', to: 'sessions#create'
delete 'logout', to: 'sessions#destroy'

resources :password_resets, only: [:new, :create, :edit, :update]

resources :categories, except: [:destroy] 
end
