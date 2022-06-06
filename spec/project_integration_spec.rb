require('capybara/rspec')
require('./app')
require('pry')
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_expectations, false)

describe 'the project creation path', {:type => :feature} do
  it 'takes the user to the homepage where they can create a project' do
    visit '/'
    fill_in('title', :with => 'Teaching kids to code')
    click_button('Create')
    expect(page).to have_content('Teaching kids to code')
  end
end


