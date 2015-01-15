module AnswersHelper

  def participation_rate    
    num = (@answers.count / (@vote.invites.count + 1.0)) * 100
    number_to_percentage(num, precision: 0)
  end

  # truncated answers so that chart displays
  def truncate(ary, len=15)
    ary.map { |w| w.length < len ? w : "#{w[0..len-1]}..." }
  end
end
