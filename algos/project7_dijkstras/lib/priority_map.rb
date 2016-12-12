require_relative 'heap2'

class PriorityMap
  def initialize(&prc)
    @map = {}
    @queue = BinaryMinHeap.new { |k1, k2| prc.call(@map[k1], @map[k2]) }
  end

  def [](key)
    return nil unless @map[key]
    @map[key]
  end

  def []=(key, value)
    @map[key] ? update(key, value) : insert(key, value)
  end

  def count
    @map.count
  end

  def empty?
    count.zero?
  end

  def extract
    key = @queue.extract
    val = @map.delete(key)
    [key, val]
  end

  def has_key?(key) # should rename to #key? instead
    !@map[key].nil?
  end

  protected

  attr_accessor :map, :queue

  def insert(key, value)
    @map[key] = value
    @queue.push(key)
  end

  def update(key, value)
    raise "non-existent key" unless has_key?(key)
    @map[key] = value
    @queue.reduce!(key)
    nil
  end
end
