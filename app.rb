require('sinatra')	
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require("pg")
also_reload('lib/**/*.rb')
	
DB = PG.connect({:dbname => "volunteer_tracker"})

get('/')do
  @projects = Projects.all
  erb(:projects)
end

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

post('/projects') do
  name = params[:project_title]
  if name.length()>0
    Project = Project.new({:name => name,:id => nil})
    Project.save()
    @projects = Project.all
    erb(:search_results)
  else
    "Not a valid entry. Try again."
  end
end

get('/projects/new') do
  erb(:new_project)
end

patch('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  erb(:projects)
end

patch('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.update(params[:name])
  @projects = Project.all
  erb(:projects)
end

delete('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @Project.delete()
  @projects = Project.all
  erb(:projects)
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i())
  erb(:edit_project)
end

post('/projects/:id/volunteers') do
  @project = Project.find(params[:id].to_i())
  volunteer = Volunteer.new({:name => params[:volunteer_name], :project_id => @project.id,:id => nil})
  if volunteer.name.length() > 0
    volunteer.save()
    erb(:project)
  else
    "Not a valid entry. Try again."
  end
end

get('/projects/:id/volunteers/:volunteer_id') do
  @volunteer = Volunteer.find(params[:volunteer_id].to_i())
  erb(:volunteer)
end

patch('/projects/:id/volunteers/:voluteer_id') do
  @projects = Project.find(params[:id].to_i())
  volunteer = Volunteer.find(params[:volunteer_id].to_i())
  volunteer.update(params[:name], @project.id)
  erb(:project)
end

delete('/projects/:id/volunteers/:volunteer_id') do
  volunteer = volunteer.find(params[:volunteer_id].to_i())
  volunteer.delete
  @Project = Project.find(params[:id].to_i())
  erb(:Project)
end

get('/volunteers') do
  @volunteers = Volunteer.all
  erb(:volunteers)
end


