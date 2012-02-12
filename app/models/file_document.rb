require 'digest/sha2'

class FileDocument
  include Mongoid::Document
  include Mongoid::Grid
  
  field :fingerprint, :type=>String #sha_512
  field :tags, :type=>Array
  field :description
  attachment :file
  alias :name :file_name
  
  #before_validation do
  #  attributes[:fingerprint] = Digest::SHA512.hexdigest(attributes[:file].read)
  #end
end
