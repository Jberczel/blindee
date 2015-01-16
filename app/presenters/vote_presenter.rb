class VotePresenter < BasePresenter
  def participation_rate
    if @model.public?
      "#{h.pluralize(@model.answers.count, "vote")} so far"
    else
      "#{get_participation_rate} participation rate"
    end
  end

  def comments
    answers.map { |a| a.comment }
  end

  private

  # helper method
  def get_participation_rate
    n = (answers.count.to_f / (invites.count + 1)) * 100
    h.number_to_percentage(n, precision: 0)
  end
end
