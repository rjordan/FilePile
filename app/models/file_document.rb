require 'digest/sha2'

class FileDocument
  include Mongoid::Document
  include Mongoid::Grid
  
  field :fingerprint, :type=>String #sha_512
  field :tags, :type=>Array
  field :description
  attachment :file
  alias :name :file_name

  def set_data(filedata)
    self.fingerprint = Digest::SHA512.hexdigest(filedata.read)
    filedata.rewind
    self.file=filedata
  end

  def self.all_tags
    all.collect { |d| d.tags }.flatten.uniq.compact.sort
  end

  #before_validation do
  #  puts "File Id: #{self.file_id}"
  #  attributes[:fingerprint] = Digest::SHA512.hexdigest(attributes[:file].data)
  #end
end
