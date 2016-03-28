require 'sequel'

["test", "development"].each do |env|
    database = Sequel.sqlite('db/robot_manager_#{env}.sqlite3')
    database.create_table :robots do
      primary_key :id
      String :avatar
      String :name
      String :city
      String :state
      String :birthdate
      String :date_hired
      String :department
    end
end

database.create_table :robots do
  primary_key :id
  String :avatar
  String :name
  String :city
  String :state
  String :birthdate
  String :date_hired
  String :department
end
