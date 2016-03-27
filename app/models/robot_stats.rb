class RobotStats
  attr_reader :robot_manager, :annual_hires_count, :per_department_count, :per_city_count, :per_state_count

  def initialize(robot_manager)
    @robot_manager = robot_manager
    @annual_hires_count = Hash.new
    @per_department_count = Hash.new
    @per_city_count = Hash.new
    @per_state_count = Hash.new
  end

  def average_age
    robot_manager.all.reduce(0) do |sum, robot|
      sum += robot.age
    end/robot_manager.robot_count
  end

  def annual_hires
    robot_manager.dataset.map(:date_hired).group_by { |date| date }.map { |date, events| annual_hires_count[date] = events.count}
    annual_hires_count
  end

  def per_department
    robot_manager.dataset.map(:department).group_by { |department| department }.map { |department, heads| per_department_count[department] = heads.count }
    per_department_count
  end

  def per_city
    robot_manager.dataset.map(:city).group_by { |city| city }.map { |city, heads| per_city_count[city] = heads.count }
    per_city_count
  end

  def per_state
    robot_manager.dataset.map(:state).group_by { |state| state }.map { |state, heads| per_state_count[state] = heads.count }
    per_state_count
  end
end
