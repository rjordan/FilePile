require 'digest/sha2'

class FilesController < ApplicationController
  def index
    #thumbnails 260x180 looks good
    @files = FileDocument.scoped
    @files = @files.all_in(:tags=>session['tags']) unless session['tags'].nil? || session['tags']==[]
    @tags = @files.collect { |d| d.tags }.flatten.uniq.compact.sort
    @tags -= session['tags'] unless session['tags'].nil?
  end
  
  def show
    file = FileDocument.find(params['id'])
    send_data file.file.read, 
              :type=>file.file_type, 
              :filename=>file.file_name, 
              :disposition=>'inline'
  end
  
  def clear_tags
    session['tags'] = []
    redirect_to :action=>:index
  end
  
  def remove_tag
    tag = params[:id]
    session['tags'].delete(tag) unless session['tags'].nil?
    redirect_to :action=>:index
  end

  def add_tag
    session['tags'] ||= []
    tag = params[:id]
    session['tags'] << tag
    session['tags'].sort!
    redirect_to :action=>:index
  end 
  
  def upload
    document = params['document']
    f = FileDocument.create(:tags=>session['tags'])
    f.fingerprint = Digest::SHA512.hexdigest(File.read(document.tempfile.path))
    f.file = document.tempfile
    f.file_name = document.original_filename
    #f.file_type = document.content_type                        
    f.file_type = MIME::Types.type_for(document.original_filename).first.try(:content_type) || document.content_type
    f.save
    redirect_to :action=>:index
  end 
end
