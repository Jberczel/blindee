require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:votes)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select '.vote-form'
    assert_not_nil assigns(:vote)
  end

  test 'should create new private vote' do
    assert_difference 'Vote.count' do
      post :create, vote: { question: "How are you?", choices: "good\nbad" }
    end
    assert_equal "Vote was successfully created. Now invite some voters!", flash[:success]
  end

  test 'should create new public vote' do
    assert_difference 'Vote.count' do
      post :create, vote: { question: "How are you?", choices: "good\nbad", public_vote: true }
    end
    assert_equal "Your public vote was successfully created.", flash[:success]
  end

  test 'should not create invalid vote' do
    assert_no_difference 'Vote.count' do
      post :create, vote: { problem: "yo?", solutions: "1\n2" }
    end
    assert_equal "Uh oh, something went wrong.", flash[:error]
  end

  test 'should delete vote' do
    assert_difference('Vote.count', -1) do
      delete :destroy, id: votes(:one).id
    end
    assert_not_nil flash[:notice]
  end

  test 'should get notification form' do
    get :new_notification, id: votes(:one).id
    assert_response :success
    assert_select '.invite-form'
  end

end
