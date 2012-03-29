class FilesController < ApplicationController
  respond_to :html, :json

  def index
    #thumbnails 260x180 looks good
    @selected_tags = params["tags"].blank? ? [] : params["tags"]
    #@selected_tags = selected_tags
    @files = FileDocument.asc(:file_name)
    @files = @files.all_in(:tags=>@selected_tags) unless @selected_tags.empty?
    @tags = @files.collect { |d| d.tags }.flatten.uniq.compact.sort-@selected_tags
    respond_with @files
  end

  def show
    @file = FileDocument.find(params['id'])
    respond_with @file
  end

  def destroy
    FileDocument.find(params['id']).delete
    redirect_to files_path(:tags=>selected_tags)
  end
  
  def create
    document = params['document']
    f = FileDocument.create(:tags=>selected_tags)
    f.set_data document
    f.save
    redirect_to files_path(:tags=>selected_tags)
  end

  private

  def selected_tags
    [].concat(params['tags'].to_a).compact.reject(&:blank?)
  end
end
