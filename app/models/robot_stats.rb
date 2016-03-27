class RobotStats
  def initialize
  end

  def average_age(ages, size)
    robots.reduce(0) do |sum, age|
      sum += age
    end/size
  end
end

# average robot age
# a breakdown of how many robots were hired each year
# number of robots in each department
# number of robots in each city
# number of robots in each state
