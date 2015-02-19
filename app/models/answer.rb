class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :vote

  validates :answer, presence: true
  validates :comment, length: { maximum: 140 }
  validates :vote, presence: true
  validates :user, presence: true
end
