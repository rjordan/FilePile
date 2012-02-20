require 'spec_helper'

describe TagsController do

  describe "POST create" do
    it "adds a tag to a file" do
      tag = 'tag1'
      @file = FactoryGirl.create(:file_document, :tags=>[])
      FileDocument.stub(:find).and_return(@file)
      @file.tags.should_receive(:<<).with(tag)
      @file.should_receive(:save)
      put :update, :file_id=>@file.id, :id=>tag
      should redirect_to file_path(@file)
    end
  end

  describe "DELETE destroy" do
    it "removes a tag" do
      tag = 'tag1'
      @file = FactoryGirl.create(:file_document, :tags=>[tag])
      @file.tags.should_receive(:delete).with(tag)
      @file.should_receive(:save)
      delete :destroy, {:file_id=>@file.id, :id=>tag}
      should redirect_to file_path(@file)
    end
  end

end
