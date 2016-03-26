require_relative '../test_helper.rb'

class UserCanUpdateARobotTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_update_a_robot
    create_robots
    assert robot_manager.all.any? { |robot| robot.name == "Esther 1"}

    visit '/robots'
    assert_equal'/robots', current_path

    within("#robot-1") do
      click_link("Update")
    end

    assert_equal '/robots/1/update', current_path

    within("#update-1") do
      fill_in("robot[name]", with: "Esther")
      fill_in("robot[city]", with: "Gotham")
      click_button("Ready for change!")
      assert_equal '/robots/1', current_path
    end

    assert page.has_content?("Esther")

    within("#robot-table") do
      assert page.has_content?("Gotham")
    end

    assert robot_manager.all.any? { |robot| robot.name == "Esther" && robot.city == "Gotham"}
  end
end
