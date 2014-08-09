# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Vote.destroy_all
Invite.destroy_all

User.create!(email: "jeb@email.com", password: "watermellon")
User.create!(email: "jane@email.com", password: "watermellon")
User.create!(email: "jimbo@email.com", password: "watermellon")

