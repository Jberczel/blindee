class ChartData
  def self.results(vote)
    all_results  = vote.get_choices.inject(Hash.new(0)) { |h,choices| h[choices] = 0; h }
    user_results = vote.answers.group(:answer).count
    all_results.merge user_results
  end
end
