class BinaryMinHeap
  def self.child_indices(len, parent_index)
    [(parent_index * 2) + 1, (parent_index * 2) + 2].select { |idx| idx < len }
  end

  def self.parent_index(child_index)
    child_index.zero? ? (raise 'root has no parent') : (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= proc { |a, b| a <=> b }

    while parent_idx < len
      child_idx = child_indices(len, parent_idx).sort do |a, b|
        prc.call(array[a], array[b])
      end.first  # gets the lowest element idx by given proc

      if child_idx && prc.call(array[parent_idx], array[child_idx]) > 0
        swap!(parent_idx, child_idx, array)
        parent_idx = child_idx
      else
        break
      end
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= proc { |a, b| a <=> b }
    while child_idx > 0
      current = array[child_idx]
      parent_idx = parent_index(child_idx)
      parent = array[parent_idx]
      if prc.call(current, parent) < 0
        swap!(child_idx, parent_idx, array)
        child_idx = parent_idx
      else
        break
      end
    end

    array
  end

  def self.swap!(idx1, idx2, array)
    array[idx1], array[idx2] = array[idx2], array[idx1]
  end

  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    val = @store.pop
    @store = BinaryMinHeap.heapify_down(@store, 0, count, &prc)
    val
  end

  def peek
    @store.first
  end

  def push(val)
    @store << val
    @store = BinaryMinHeap.heapify_up(@store, count - 1, count, &prc)
  end

  protected

  attr_accessor :prc, :store
end
