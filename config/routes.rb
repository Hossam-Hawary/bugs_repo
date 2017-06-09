Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :states, :defaults => { :format => 'json' }
  resources :bugs, :defaults => { :format => 'json' }
end
