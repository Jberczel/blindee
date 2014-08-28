class Vote < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"

  has_many :invites, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  # has_many :voters, :through => :answers, :source => :user

  before_save :add_quote

  def get_choices
    choices.split(/\r?\n/).select { |c| c =~ /\S+/ }
  end

  def get_participation_rate
    answers.count.to_f / (invites.count + 1)  # add creator to count
  end

  def finished?
    get_participation_rate > 0.75
  end

  private
    def add_quote
      self.question << '?' unless self.question.ends_with?('?')
    end
end
