require 'spec_helper'

describe TagsController do

  let(:file) { FactoryGirl.create(:file_document) }
  let(:tag) { 'tag1' }

  before(:each) do
    FileDocument.stub(:find).and_return(file)
  end

  describe "POST create" do
    it "add tags to a file" do
      file.stub(:tags).and_return([])
      file.tags.should_not include(tag)
      post :create, :file_id=>file.id, :tags=>"tag2, #{tag}"
      file.tags.should include(tag)
      should redirect_to file_path(file)
    end
  end

  describe "PUT update" do
    it "adds a tag to a file" do
      file.stub(:tags).and_return([])
      file.tags.should_not include(tag)
      put :update, :file_id=>file.id, :id=>tag
      file.tags.should include(tag)
      should redirect_to file_path(file)
    end
  end

  describe "DELETE destroy" do
    it "removes a tag" do
      file.stub(:tags).and_return([tag])
      file.tags.should include(tag)
      delete :destroy, {:file_id=>file.id, :id=>tag}
      file.tags.should_not include(tag)
      should redirect_to file_path(file)
    end
  end

end
