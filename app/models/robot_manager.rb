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
  end

  def all
    dataset.to_a.map { |data| Robot.new(data) }
  end

  def find(id)
    Robot.new(dataset.where(:id => id).to_a.first)
  end

  def update(id, robot)
    dataset.where(:id => id).update(robot)
  end

  def delete(id)
    dataset.where(:id => id).delete
  end

  def delete_all
    dataset.delete
  end

  def robot_count
    all.size
  end

  def average_age
    RobotStats.new(self).average_age
  end

  def number_of_robots_hired_annually
    RobotStats.new(self).annual_hires
  end

  def number_of_robots_per_department
    RobotStats.new(self).per_department
  end

  def number_of_robots_per_city
    RobotStats.new(self).per_city
  end

  def number_of_robots_per_state
    RobotStats.new(self).per_state
  end
end
