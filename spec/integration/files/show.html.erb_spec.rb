require 'spec_helper'

describe "files/show.html.erb" do
  before(:each) do
    @file_doc = FactoryGirl.create(:file_document)
  end

  it "should have a preview-area div" do
    visit("/files/#{@file_doc.id}")
    page.should have_selector('div#preview-area')
  end

  it "should have a selected-tags div" do
    visit("/files/#{@file_doc.id}")
    page.should have_selector('div#selected-tags')
  end

  it "should have a available-tags div" do
    visit("/files/#{@file_doc.id}")
    page.should have_selector('div#available-tags')
  end

  it "should have a back button" do
    visit("/files/#{@file_doc.id}")
    page.should have_selector('a[href="/files"]')
  end

  it "should have an edit button" do
    visit("/files/#{@file_doc.id}")
    page.should have_selector("a[href=\"/files/#{@file_doc.id}/edit\"]")
  end

end
