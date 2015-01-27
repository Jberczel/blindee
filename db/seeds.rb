# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


u = User.new(email: "jamie@email.com", password: "watermellon")
u.skip_confirmation!
u.save!

9.times do |i|
  email = "user_#{i}_#{Faker::Internet.free_email}"
  u = User.new( email: email, password: "watermellon")
  u.skip_confirmation!
  u.save!
end


def create_votes(args={})
  args.fetch(:count, 20).times do |question|
    Vote.create!( question: Faker::Lorem.sentence,
                  choices:  Faker::Lorem.words(2 + rand(2)).join("\n"),
                  creator_id: rand(10) + 1,
                  public_vote: args.fetch(:public_vote, false) )
    end
end

create_votes
create_votes(public_vote:true)

#Invite.create!(email: 'liam@email.com', sender_id: 1, recipient_id: 2, vote_id: 1)
#Invite.create!(email: 'dad@email.com', sender_id: 1, recipient_id: 3, vote_id: 1)
#Invite.create!(email: 'mom@email.com', sender_id: 1, recipient_id: 4, vote_id: 1)



