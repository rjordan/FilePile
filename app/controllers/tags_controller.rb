class TagsController < ApplicationController
  respond_to :html, :json

  def index
    respond_with FileDocument.all_tags
  end
  
  def update
    file = FileDocument.find(params[:file_id])
    file.tags << params['id']
    redirect_to file_path(file)
  end
end
