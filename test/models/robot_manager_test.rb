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

  def test_can_create_raw_robots
    create_robots

    assert_equal [{"id"=>1, "avatar"=>"www.avatar.fake 1", "name"=>"Esther 1", "city"=>"Gotham 1", "state"=>"Mayhem 1", "birthdate"=>"President's Day 1", "date_hired"=>"03/23/2016 1", "department"=>"Justice 1"}, {"id"=>2, "avatar"=>"www.avatar.fake 2", "name"=>"Esther 2", "city"=>"Gotham 2", "state"=>"Mayhem 2", "birthdate"=>"President's Day 2", "date_hired"=>"03/23/2016 2", "department"=>"Justice 2"}], robot_manager.raw_robots
  end

  def test_can_access_all_robots
    create_robots
    all = robot_manager.all
    assert all.is_a?(Array)
    assert 2, all.length
    assert_equal Robot, all.first.class
    assert_equal ["Esther 1", "Esther 2"], all.map { |robot| robot.name }
  end

  def test_can_find_robot_with_id
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
    create_robots

    robot = robot_manager.find(1)
    assert_equal 1, robot.id
    assert_equal "Gotham 1", robot.city

    robot_manager.update(1, {:city=>"Happy Harbor"})
    robot = robot_manager.find(1)
    assert_equal "Happy Harbor", robot.city
  end

  def test_can_delete_a_robot
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
