# app/views/posts/index.rabl
collection @files, :object_root=>false
attribute :_id => :id
attributes :file_id, :file_name, :file_size, :description, 
           :file_type, :fingerprint, :tags
