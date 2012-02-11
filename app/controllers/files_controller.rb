class FilesController < ApplicationController
  def index
    @files = FileDocument.all
  end
end
