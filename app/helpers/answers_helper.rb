module AnswersHelper

  def participation_rate    
    num = (@answers.count / (@vote.invites.count + 1.0)) * 100
    number_to_percentage(num, precision: 0)
  end
end