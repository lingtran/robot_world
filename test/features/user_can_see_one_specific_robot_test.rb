require_relative '../test_helper.rb'

class UserCanSeeOneSpecificRobotTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_see_one_specific_robot
    create_robots
    assert robot_manager.all.any? { |robot| robot.id == 2 }

    visit '/'
    assert '/', current_path

    click_link("Robots")
    assert '/robots', current_path

    within("#robot-1") do
      assert page.has_content?("Esther 1")
    end

    click_link("Esther 1")
    assert '/robots/1', current_path

    assert page.has_content?("Esther 1")
    refute page.has_content?("Esther 2")

    within("#robot-table") do
      assert page.has_content?("President's Day 1")
      assert page.has_content?("Mayhem 1")
    end

  end
end
