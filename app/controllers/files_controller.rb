class FilesController < ApplicationController
  def index
    @files = FileDocument.scoped
    @files = @files.any_in(:tags=>session['tags']) unless session['tags'].nil? || session['tags']==[]
    @tags = @files.collect { |d| d.tags }.flatten.uniq.compact - session['tags']
  end
  
  def show
    file = FileDocument.find(params['id'])
    send_data file.file.data, 
              :content_type=>file.file_type, 
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
    tag = params[:id]
    session['tags'] << tag
    redirect_to :action=>:index
  end  
end
