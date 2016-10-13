Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

root 'pages#index'
get 'dashboard', to: 'pages#dashboard'
get 'lessonone', to: 'pages#lessonone'

end
