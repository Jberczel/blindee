module AnswersHelper

  def participation_rate    
    num = (@answers.count / (@vote.invites.count + 1.0)) * 100
    number_to_percentage(num, precision: 0)
  end

  # truncated answers so that chart displays
  def truncate(array)
    array.map { |word| word.length < 15 ? word : "#{word[0..14]}..." }
  end
end