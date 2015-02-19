require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  def setup
    @vote = Vote.new(question: "How are you", choices: "good\nokay\nbady", creator_id: 1)
  end

  test "should be valid" do
    assert @vote.valid?
  end

  test 'question should be present' do
    @vote.question = ''
    assert_not @vote.valid?
  end

  test 'choices should be present' do
    @vote.choices = '   '
    assert_not @vote.valid?
  end

  test 'inputs should not be too long' do
    @vote.question = 'a' * 141
    assert_not @vote.valid?
    @vote.choices =  'b' * 141
    assert_not @vote.valid?
  end

  test 'question updated with question mark' do
    @vote.save
    assert_equal "How are you?",  @vote.question
  end

  test 'choices do not include blank lines' do
    @vote.choices = "good\n           \nokay\n\n\n  \nbad"
    assert_equal ['good','okay','bad'], @vote.get_choices
  end

  test 'max choices' do
    @vote.choices = "1\n2\n\n3\n \nfour\n5\n6"
    choices = @vote.get_choices
    assert_equal 5, choices.count
    refute_includes choices, '6'
  end
end
