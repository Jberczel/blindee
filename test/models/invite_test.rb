require 'test_helper'

class InviteTest < ActiveSupport::TestCase
  def setup
    @vote = votes(:one)
    @invite = @vote.invites.build(email: "blindee@email.com")
  end

  test "should be valid" do
    assert @invite.valid?
  end

  test 'email should be present' do
    @invite.email = ''
    assert_not @invite.valid?
  end

  test 'validates email' do
    bad_emails = ['jeb', 'jeb@@email.com', 'jeb@email']
    bad_emails.each do |email|
      @invite.email = email
      assert_not @invite.valid?
    end
  end

  test 'unique email invitations' do
    @invite.save
    @same_invite = @invite.dup
    assert_not @same_invite.valid?
  end

  test 'downcase emails before saving' do
    @invite.email = "JeRemiaH@email.com"
    @invite.save
    assert_equal 'jeremiah@email.com', @invite.email
  end

  test 'vote should be present' do
    @invite.vote_id = ''
    assert_not @invite.valid?
  end

  test 'generate_token' do
    @invite.save
    refute_nil @invite.token, 'token was not generated after save'
  end

  test 'assigns recipient if already a user' do
    @invite.save
    refute_nil @invite.recipient_id
  end

  test 'does not assign recipient if new user' do
    another_invite = @vote.invites.build(email: 'arnold@email.com')
    another_invite.save
    assert_nil another_invite.recipient_id
  end
end
