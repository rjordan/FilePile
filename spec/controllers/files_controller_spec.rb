require 'spec_helper'

describe FilesController do

  describe "GET index" do
    it "assigns all files as @files" do
      file_document = FactoryGirl.create(:file_document) 
      get :index
      assigns(:files).should include(file_document)
    end
  end
  
  describe "POST clear_tags" do
    it "resets session['tags'] to []" do
      session['tags'] = %w( test )
      post :clear_tags
      response.should redirect_to(files_path)
      session['tags'].should eq([])
    end
  end  
  
  describe "POST remove_tag" do
    it "removes a tag from session['tags']" do
      session['tags'] = %w( test )
      post :remove_tag, :id=>'test'
      response.should redirect_to(files_path)
      session['tags'].should eq([])
    end
  end  

  describe "POST add_tag" do
    it "add a tag to session['tags']" do
      session['tags'] = []
      post :add_tag, :id=>'test'
      response.should redirect_to(files_path)
      session['tags'].should include('test')
    end
  end    
end
