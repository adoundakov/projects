class BinaryMinHeap # :nodoc:
  def self.swap(array, i, j)
    array[i], array[j] = array[j], array[i]
  end

  def self.child_indices(len, parent_index)
    children = [parent_index * 2 + 1, parent_index * 2 + 2]
    children.select { |idx| idx < len }
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index <= 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= proc { |a, b| a <=> b }
    child_indices = BinaryMinHeap.child_indices(len, parent_idx)
    child_indices.sort! { |a, b| prc.call(array[a], array[b]) }
    child_indices.each do |child|
      if prc.call(array[parent_idx], array[child]) == 1
        BinaryMinHeap.swap(array, child, parent_idx)
        BinaryMinHeap.heapify_down(array, child, len, &prc)
      end
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= proc { |a, b| a <=> b }
    return array if child_idx.zero?
    parent_idx = BinaryMinHeap.parent_index(child_idx)
    if prc.call(array[parent_idx], array[child_idx]) == 1
      BinaryMinHeap.swap(array, child_idx, parent_idx)
      BinaryMinHeap.heapify_up(array, parent_idx, len, &prc)
    end

    array
  end

  def initialize(&prc)
  end

  def count
  end

  def extract
  end

  def peek
  end

  def push(val)
  end

  protected

  attr_accessor :prc, :store
end
