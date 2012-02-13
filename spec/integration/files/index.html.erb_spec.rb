require 'spec_helper'

describe "files/index.html.erb" do
  it "should have a tags div" do
    visit('/')
    page.should have_selector('div.selected-tags')
  end

  it "should have breadcrumbs in the selected-tags" do
    visit('/')
    within('div.selected-tags') do
     page.should have_selector('ul.breadcrumb')
    end
  end
  
  it "should have a clear button in the selected-tags" do
    visit('/')
    within('div.selected-tags ul.breadcrumb') do
     page.should have_selector('li a.btn.btn-danger')
    end
  end
end
