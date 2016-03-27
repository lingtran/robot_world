require_relative '../test_helper.rb'

class RobotTest < Minitest::Test
  include TestHelpers

  def test_assigns_attributes_correctly
    create_robots(1)
    robot = robot_manager.find(1)

    assert_equal 1, robot.id
    refute_equal 10, robot.id
    assert_equal "Esther 1", robot.name
    assert_equal "www.avatar.fake 1", robot.avatar
    assert_equal "Gotham 1", robot.city
    assert_equal "Mayhem 1", robot.state
    assert_equal "04/30/1987", robot.birthdate
    assert_equal "03/25/2015", robot.date_hired
    assert_equal "Justice 1", robot.department
  end

  def test_can_calculate_robot_age
    create_robots

    assert robot_manager.all.any? { |robot| robot.id == 1 }
    robot = robot_manager.find(1)
    assert_equal "Esther 1", robot.name
    assert_equal "04/30/1987", robot.birthdate
    assert_equal 29, robot.age
  end

end
