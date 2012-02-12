class FileDocument
  include Mongoid::Document
  include Mongoid::Grid
  
  field :name, :type=>String
  field :fingerprint, :type=>String #sha_512
  field :tags, :type=>Array
  field :description
  attachment :file
end
