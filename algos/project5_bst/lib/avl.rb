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

  def insert(value)
    @root = AVLTree.insert!(@root, value)
  end

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
end
