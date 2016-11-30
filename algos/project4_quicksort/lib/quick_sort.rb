class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.size <= 1
    pivot = array.first
    left = []
    right = []
    array.drop(1).each { |el| el > pivot ? right << el : left << el }
    sort1(left) + [pivot] + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= proc { |a, b| a <=> b }

    return array if length <= 1

    pivot_idx = partition(array, start, length, &prc)

    left = pivot_idx - start
    right = length - (left + 1)

    sort2!(array, start, left, &prc) # sort left of pivot
    sort2!(array, pivot_idx + 1, right, &prc) # sort right of pivot

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= proc { |a, b| a <=> b }
    pivot = array[start]
    pivot_idx = start
    ((start + 1)...(start + length)).each do |idx|
      el = array[idx]
      if prc.call(pivot, el) > 0
        array[idx] = array[pivot_idx + 1]
        array[pivot_idx + 1] = pivot
        array[pivot_idx] = el
        pivot_idx += 1
      end
    end

    pivot_idx
  end
end
