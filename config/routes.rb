CannaPages::Application.routes.draw do

#Base application routes
  root :to => 'pages#home'  
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'login', to: 'sessions#new', as: 'login'
  get 'signup', to: 'users#new', as: 'signup'

#main pages
  get 'home', to: "pages#home"
  get 'critiques', to: "pages#critiques", as: :critiques
    get 'critiques/:type', to: "pages#critiques", as: :critiques_type
  get 'news', to: "pages#news", as: :news
    get 'news/archive', to: "volumes#archive", as: :news_archive
    get 'articles', to: "pages#articles", as: :articles_index
    get 'rss', to: "pages#rss", as: :rss
  get 'wiki', to: "pages#wiki", as: :wiki
 
#Resource deffinitions
  resources :users
  resources :sessions
  resources :articles
  resources :volumes
  post "volumes/create", to: "volumes#create", as: "create_volume"
  post "volumes/set_as_current/:id", to: "volumes#set_as_current", as: "set_current_volume"
  resources :dispensaries
  resources :user_profiles
  resources :article_comments
  resources :user_strain_reviews
  resources :user_strain_wikis
  resources :critiques

#Custom rest routes

#Critiques
	match "critiques/articles" => "critiques#articles"
  match "critiques/dispensaries" => "critiques#dispensaries"
  match "critiques/strains" => "critiques#strains"

#Strains wiki
	match "strains/index" => "strains#index"

#Cadets back end
  match "cadets/user_profile" => "cadets#user_profile"
  match "cadets/news_posts" => "cadets#news_posts"
  match "cadets/critiques" => "cadets#critiques"
  match "cadets/volumes" => "cadets#volumes"
  match "cadets/news_comments" => "cadets#news_comments"
  match "cadets/strain_reviews" => "cadets#strain_reviews"
  match "/cadets/strain_wikis" => "cadets#strain_wikis"
  match "/cadets/dispensaries" => "cadets#dispensaries"

#Search enginge
  put "canna_engine/dispensaries" => "canna_engine#dispensaries", as: "dispensary_search"

end
