Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    namespace :api, :defaults => { :format => 'json' }do
          scope module: :v1, constraints: ApiConstraint.new(version:1) do
            resources :bugs, only:[:index, :create,:update, :destroy ]
            get "/bugs/:number", to: "bugs#show"
          end
          ############################
            # remove the constraints to make it the default version....
          ###########################
          scope module: :v2, constraints: ApiConstraint.new(version:2)do
            resources :bugs, only:[:index, :create,:update, :destroy ]
            get "/bugs/:number", to: "bugs#show"
          end
    end
    get 'search', to: 'search#search'
  end
