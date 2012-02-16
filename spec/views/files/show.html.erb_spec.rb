require 'spec_helper'

describe 'files/show.html.erb' do
  include Capybara::DSL

  before do
    @file_doc = FactoryGirl.create(:file_document)
    visit file_path(@file_doc)
  end

  it "should have a preview-area div" do
    page.should have_selector('div#preview-area')
  end

  it "should have a selected-tags div" do
    page.should have_selector('div#selected-tags')
  end

  it "should have a available-tags div" do
    page.should have_selector('div#available-tags')
  end

  it "should have a back button" do
    page.should have_link('Back', :href=>files_path)
  end

  it "should have an edit button" do
    page.should have_link('Edit', :href=>edit_file_path(@file_doc))
  end
end
