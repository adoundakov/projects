class AVLTreeNode
  attr_accessor :link, :value

  def initialize
    @value = value
    @link = [nil, nil]
    @balance = 0
  end
end

class AVLTree
  def initialize
    @root = nil
  end

  # Old insert method
  # def insert(value)
  #   @root = AVLTree.insert!(@root, value)
  # end

  def self.insert!(node, value)
    return AVLTreeNode.new(value) unless node

    # where to go? less = left, greater = right
    dir = value < node.value ? 0 : 1

    node.link[dir] = insert!(node.link[dir], value)

    node
  end

  def self.single_rotation!(root, dir)
    other_dir = dir == 0 ? 1 : 0
    other_node = root.link[other_dir]

    root.link[other_dir] = other_node.link[dir]
    other_node.link[dir] = root

    other_node # will define new root
  end

  def self.double_rotation!(root, dir)
    other_dir = dir == 0 ? 1 : 0
    other_node = root.link[other_dir].link[dir]

    root.link[other_dir].link[dir] = other_node.link[other_dir]
    other_node.link[other_dir] = root.link[other_dir]
    root.link[other_dir] = other_node

    other_node = root.link[other_dir]
    root.link[other_dir] = other_node.link[dir]
    other_node.link[dir] = root

    other_node # will define new root
  end

  def self.adjust_balance!(root, dir, bal)
    other_dir = dir.zero? ? 1 : 0

    n = root.link[dir] # root in direction
    nn = n.link[other_dir] # root's direction child in other direction

    if nn.balance.zero?
      root.balance = 0
      n.balance = 0
    elsif nn.balance == bal
      root.balance = -bal
      n.balance = 0
    else
      root.balance = 0
      n.balance = bal
    end

    nn.balance = 0
  end

  def self.insert_balance!(root, dir)
    other_dir = dir.zero? ? 1 : 0
    bal = dir.zero? ? -1 : +1

    n = root.link[dir]

    if n.balance == bal
      root.balance = 0
      n.balance = 0
      root = AVLTree.single_rotation!(root, other_dir)
    else
      AVLTree.adjust_balance!(root, dir, bal)
      root = AVLTree.double_rotation!(root, other_dir)
    end

    root
  end

  def self.insert!(node, value, done)
    return [AVLTreeNode.new(value), false] unless node

    dir = value < node.value ? 0 : 1

    node.link[dir], done = AVLTree.insert!(node.link[dir], value, done)

    unless done
      node.balance += (dir.zero? ? -1: +1)

      if node.balance.zero?
        done = true
      elsif node.balance.abs > 1
        node = AVLTree.insert_balance!(node, dir)
        done = true
      end
    end

    [node, done]
  end

  def insert(value)
    done = false
    @root, done = AVLTree.insert!(@root, value, done)
  end
end
