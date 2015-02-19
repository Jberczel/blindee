# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# reset development database (answers and invites destroyed w/ votes)
User.destroy_all
Vote.destroy_all

##############################
# Create Users
##############################
u = User.new(email: "jamie@email.com", password: "watermellon")
u.skip_confirmation!
u.save!

9.times do |i|
  email = "#{i}_#{Faker::Internet.free_email}"
  u = User.new( email: email, password: "watermellon")
  u.skip_confirmation!
  u.save!
end

users = User.all

##############################
# Create Votes
##############################
create_votes = -> (args={}) do
  args.fetch(:count, 10).times do |question|
    Vote.create!( question: Faker::Company.catch_phrase,
                  choices:  [].tap { |ary| (rand(4)+1).times { ary << Faker::Hacker.noun }}.join("\n"),
                  creator:  users.sample,
                  public_vote: args.fetch(:public_vote, false),
                  created_at: Faker::Time.between(90.days.ago, Time.now))
    end
end

create_votes.call(count: 7, public_vote:true)
votes = Vote.all.where(public_vote: true)

##############################
# Create Answers
##############################
users.each do |user|
  rand(5).times do |i|
    vote   = votes.sample
    answer = vote.get_choices.sample
    vote.answers.create!(answer: answer,
                         comment: Faker::Hacker.say_something_smart,
                         user: user)
  end
end
