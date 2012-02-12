Filepile2::Application.routes.draw do
  mount Rack::GridFS::Endpoint.new(:db => Mongoid.database), :at => "gridfs"

  resources :files do
    member do
      get :details
    end
    collection do
      post :add_tag
      post :remove_tag
      post :clear_tags
      post :upload
    end
    resources :tags
  end

  root :to=>"files#index"
end
