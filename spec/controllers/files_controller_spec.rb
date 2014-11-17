require 'spec_helper'

describe FilesController do

  let(:file) { FactoryGirl.create(:file_document) }
  let(:tag) { 'tag1' }

  before(:each) do
    FileDocument.stub(:find).and_return(file)
  end

  describe 'GET index' do
    it 'assigns all files as @files' do
      get :index
      assigns(:selected_tags).should be_blank
      assigns(:files).should include(file)
    end
  end

  describe 'GET index with tag 1' do
    it 'assigns all files as @files' do
      tags = [tag]
      file = FactoryGirl.create(:file_document, :tags=>tags)
      get :index, {:tags=>tags}
      assigns(:selected_tags).should == tags
      assigns(:files).should include(file)
    end
  end

  describe 'GET index with tag 2' do
    it 'assigns all files as @files' do
      file = FactoryGirl.create(:file_document, :tags=>['tag2'])
      get :index, {:tags=>['tag1']}
      assigns(:selected_tags).should == ['tag1']
      assigns(:files).should_not include(file)
    end
  end

  describe 'GET index with multiple tags' do
    it 'assigns all files as @files' do
      tags = %w(tag1 tag2)
      file = FactoryGirl.create(:file_document, :tags=>tags)
      get :index, {:tags=>tags}
      assigns(:selected_tags).should == tags
      assigns(:files).should include(file)
    end
  end

  describe 'GET show' do
    it 'assigns given files as @file' do
      get :show, {:id=>file.id}
      assigns(:file).should==file
    end
  end

  describe 'GET index with fingerprint' do
    it 'should not find a missing file' do
      get :index, {:fingerprint=>Digest::SHA512.hexdigest('test')}
      should respond_with(:not_found)
    end
    it 'should find a file that already exists' do
      file = FactoryGirl.create(:file_document, :tags=>['tag2'], :fingerprint=>Digest::SHA512.hexdigest('test'))
      get :index, {:fingerprint=>file.fingerprint}
      should respond_with(:found)
    end
  end

  describe 'POST create' do
    it 'creates a new @file' do
      tags = %w( tag1 )
      post :create,
           :tags=>tags,
           :document=>fixture_file_upload(Rails.root.join('spec/files/test_document.txt'), 'text/plain')
      should redirect_to files_path(:tags=>tags)
    end
  end

  describe 'DELETE destroy' do
    it 'removes a file' do
      file.should_receive(:destroy)
      delete :destroy, {:id=>file.id}
    end
  end

  describe 'GET to get_data' do
    it 'should send the file data' do
      file.stub(:file).and_return(stub(data: [], content_type: 'audio/mp3'))
      FileDocument.should_receive(:find).with('1').and_return(file)
      get :get_data, :id=>1, :filename=>'123.mp3'
      should respond_with(200)
      response.content_type.should eq('audio/mp3')
    end
  end

end
