require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  def setup
    vote = votes(:one)
    @answer = vote.answers.build(answer: 'yes', user_id: 1)
  end

  test 'should be valid' do
    assert @answer.valid?
  end

  test 'answer should be present' do
    @answer.answer = ''
    assert_not @answer.valid?
  end

  test 'vote and user should be present' do
    refute_nil @answer.user_id
    refute_nil @answer.vote_id
  end

  test 'comment shouldn\'t be too long' do
    @answer.comment = 'a' * 141
    assert_not @answer.valid?

  end
end
