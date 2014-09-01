class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :vote

  validates :comment, length: { maximum: 140 }
end
