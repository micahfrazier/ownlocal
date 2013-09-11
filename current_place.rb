class CurrentPlace

  attr_accessor :state

  def initialize
    @state = Hash.new({})
  end

  def reset
    @state = Hash.new({})
  end
end