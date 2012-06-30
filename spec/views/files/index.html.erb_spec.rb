require 'spec_helper'

describe 'files/index.html.erb' do
  include Capybara::DSL

  before do
    visit files_path
  end

  it "should have a tags div" do
    page.should have_selector('div#tags')
  end

end
