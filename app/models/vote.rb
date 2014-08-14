class Vote < ActiveRecord::Base
  has_many :answers, :dependent => :destroy
  has_many :voters, :through => :answers, :source => :user

  belongs_to :creator, :class_name => "User"

  has_many :invites, :dependent => :destroy


  def get_choices
    choices.split(/\r?\n/)
  end

end
