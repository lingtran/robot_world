require_relative '../test_helper.rb'

class UserCanSeeAllRobotsTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_see_all_robots
    create_robots
    assert robot_manager.all.any? { |robot| robot.id == 2 }

    visit '/'
    assert '/', current_path

    click_link("Robots")
    assert '/robots', current_path

    assert page.has_content?("Meet Your Robots")

    within("#all-table") do
      assert page.has_content?("ID")
      assert page.has_content?("Name")
      assert page.has_content?("Esther 1")
      assert page.has_content?("Esther 2")
    end
  end
end
