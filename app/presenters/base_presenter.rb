class BasePresenter < SimpleDelegator
  def initialize(model, view)
    @model, @view = model, view
    super(@model)
  end

  def self.wrap(collection, view)
    collection.map do |obj|
      new(obj,view)
    end
  end

  def h
    @view
  end
end
