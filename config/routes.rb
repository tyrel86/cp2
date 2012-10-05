CannaPages::Application.routes.draw do

#Base application routes
  root :to => 'dispensaries#search'  
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'login', to: 'sessions#new', as: 'login'
  get 'signup', to: 'users#new', as: 'signup'
 
 #Custom rest routes
#Critiques
  match "critiques/dispensaries" => "critiques#index_dispensaries", as: "critiques_dispensaries"
  match "critiques/strains" => "critiques#index_strains", as: "critiques_strains"
	get "critiques/index_for_listing/:id" => "critiques#index_for_listing", as: :critiques_for_listing
 
#Resource deffinitions
	match "dispensaries/admin/manage_featured", to: "dispensaries#manage_featured", as: :manage_featured_dispensaries
	match "dispensaries/renew_featured/:id", to: "dispensaries#renew_featured", as: :renew_featured_dispensary
	get "dispensaries/featured_show/:id", to: "dispensaries#featured_show", as: :featured_dispensary_show
	resources :dispensaries
	get "dispensaries/user_index/:id", to: "dispensaries#user_index", as: :user_dispensaries
	match "dispensaries/admin_index/:id", to: "dispensaries#admin_index", as: :user_dispensaries_admin
	match "dispensaries/request_featured/:id", to: "dispensaries#request_featured", as: :request_featured_dispensary
	match "dispensaries/set_as_featured/:id", to: "dispensaries#set_as_featured", as: :set_featured_dispensary
	match "search/dispensaries" => "dispensaries#search", as: "dispensary_search"
	get "dispensaries/nearyou", to: "dispensaries#nearyou"

	get "ads/admin_index", to: "ads#admin_index", as: :admin_ads
	resources :ads
	get "ads/renew/:id", to: "ads#renew", as: :ad_renew
	get "ads/user_index/:id", to: "ads#user_index", as: :user_ads
	put "ads/admin_update/:id", to: "ads#admin_update", as: :ads_admin_update
	match "ads/admin_destroy/:id", to: "ads#admin_destroy", as: :admin_destroy
	get "ads/confirm/:id", to: "ads#confirm", as: :ad_confirm

  resources :dispensary_comments
	get "dispensary_comments/user_index/:id", to: "dispensary_comments#user_index", as: :user_dispensary_comments
	get "user_dispensary_reviews/user_index/:id", to: "user_dispensary_reviews#user_index", as: :user_user_dispensary_reviews

	resources :user_dispensary_reviews

  resources :users

  resources :user_profiles

  resources :user_strain_reviews

  resources :user_strain_wikis

  resources :sessions

  resources :articles

	resources :hours_of_operations, only: [:update]

	resources :daily_special_lists, only: [:update]

	resources :feeds, except: [:show]
	get "feeds/user_index", to: "feeds#user_index", as: :admin_feeds
	get "feeds/pull", to: "feeds#pull", as: :feeds_pull

	get "articles/user_index/:id", to: "articles#user_index", as: :user_articles

  resources :lessons

	get "lessons/user_index/:id", to: "lessons#user_index", as: :user_lessons

  resources :article_comments
	get "article_comments/user_index/:id", to: "article_comments#user_index", as: :user_article_comments

	post "volumes/create", to: "volumes#create", as: "create_volume"
	post "volumes/set_as_current/:id", to: "volumes#set_as_current", as: "set_current_volume"
	get "volumes/manage", to: "volumes#manage", as: "manage_volumes"
	get "volumes/current", to: "volumes#current", as: "current_volume"
	put "search/articles" => "articles#search", as: "volume_search"
	resources :volumes

  resources :critiques
	get "critiques/user_index/:id", to: "critiques#user_index", as: :user_critiques
	put "search/critiques" => "critiques#search", as: "critique_search"

	match "strains/index" => "strains#index"

end
