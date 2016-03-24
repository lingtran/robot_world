require_relative '../test_helper.rb'

class RobotTest < Minitest::Test
  include TestHelpers

  def test_assigns_attributes_correctly
    robot = Robot.new( { :id => 1,
                        :name => "Esther",
                        :avatar => "www.avatar.fake",
                        :city => "Gotham",
                        :state => "Mayhem",
                        :birthdate => "President's Day",
                        :date_hired => "03/23/2016",
                        :department => "Justice"
                      })

    assert_equal 1, robot.id
    refute_equal 10, robot.id
    assert_equal "Esther", robot.name
    assert_equal "www.avatar.fake", robot.avatar
    assert_equal "Gotham", robot.city
    assert_equal "Mayhem", robot.state
    assert_equal "President's Day", robot.birthdate
    assert_equal "Justice", robot.department
  end
end
