class RobotManager
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def dataset
    database.from(:robots)
  end

  def create(robot)
    dataset.insert(robot)
    # database.transaction do
    #   database['robots'] ||= []
    #   database['total'] ||= 0
    #   database['total'] += 1
    #   database['robots'] << { "id" => database['total'],
    #                           "avatar" => robot[:avatar],
    #                           "name" => robot[:name],
    #                           "city" => robot[:city],
    #                           "state" => robot[:state],
    #                           "birthdate" => robot[:birthdate],
    #                           "date_hired" => robot[:date_hired],
    #                           "department" => robot[:department]
    #                         }
    # end
  end

  # def raw_robots
  #   database.from(:robots)
  # end

  def all
    dataset.to_a.map { |data| Robot.new(data) }
  end

  # def raw_robot(id)
  #   raw_robots.where(:id => id)
  # end

  def find(id)
    Robot.new(dataset.where(:id => id).to_a.first)
  end

  def update(id, robot)
    dataset.where(:id => id).update(robot)

    # database.transaction do
    #   target = database['robots'].find { |robot| robot['id'] == id }
    #   target['avatar'] = robot[:avatar]
    #   target['name'] = robot[:name]
    #   target['city'] = robot[:city]
    #   target['state'] = robot[:state]
    #   target['birthdate'] = robot[:birthdate]
    #   target['date_hired'] = robot[:date_hired]
    #   target['department'] = robot[:department]
    # end
  end

  def delete(id)
    dataset.where(:id => id).delete
    # database.transaction do
    #   database['robots'].delete_if { |robot| robot['id'] == id }
    #   database['total'] -= 1
    # end
  end

  def delete_all
    dataset.delete
  end

  def robot_count
    all.size
  end

  def average_age
    all.reduce(0) do |sum, robot|
      sum += robot.age
    end/robot_count
  end

  def number_of_robots_hired_annually
    annual_hires_count = Hash.new
    dataset.map(:date_hired).group_by { |date| date }.map { |date, events| annual_hires_count[date] = events.count}
    annual_hires_count
  end

  def number_of_robots_per_department
    per_department_count = Hash.new
    dataset.map(:department).group_by { |department| department }.map { |department, heads| per_department_count[department] = heads.count }
    per_department_count
  end

  def number_of_robots_per_city
    per_city_count = Hash.new
    dataset.map(:city).group_by { |city| city }.map { |city, heads| per_city_count[city] = heads.count }
    per_city_count
  end

  def number_of_robots_per_state
    per_state_count = Hash.new
    dataset.map(:state).group_by { |state| state }.map { |state, heads| per_state_count[state] = heads.count }
    per_state_count
  end
end
