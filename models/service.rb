class Service
  attr_accessor :name, :price, :duration

  def initialize(name, price_in_dollars, duration_in_hours)
    @name = name
    @price = price_in_dollars
    @duration = duration_in_hours
  end
end
