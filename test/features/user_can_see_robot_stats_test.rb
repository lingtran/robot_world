require_relative '../test_helper.rb'

class UserCanSeeRobotStatsTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_view_robot_stats
    create_robots
    robot_stats = initiate_robot_stats

    visit '/'
    assert_equal '/', current_path

    assert page.has_content?("Robots in this World")

    within("#stats-table") do
      assert page.has_content?("Average Age")
      assert page.has_content?("Number of Robots Hired Annually")
      assert page.has_content?("Number of Robots Per City")
      assert page.has_content?("Number of Robots Per State")
    end

  end
end
