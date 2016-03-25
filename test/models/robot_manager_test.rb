require_relative '../test_helper.rb'

class RobotManagerTest < Minitest::Test
  include TestHelpers

  def test_can_create_a_robot
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
    create_robots

    assert_equal 2, robot_manager.all.count
    assert_equal ["Esther 1", "Esther 2"], robot_manager.all.map { |robot| robot.name }

    robot_manager.delete_all
    assert_equal 0, robot_manager.all.count
    assert_equal [], robot_manager.all.map { |robot| robot.name }
  end
end
