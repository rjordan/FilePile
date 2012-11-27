require 'spec_helper'

describe 'files/show.html.erb' do
  include Capybara::DSL

  before do
    @file_doc = FactoryGirl.create(:file_document, :tags=>['tag1'])
    FileDocument.stub(:all_tags).and_return(['tag1', 'tag2'])
    visit file_path(@file_doc)
  end

  it "should have a preview-area div" do
    page.should have_selector('div#preview-area')
  end

  it "should have a selected-tags div" do
    page.should have_selector('div#selected-tags')
    page.should have_selector('div#selected-tags ul.breadcrumb')
    page.should have_selector('div#selected-tags ul.breadcrumb li', :text=>'tag1')
  end

  it "should have a back button" do
    page.should have_link('Back', :href=>files_path)
  end

end
