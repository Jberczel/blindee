class Vote < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  belongs_to :creator, :class_name => "User"

  has_many :invites, :dependent => :destroy
  has_many :answers, :dependent => :destroy

  validates :question, presence: true, length: { maximum: 140 }
  validates :choices, presence: true, length: { maximum: 140 }

  before_save :add_quote

  def get_choices
    choices.split(/\r?\n/).select { |c| c =~ /\S+/ }[0..4]
  end

  private
    # add quesiton mark to question if user forgets
    def add_quote
      self.question << '?' unless self.question.ends_with?('?')
    end
end
