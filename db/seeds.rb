# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Status::DEFAULT_STATUSES.each do |params_status|
  Status.create(name: params_status[:name])
end

departments = %w(Department1 Department2 Department3 Department4 Department5)

departments.each do |dep|
  Department.create(name: dep)
end
