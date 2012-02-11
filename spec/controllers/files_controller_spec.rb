require 'spec_helper'

describe FilesController do
  def valid_attributes
    FactoryGirl.attributes_for(:product)
  end
  
  def valid_session
    { }
  end

  describe "GET index" do
    it "assigns all files as @files" do
      file_document = FactoryGirl.create(:file_document) 
      get :index, {}, valid_session
      assigns(:files).should include(file_document)
    end
  end
end
