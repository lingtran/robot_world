require 'sequel'

database = Sequel.sqlite('db/robot_manager_development.sqlite3')

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
