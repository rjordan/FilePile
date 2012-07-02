Filepile::Application.routes.draw do

  #match "/gridfs/:id/:filename" => Rack::GridFS(:id)
  mount Rack::GridFS::Endpoint.new(:db => Mongoid.database, :mapper => lambda { |path| %r!/(.+)/!.match(path)[1] }), :at => "/gridfs"

  match "files/tags" => "tags#index"
  resources :files do
    resources :tags
  end

  root :to=>"files#index"
end
