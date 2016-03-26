require_relative '../test_helper.rb'

class UserCanDeleteARobotTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_delete_a_robot
    create_robots
    assert robot_manager.all.any? { |robot| robot.id == 1 }

    visit '/robots'
    assert_equal '/robots', current_path

    within("#robot-1") do
      assert page.has_content?("Esther 1")
    end

    within("form#delete-1") do
      find('input[type="submit"]').click
    end

    refute robot_manager.all.any? { |robot| robot.id == 1 }
    refute page.has_content?("Esther 1")
  end

end
