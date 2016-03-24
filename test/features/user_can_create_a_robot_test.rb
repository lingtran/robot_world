require_relative '../test_helper.rb'

class UserCanCreateARobotTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_create_a_new_robot
    visit '/'
    assert_equal '/', current_path

    click_link("New Robot")
    assert_equal '/robots/create', current_path
    fill_in("robot[avatar]", with: "www.fake.pic")
    fill_in("robot[name]", with: "Esther")
    fill_in("robot[city]", with: "Broncos City")
    fill_in("robot[state]", with: "Wild West State")
    fill_in("robot[birthdate]", with: "Independence Day")
    fill_in("robot[date_hired]", with: "Yesterday")
    fill_in("robot[department]", with: "Awesome Possum")
    click_button("Submit")
    assert_equal '/robots', current_path

    assert_equal 1, robot_manager.all.count
    robot = robot_manager.find(1)
    assert_equal "Awesome Possum", robot.department

    within("#all-table") do
      assert page.has_content?("Make some change!")
      assert page.has_content?("Perhaps it's time for farewell")
      assert page.has_content?("Esther")
    end
  end
end
