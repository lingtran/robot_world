class Robot
  attr_reader :id,
              :name,
              :city,
              :state,
              :avatar,
              :birthdate,
              :date_hired,
              :department

  def initialize(data)
    @id = data[:id]
    @avatar = data[:avatar]
    @name = data[:name]
    @city = data[:city]
    @state = data[:state]
    @birthdate = data[:birthdate]
    @date_hired = data[:date_hired]
    @department = data[:department]
  end
end
