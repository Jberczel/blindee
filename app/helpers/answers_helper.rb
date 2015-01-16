module AnswersHelper
  # truncated answers so that chart displays
  def truncate(ary, len=15)
    ary.map { |w| w.length < len ? w : "#{w[0..len-1]}..." }
  end
end
