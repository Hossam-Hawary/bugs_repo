Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#home'
    namespace :api, :defaults => { :format => 'json' }do
          scope module: :v1, constraints: ApiConstraint.new(version:1) do
            resources :bugs, only:[:index, :create ]
            get "/bugs/:number", to: "bugs#show"
            get 'search', to: 'search#search'
          end

          ############################
            # add the constraints to make it the default version....
          ###########################
          #scope module: :v2 do , constraints: ApiConstraint.new(version:2) do
          scope module: :v2 do
            resources :bugs, only:[:index, :create ]
            get "/bugs/:number", to: "bugs#show"
            get 'search', to: 'search#search'
          end
    end
  end
