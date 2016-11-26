require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
      update_link!(@map[key])
      @map[key].val    # returns a linkedList Node
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    new_link = @store.insert(key, @prc.call(key))
    @map[key] = new_link
    eject! if count > @max
    new_link.val
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    # cut link from location (reassign prev and next)
    # paste link right before tail
    link.prev.next = link.next
    link.next.prev = link.prev

    link.prev = @store.last       # set last node to link.prev
    link.next = @store.last.next  # set link.next == tail
    @store.last.next = link
  end

  def eject!
    del = @store.first
    del.next.prev, del.prev.next = del.prev, del.next
    @map.delete(del.key)
  end
end
