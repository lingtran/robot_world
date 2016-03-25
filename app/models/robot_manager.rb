class RobotManager
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    database.from(:robots).insert(robot)
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
  #
  # end

  def all
    database.from(:robots).to_a.map { |data| Robot.new(data) }
  end

  # def raw_robot(id)
  #   raw_robots.where(:id => id)
  # end

  def find(id)
    Robot.new(database.from(:robots).where(:id => id).to_a.first)
  end

  def update(id, robot)
    database.from(:robots).where(:id => id).update(robot)

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
    database.from(:robots).where(:id => id).delete
    # database.transaction do
    #   database['robots'].delete_if { |robot| robot['id'] == id }
    #   database['total'] -= 1
    # end
  end

  def delete_all
    database.from(:robots).delete
  end

  def robot_count
    all.size
  end
end
