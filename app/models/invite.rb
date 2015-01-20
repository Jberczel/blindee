class Invite < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  belongs_to :vote
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'

  before_create :generate_token
  before_save :check_already_user
  before_save { self.email = email.downcase }

  # using suspenders email validation
  validates :email, presence: true, uniqueness: { :scope => :vote }, :email => true
  validates :vote_id, presence: true

  private

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.vote_id, Time.now, rand].join)
  end

  def check_already_user
    self.recipient = User.find_by_email(email)
  end
end
