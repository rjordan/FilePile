Filepile::Application.routes.draw do

  resources :files
  match 'files/:id/:filename' => 'files#get_data'

  root :to=>"files#index"
end
