Filepile2::Application.routes.draw do
  resources :files do
    member do
      get :details
    end
    collection do
      post :add_tag
      post :remove_tag
      post :clear_tags
    end
    resources :tags
  end

  root :to=>"files#index"
end
