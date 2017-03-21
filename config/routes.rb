Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	get 'password_resets/new'

	get 'password_resets/edit'

	root 'pages#index'

	get 'signup', to: 'users#new'
	resources :users, except: [:new]
	resources :videos
	post 'videos/:id', to: 'videos#quiz_submit'
	resources :quizzes
	resources :questions
	resources :answers, except: [:show]

	resources :events
	resources :eventcats, except: [:destroy] 
	resources :venues
	resources :attendees, except: [:show, :edit]

	get 'dashboard', to: 'pages#dashboard'

	get 'pages/users/filter_company', to: 'users#filter_company'
	get 'pages/users/filter_login', to: 'users#filter_login'
	get 'stats', to: 'pages#stats'
	get 'ereport', to: 'events#ereport'

	get 'login', to: 'sessions#new'
	post 'login', to: 'sessions#create'
	delete 'logout', to: 'sessions#destroy'

	get 'events/:id/checkin', to: 'event_attendees#checkin', as: 'checkin'
	post 'events/:id/checkin', to: 'event_attendees#attended'

	resources :password_resets, only: [:new, :create, :edit, :update]

	resources :categories, except: [:destroy] 

end
