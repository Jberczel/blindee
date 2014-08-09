class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :created_votes, :foreign_key => "creator_id", :class_name => "Vote"
  # has_many :casted_votes, :through => :invites, :source => :vote
  has_many :answers

end
