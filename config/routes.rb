Recepten::Application.routes.draw do
  resources :ingredients do
    resources :recipes
  end

  root :to => 'recipes#index'
end
