require_relative '../test_helper.rb'

class RobotManagerTest < Minitest::Test
  include TestHelpers

  def test_can_create_a_robot
    # skip

    create_robots

    robot = robot_manager.find(1)

    assert_equal "Esther 1", robot.name
    assert_equal "www.avatar.fake 1", robot.avatar
    assert_equal "Gotham 1", robot.city
    assert_equal "Mayhem 1", robot.state
    assert_equal "President's Day 1", robot.birthdate
    assert_equal "03/23/2016 1", robot.date_hired
    assert_equal "Justice 1", robot.department
  end

  def test_can_create_multiple_robots
    # skip

    create_robots
    all = robot_manager.all

    assert_equal 2, all.count
    assert all.is_a?(Array)
    assert_equal Robot, all.first.class
    assert_equal ["Esther 1", "Esther 2"], robot_manager.all.map { |robot| robot.name}
    assert_equal "Esther 2", robot_manager.all.last.name
  end

  def test_can_find_robot_with_id
    # skip
    
    create_robots

    robot = robot_manager.find(1)
    assert_equal 1, robot.id
    assert_equal "Esther 1", robot.name

    robot_two = robot_manager.find(2)
    assert_equal 2, robot_two.id
    assert_equal "Esther 2", robot_two.name

    assert_equal nil, robot_manager.all[2]
  end

  def test_can_update_a_robot
    # skip

    create_robots

    robot = robot_manager.find(1)
    assert_equal 1, robot.id
    assert_equal "Gotham 1", robot.city
    robot_manager.update(1, {:city=>"Happy Harbor"})
    robot = robot_manager.find(1)
    assert_equal "Happy Harbor", robot.city
  end

  def test_can_delete_a_robot
    # skip

    create_robots

    assert_equal 2, robot_manager.all.count

    assert robot_manager.all.any? { |robot| robot.name == "Esther 2" }
    robot_manager.delete(2)

    assert_equal 1, robot_manager.all.count
    refute robot_manager.all.any? { |robot| robot.name == "Esther 2"}
  end

  def test_can_delete_all_robots
    # skip

    create_robots

    assert_equal 2, robot_manager.all.count
    assert_equal ["Esther 1", "Esther 2"], robot_manager.all.map { |robot| robot.name }

    robot_manager.delete_all
    assert_equal 0, robot_manager.all.count
    assert_equal [], robot_manager.all.map { |robot| robot.name }
  end

  def test_can_calculate_average_age_of_robots
    # skip

    create_robots

    assert_equal 2, robot_manager.robot_count
    assert_equal ["04/30/1987", "04/30/1987"], robot_manager.all.map { |robot| robot.birthdate }

    robot_one = robot_manager.find(1)
    robot_two = robot_manager.find(2)

    assert_equal 29, robot_one.age
    assert_equal 29, robot_two.age
    assert_equal 29, robot_manager.average_age
  end

  def test_can_calculate_number_of_robots_hired_annually
    # skip

    create_robots

    assert_equal 2, robot_manager.robot_count
    assert_equal ["03/25/2015", "03/25/2015"], robot_manager.all.map { |robot| robot.date_hired }

    assert robot_manager.number_of_robots_hired_annually.is_a?(Hash)
    assert_equal "03/25/2015", robot_manager.number_of_robots_hired_annually.keys.last
    assert_equal 2, robot_manager.number_of_robots_hired_annually.values.last
  end

  def test_can_calculate_number_of_robots_in_each_department
    # skip

    create_robots

    assert_equal 2, robot_manager.robot_count
    assert_equal ["Justice 1", "Justice 2"], robot_manager.all.map { |robot| robot.department }

    assert robot_manager.number_of_robots_per_department.is_a?(Hash)
    assert_equal "Justice 1", robot_manager.number_of_robots_per_department.keys.first
    assert_equal 1, robot_manager.number_of_robots_per_department.values.first
  end

  def test_can_calculate_number_of_robots_in_each_city
    # skip

    create_robots

    assert_equal 2, robot_manager.robot_count
    assert_equal ["Gotham 1", "Gotham 2"], robot_manager.all.map { |robot| robot.city }

    assert robot_manager.number_of_robots_per_city.is_a?(Hash)
    assert_equal "Gotham 1", robot_manager.number_of_robots_per_city.keys.first
    assert_equal 1, robot_manager.number_of_robots_per_city.values.first
    assert_equal "Gotham 2", robot_manager.number_of_robots_per_city.keys.last
    assert_equal 1, robot_manager.number_of_robots_per_city.values.last
  end

  def test_can_calculate_number_of_robots_in_each_state
    # skip

    create_robots

    assert_equal 2, robot_manager.robot_count
    assert_equal ["Mayhem 1", "Mayhem 2"], robot_manager.all.map { |robot| robot.state }

    assert robot_manager.number_of_robots_per_state.is_a?(Hash)
    assert_equal "Mayhem 1", robot_manager.number_of_robots_per_state.keys.first
    assert_equal 1, robot_manager.number_of_robots_per_state.values.first
    assert_equal "Mayhem 2", robot_manager.number_of_robots_per_state.keys.last
    assert_equal 1, robot_manager.number_of_robots_per_state.values.last
  end
end
