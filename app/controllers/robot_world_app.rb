class RobotWorldApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true
  set :server, 'webrick'

  get '/' do
    @robots = robot_manager
    if @robots.robot_count != 0
      average_age = @robots.average_age
      annual_hires_count = @robots.number_of_robots_hired_annually
      per_department_count = @robots.number_of_robots_per_department
      per_city_count = @robots.number_of_robots_per_city
      per_state_count = @robots.number_of_robots_per_state
    else
      message = "Stats are pending"
    end
    erb :dashboard, :locals => { :average_age => average_age, :annual_hires_count => annual_hires_count, :per_department_count => per_department_count, :per_city_count => per_city_count, :per_state_count => per_state_count, :message => message }
  end

  get '/robots' do
    @robots = robot_manager.all
    erb :index
  end

  get '/robots/create' do
    erb :create
  end

  post '/robots' do
    robot_manager.create(params[:robot])
    redirect '/robots'
  end

  get '/robots/:id' do |id|
    @robot = robot_manager.find(id.to_i)
    erb :robot
  end

  get '/robots/:id/update' do |id|
    @robot = robot_manager.find(id.to_i)
    erb :update
  end

  put '/robots/:id' do |id|
    robot_manager.update(id.to_i, params[:robot])
    redirect "/robots/#{id}"
  end

  delete '/robots/:id' do |id|
    robot_manager.delete(id.to_i)
    redirect '/robots'
  end

  not_found do
    erb :error
  end

  def robot_manager
    if ENV["RACK_ENV"] == "test"
      database = Sequel.sqlite('db/robot_manager_test.sqlite3')
    else
      database = Sequel.sqlite('db/robot_manager_development.sqlite3')
    end
    @robot_manager ||= RobotManager.new(database)
  end
end
