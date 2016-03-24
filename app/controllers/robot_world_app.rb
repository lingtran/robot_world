class RobotWorldApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true
  set :server, 'webrick'

  get '/' do
    erb :dashboard
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