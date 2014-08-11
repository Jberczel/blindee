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

User.create!(email: "jamie@email.com", password: "watermellon")
User.create!(email: "liam@email.com", password: "watermellon")
User.create!(email: "dad@email.com", password: "watermellon")
User.create!(email: "mom@email.com", password: "watermellon")

Vote.create!(question: "Favorite fruit", choices: "apple\r\nbanana\r\norange", creator_id:1)
Vote.create!(question: "Favorite drink", choices: "soda\r\njuice\r\nwater", creator_id:2)

Invite.create!(email: 'liam@email.com', sender_id: 1, recipient_id: 2, vote_id: 1)
Invite.create!(email: 'dad@email.com', sender_id: 1, recipient_id: 3, vote_id: 1)
Invite.create!(email: 'mom@email.com', sender_id: 1, recipient_id: 4, vote_id: 1)



