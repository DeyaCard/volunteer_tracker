require('capybara/rspec')
require('./app')
require('pry')
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_expectations, false)

describe 'the project creation path', {:type => :feature} do
  it 'takes the user to the homepage where they can create a project' do
    visit '/'
    click_link('Add a new project')
    fill_in('title', :with => 'Teaching kids to code')
    click_button('Create')
    expect(page).to have_content('Teaching kids to code')
  end
end

describe 'the project update path', {:type => :feature} do
  it 'allows the user to change the name of a project' do
    test_project = Project.new({:title => 'Teaching kids to code', :id => nil})
    test_project.save
    visit '/'
    click_link('Teaching kids to code')
    click_link('Edit Project')
    fill_in('title', :with => 'Teaching Ruby to kids')
    click_button('Update')
    expect(page).to have_content('Teaching Ruby to kids')
  end
end

describe 'the project delete path', {:type => :feature} do
  it 'allows the user to delete a project' do
    test_project = Project.new({:title => 'Teaching kids to code', :id => nil})
    test_project.save
    id = test_project.id
    visit "/projects/#{id}/edit"
    click_button('Delete')
    visit'/'
    expect(page).not_to have_content('Teaching kids to code')
  end
end

describe 'the volunteer detail page path', {:type => :feature} do
  it 'shows a volunteer detail page' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    project_id = test_project.id.to_i
    test_volunteer = Volunteer.new({:name => 'Jasmine', :project_id => project_id, :id => nil})
    test_volunteer.save
    visit "/projects/#{project_id}"
    expect(page).to have_content('Jasmine')
  end
end
