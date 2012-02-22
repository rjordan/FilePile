class TagsController < ApplicationController
  respond_to :html, :json

  def index
    respond_with FileDocument.all_tags
  end

  def create
    file = FileDocument.find(params[:file_id])
    tags = params[:tags].split(',').map { |x| x.strip }
    tags.each{ |t| file.tags << t }
    file.save
    redirect_to file_path(file)
  end

  def update
    file = FileDocument.find(params[:file_id])
    file.tags << params['id']
    file.save
    redirect_to file_path(file)
  end

  def destroy
    file = FileDocument.find(params[:file_id])
    file.tags.tap{ |t| t.delete(params['id']) }
    file.save
    redirect_to file_path(file)
  end
end
