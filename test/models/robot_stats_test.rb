require_relative '../test_helper.rb'

class RobotStatsTest < Minitest::Test
  include TestHelpers

  def test_robot_manager_successfully_passes_to_robot_stats
    robot_stats = initiate_robot_stats
    assert robot_stats.is_a?(RobotStats)
  end

  def test_can_calculate_average_age_of_robots
    create_robots
    robot_stats = initiate_robot_stats

    assert_equal 2, robot_manager.robot_count
    assert_equal ["04/30/1987", "04/30/1987"], robot_manager.all.map { |robot| robot.birthdate }

    robot_one = robot_manager.find(1)
    robot_two = robot_manager.find(2)

    assert_equal 29, robot_one.age
    assert_equal 29, robot_two.age
    assert_equal 29, robot_stats.average_age
  end

  def test_can_calculate_number_of_robots_hired_annually
    create_robots
    robot_stats = initiate_robot_stats

    assert_equal 2, robot_manager.robot_count
    assert_equal ["03/25/2015", "03/25/2015"], robot_manager.all.map { |robot| robot.date_hired }

    robot_stats.annual_hires

    assert robot_stats.annual_hires_count.is_a?(Hash)
    assert_equal "03/25/2015", robot_stats.annual_hires_count.keys.last
    assert_equal 2, robot_stats.annual_hires_count.values.last
  end

  def test_can_calculate_number_of_robots_in_each_department
    create_robots
    robot_stats = initiate_robot_stats

    assert_equal 2, robot_manager.robot_count
    assert_equal ["Justice 1", "Justice 2"], robot_manager.all.map { |robot| robot.department }

    robot_stats.per_department

    assert robot_stats.per_department_count.is_a?(Hash)
    assert_equal "Justice 1", robot_stats.per_department_count.keys.first
    assert_equal 1, robot_stats.per_department_count.values.first
  end

  def test_can_calculate_number_of_robots_in_each_city
    create_robots
    robot_stats = initiate_robot_stats

    assert_equal 2, robot_manager.robot_count
    assert_equal ["Gotham 1", "Gotham 2"], robot_manager.all.map { |robot| robot.city }

    robot_stats.per_city

    assert robot_stats.per_city_count.is_a?(Hash)
    assert_equal "Gotham 1", robot_stats.per_city_count.keys.first
    assert_equal 1, robot_stats.per_city_count.values.first
    assert_equal "Gotham 2", robot_stats.per_city_count.keys.last
    assert_equal 1, robot_stats.per_city_count.values.last
  end

  def test_can_calculate_number_of_robots_in_each_state
    create_robots
    robot_stats = initiate_robot_stats

    assert_equal 2, robot_manager.robot_count
    assert_equal ["Mayhem 1", "Mayhem 2"], robot_manager.all.map { |robot| robot.state }

    robot_stats.per_state

    assert robot_stats.per_state_count.is_a?(Hash)
    assert_equal "Mayhem 1", robot_stats.per_state_count.keys.first
    assert_equal 1, robot_stats.per_state_count.values.first
    assert_equal "Mayhem 2", robot_stats.per_state_count.keys.last
    assert_equal 1, robot_stats.per_state_count.values.last
  end
end
