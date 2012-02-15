class FilesController < ApplicationController
  def index
    #thumbnails 260x180 looks good
    @selected_tags = [].concat(params['tags'].to_a).compact.reject(&:blank?)
    @files = FileDocument.scoped
    @files = @files.all_in(:tags=>@selected_tags) unless @selected_tags.empty?
    @tags = @files.collect { |d| d.tags }.flatten.uniq.compact.sort-@selected_tags
  end

  def show
    @file = FileDocument.find(params['id'])
  end

  def destroy
    selected_tags = [].concat(params['tags'].to_a).compact.reject(&:blank?)
    FileDocument.find(params['id']).delete
    redirect_to files_path(:tags=>selected_tags)
  end
  
  def create
    selected_tags = [].concat(params['tags'].to_a).compact.reject(&:blank?)
    document = params['document']
    f = FileDocument.create(:tags=>selected_tags)
    f.set_data document
    f.save
    redirect_to files_path(:tags=>selected_tags)
  end 
end
