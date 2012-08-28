class FilesController < ApplicationController
  respond_to :html, :json

  def index
    #thumbnails 260x180 looks good
    @selected_tags = params["tags"].blank? ? [] : params["tags"]
    @files = FileDocument.asc(:file_name)
    @files = @files.all_in(:tags=>@selected_tags) unless @selected_tags.empty?
    respond_with @files
  end

  def show
    @file = FileDocument.find(params['id'])
    respond_with @file
  end

  def destroy
    FileDocument.find(params['id']).delete
    respond_to do |format|
      format.html { redirect_to files_path(:tags=>selected_tags) }
      format.json { render :nothing=>true, :status=>200  }
    end
  end
  
  def create
    document = params['document']
    tags = params['tags'].include?(',') ? params['tags'].split(',') : params['tags']
    f = FileDocument.create(:tags=>tags)
    f.set_data document
    f.save
    #Don't redirect on JS send Created with info instead!
    #redirect_to files_path(:tags=>selected_tags)
  end

  def update
    @file = FileDocument.find(params['id'])
    @file.update_attributes(params)
    respond_with @file
  end

  private

  def selected_tags
    [].concat(params['tags'].to_a).compact.reject(&:blank?)
  end
end
