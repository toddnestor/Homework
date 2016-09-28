# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

house = House.create(address: '6399 Christie Ave')

names = ['Todd', 'Ziqin', 'Nikolai']

names.each do |name|
  Person.create(name: name, house_id: house.id)
end
