class Vote < ActiveRecord::Base
  has_many :answers, :dependent => :destroy
  has_many :voters, :through => :answers, :source => :user

  belongs_to :creator, :class_name => "User"

  has_many :invites, :dependent => :destroy

  before_save :add_quote


  def get_choices
    choices.split(/\r?\n/)
  end

  private

  def add_quote
    self.question << '?' unless self.question.ends_with?('?')
  end

end
