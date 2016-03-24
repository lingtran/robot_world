class RobotStats
  def initialize
  end

  def average_age(ages, size)
    robots.reduce(0) do |sum, age|
      sum += age
    end/size
  end
end
