Recepten::Application.routes.draw do
  resources :recipes do
    resources :ingredients
  end

  root :to => 'recipes#index'
end
