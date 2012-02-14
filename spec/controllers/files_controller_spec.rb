require 'spec_helper'

describe FilesController do

  describe "GET index" do
    it "assigns all files as @files" do
      file_document = FactoryGirl.create(:file_document) 
      get :index
      assigns(:selected_tags).should be_blank
      assigns(:files).should include(file_document)
    end
  end

  describe "GET index with tag" do
    it "assigns all files as @files" do
      tags = ['tag1']
      file_document = FactoryGirl.create(:file_document, :tags=>tags)
      get :index, {:tags=>tags}
      assigns(:selected_tags).should == tags
      assigns(:files).should include(file_document)
    end
  end
  
  describe "GET index with tag" do
    it "assigns all files as @files" do
      file_document = FactoryGirl.create(:file_document, :tags=>['tag2'])
      get :index, {:tags=>['tag1']}
      assigns(:selected_tags).should == ['tag1']
      assigns(:files).should_not include(file_document)
    end
  end

  describe "GET index with multiple tags" do
    it "assigns all files as @files" do
      tags = ['tag1','tag2']
      file_document = FactoryGirl.create(:file_document, :tags=>tags)
      get :index, {:tags=>tags}
      assigns(:selected_tags).should == tags
      assigns(:files).should include(file_document)
    end
  end
  
  describe "GET show" do
    it "assigns given files as @file" do
      file_document = FactoryGirl.create(:file_document) 
      get :show, {:id=>file_document.id}
      assigns(:file).should==file_document
    end
  end

  describe "POST create" do
    it "creates a new @file" do
      tags = ['tag1']
      post :create, :tags=>tags, :document=>fixture_file_upload(Rails.root.join("spec/files/test_document.txt"),'text/plain')
      should redirect_to files_path(:tags=>tags)
    end
  end

  describe "DELETE destroy" do
    it "removes a file" do
      file_document = FactoryGirl.create(:file_document)
      delete :destroy, {:id=>file_document.id}
      FileDocument.all.should_not include(file_document)
    end
  end

end
