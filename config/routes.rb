Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :bugs, only:[:index, :create,:update, :destroy ], :defaults => { :format => 'json' }
  get "/bugs/:number", to: "bugs#show"
end
