class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def children
    [@left, @right]
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    @root ? BinarySearchTree.insert!(@root, value) : @root = BSTNode.new(value)
  end

  def find(value)
    BinarySearchTree.find!(@root, value)
  end

  def inorder
    BinarySearchTree.inorder!(@root)
  end

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def min
    BinarySearchTree.min(@root)
  end

  def max
    BinarySearchTree.max(@root)
  end

  def delete(value)
    BinarySearchTree.delete!(@root, value)
  end

  def self.insert!(node, value)
    return node = BSTNode.new(value) unless node

    if node.value >= value
      node.left = insert!(node.left, value)
    else
      node.right = insert!(node.right, value)
    end
    node
  end

  def self.find!(node, value)
    return nil unless node
    return node if node.value == value

    if node.value < value
      find!(node.right, value)
    else
      find!(node.left, value)
    end
  end

  def self.preorder!(node)
    return [] if node.nil?
    values = []
    values << node.value
    values.concat(preorder!(node.left)) if node.left
    values.concat(preorder!(node.right)) if node.right
    values
  end

  def self.inorder!(node)
    return [] if node.nil?
    values = []
    values.concat(inorder!(node.left)) if node.left
    values << node.value
    values.concat(inorder!(node.right)) if node.right
    values
  end

  def self.postorder!(node)
    return [] if node.nil?
    values = []
    values.concat(postorder!(node.left)) if node.left
    values.concat(postorder!(node.right)) if node.right
    values << node.value
    values
  end

  def self.height!(node)
    return -1 unless node
    [height!(node.left), height!(node.right)].max + 1
  end

  def self.max(node)
    return nil unless node
    return node if node.right.nil?
    max(node.right)
  end

  def self.min(node)
    return nil unless node
    return node if node.left.nil?
    min(node.left)
  end

  def self.delete_min!(node)
    return nil unless node
    return node.right if node.left.nil?
    node.left = delete_min!(node.left)
    node
  end

  def self.delete!(node, value)
    return nil unless node

    if value < node.value
      node.left = delete!(node.left, value)
    elsif value > node.value
      node.right = delete!(node.right, value)
    else
      # if only single child
      return node.left unless node.right
      return node.right unless node.left
      tmp = node
      # tmp.right.min  why min?? meant min(tmp.right) ??
      node = min(tmp.right)
      node.right = delete_min!(tmp.right) # replace old right with min right
      node.left = tmp.left # replace left with left of original node
    end

    node
  end
end
