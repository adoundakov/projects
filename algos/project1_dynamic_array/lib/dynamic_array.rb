require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    self.store = StaticArray.new(8)
    self.length = 0
    self.capacity = 8
  end

  # O(1)
  def [](index)
    check_index(index)
    store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    store[index] = value
  end

  # O(1)
  def pop
    tmp = store[length - 1]
    store[length - 1] = nil
    self.length -= 1
    tmp
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if capacity == length
    store[length] = val
    self.length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise Exception, 'index out of bounds' if self.length.zero?
    tmp = store[0]
    idx = 0

    while idx < length - 1
      store[idx] = store[idx + 1]
      idx += 1
    end

    self.length -= 1
    tmp
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if capacity == length
    idx = length - 1

    while idx >= 0
      store[idx + 1] = store[idx]
      idx -= 1
    end

    self.length += 1
    store[0] = val
  end

  protected

  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise 'index out of bounds' unless index >= 0 && index < length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    old_store = store
    self.capacity *= 2
    self.store = StaticArray.new(capacity)
    idx = 0
    while idx < length
      store[idx] = old_store[idx]
      idx += 1
    end
  end
end
