CannaPages::Application.routes.draw do

#Base application routes
  root :to => 'dispensaries#nearyou'  
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'login', to: 'sessions#new', as: 'login'
  get 'signup', to: 'users#new', as: 'signup'
 
 #Custom rest routes
#Critiques
  match "critiques/dispensaries" => "critiques#index_dispensaries", as: "critiques_dispensaries"
  match "critiques/strains" => "critiques#index_strains", as: "critiques_strains"
 
#Resource deffinitions
  	get "dispensaries/nearyou", to: "dispensaries#nearyou"
	resources :dispensaries
    get "dispensaries/user_index/:id", to: "dispensaries#user_index", as: :user_dispensaries
    match "search/dispensaries" => "dispensaries#search", as: "dispensary_search"
  resources :dispensary_comments
  #Dispensary reviews
    get "dispensary_comments/user_index/:id", to: "dispensary_comments#user_index", as: :user_dispensary_comments
    get "user_dispensary_reviews/user_index/:id", to: "user_dispensary_reviews#user_index", as: :user_user_dispensary_reviews
    resources :user_dispensary_reviews
  resources :users
  resources :user_profiles
  resources :user_strain_reviews
  resources :user_strain_wikis
  resources :sessions
  resources :articles
    get "articles/user_index/:id", to: "articles#user_index", as: :user_articles
  resources :lessons
    get "lessons/user_index/:id", to: "lessons#user_index", as: :user_lessons
  resources :article_comments
    get "article_comments/user_index/:id", to: "article_comments#user_index", as: :user_article_comments
  #Volumes  
    post "volumes/create", to: "volumes#create", as: "create_volume"
    post "volumes/set_as_current/:id", to: "volumes#set_as_current", as: "set_current_volume"
    get "volumes/manage", to: "volumes#manage", as: "manage_volumes"
    get "volumes/current", to: "volumes#current", as: "current_volume"
    put "search/articles" => "articles#search", as: "volume_search"
    resources :volumes
  resources :critiques
    get "critiques/user_index/:id", to: "critiques#user_index", as: :user_critiques
    put "search/critiques" => "critiques#search", as: "critique_search"

#Strains wiki
	match "strains/index" => "strains#index"

end
