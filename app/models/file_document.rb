require 'digest/sha2'

class FileDocument
  include Mongoid::Document
  include Mongoid::Grid
  include Mongoid::Timestamps
  #include Mongoid::Taggable

  attr_accessible :tags

  field :fingerprint, :type=>String #sha_512
  field :tags, :type=>Array
  field :description
  attachment :file
  alias :name :file_name
  default_scope -> { asc(:file_name) }

  before_destroy do
    self.file = nil
    save!
  end

  def self.find_by_tags(tags)
    (tags.empty? ? all : all_in(:tags=>tags)).to_a
  end

  def set_data(filedata)
    self.fingerprint = Digest::SHA512.hexdigest(filedata.read)
    filedata.rewind
    self.file=filedata
  end

  def self.all_tags
    all.collect { |d| d.tags }.flatten.uniq.compact.sort
  end

  index({fingerprint: 1}, {unique: true})

  #before_validation do
  #  puts "File Id: #{self.file_id}"
  #  attributes[:fingerprint] = Digest::SHA512.hexdigest(attributes[:file].data)
  #end
end
