# This class just dumbs down a regular Array to be staticly sized.
class StaticArray
  def initialize(length)
    self.store = Array.new(length)
  end

  # O(1)
  def [](index)
    return store[index] if in_bounds?(index)
    raise 'index out of bounds'
  end

  # O(1)
  def []=(index, value)
    return store[index] = value if in_bounds?(index)
    raise 'index out of bounds'
  end

  protected

  attr_accessor :store

  def in_bounds?(index)
    index < store.length && index >= 0 ? true : false
  end
end
