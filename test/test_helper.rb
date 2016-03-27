ENV['RACK_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'tilt/erb'
require 'capybara/dsl'

module TestHelpers
  def teardown
    robot_manager.delete_all
    super
  end

  def robot_manager
    database = Sequel.sqlite('db/robot_manager_test.sqlite3')
    @robot_manager ||= RobotManager.new(database)
  end

  def create_robots(num = 2)
    num.times do |i|
      robot_manager.create({
        :id => "#{i+1}",
        :name => "Esther #{i+1}",
        :avatar => "www.avatar.fake #{i+1}",
        :city => "Gotham #{i+1}",
        :state => "Mayhem #{i+1}",
        :birthdate => "04/30/1987",
        :date_hired => "03/25/2015",
        :department => "Justice #{i+1}"
      })
    end
  end

Capybara.app = RobotWorldApp

  class FeatureTest < Minitest::Test
    include Capybara::DSL
  end
end
