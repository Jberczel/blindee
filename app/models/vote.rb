class Vote < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  belongs_to :creator, :class_name => "User"

  has_many :invites, :dependent => :destroy
  has_many :answers, :dependent => :destroy

  validates :question, presence: true, length: { maximum: 140 }
  validates :choices, presence: true, length: { maximum: 140 }
  validates :creator_id, presence: true

  before_save :add_quote

  MAX_CHOICES = 5

  def get_choices
    choices.split(/\r?\n/).select { |c| c =~ /\S+/ }.take(MAX_CHOICES)
  end

  private
    # add quesiton mark to question if user forgets
    def add_quote
      self.question << '?' unless self.question.ends_with?('?')
    end
end
