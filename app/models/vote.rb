class Vote < ActiveRecord::Base
  has_many :answers, :dependent => :destroy
  belongs_to :creator, :class_name => "User"

  has_many :invites, :dependent => :destroy

  def getChoices
    choices.split(/\r?\n/)
  end
end
