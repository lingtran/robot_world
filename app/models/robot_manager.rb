class RobotManager
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    database.transaction do
      database['robots'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database['robots'] << { "id" => database['total'],
                              "avatar" => robot[:avatar],
                              "name" => robot[:name],
                              "city" => robot[:city],
                              "state" => robot[:state],
                              "birthdate" => robot[:birthdate],
                              "date_hired" => robot[:date_hired],
                              "department" => robot[:department]
                            }
    end
  end

  def raw_robots
    database.transaction do
      database['robots'] || []
    end
  end

  def all
    raw_robots.map { |data| Robot.new(data) }
  end

  def raw_robot(id)
    raw_robots.find { |robot| robot["id"] == id }
  end

  def find(id)
    Robot.new(raw_robot(id))
  end

  def update(id, robot)
    database.transaction do
      target = database['robots'].find { |robot| robot['id'] == id }
      target['avatar'] = robot[:avatar]
      target['name'] = robot[:name]
      target['city'] = robot[:city]
      target['state'] = robot[:state]
      target['birthdate'] = robot[:birthdate]
      target['date_hired'] = robot[:date_hired]
      target['department'] = robot[:department]
    end
  end

  def delete(id)
    database.transaction do
      database['robots'].delete_if { |robot| robot['id'] == id }
      database['total'] -= 1
    end
  end

  def delete_all
    database.from(:robots).delete
  end

  def robot_count
    all.size
  end
end
