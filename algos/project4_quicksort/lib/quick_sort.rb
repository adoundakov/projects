class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.size <= 1
    pivot = array.first
    left, right = [], []
    array.drop(1).each do |el|
      if el <= pivot
        left << el
      else
        right << el
      end
    end

    QuickSort.sort1(left) + [pivot] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= proc { |a, b| a <=> b }
    return array if length <= 1
    p_idx = QuickSort.partition(array, start, length, &prc)
    l_len = p_idx - start
    r_len = length - (l_len + 1)
    QuickSort.sort2!(array, start, l_len, &prc)
    QuickSort.sort2!(array, p_idx + 1, r_len, &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= proc { |a, b| a <=> b }
    pivot = array[start]
    (start + 1...start + length).each do |v_idx|
      next unless prc.call(pivot, array[v_idx]) == 1
      QuickSort.swap!(array, start + 1, v_idx)
      QuickSort.swap!(array, start, start + 1)
      start += 1
    end
    start
  end

  def self.swap!(array, i, j)
    array[i], array[j] = array[j], array[i]
  end
end
