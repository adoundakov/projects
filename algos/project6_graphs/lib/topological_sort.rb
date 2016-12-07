require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

# Khan's Algorithm
#   Find in-degree for each node
#   Take those that are 0 (no incoming edges), add to queue
#   While queue is !empty
#     pop queue, remove el from graph, check new 0 in-degree nodes
#     Add popped nodes to sorted array
#   When empty: return sorted array

# def topological_sort(vertices)
#   sorted = vertices.select { |n| n.in_edges.empty? }
#   zero_nodes = vertices.select { |n| n.in_edges.empty? }
#   until zero_nodes.empty?
#     node = zero_nodes.pop
#     vertices.delete(node)
#     node.out_edges[0].destroy! until node.out_edges.empty?
#     new_zeroes = vertices.select { |n| n.in_edges.empty? }
#     new_zeroes.each { |n| sorted << n unless sorted.include?(n) }
#     zero_nodes.concat(new_zeroes)
#   end
#   sorted
# end

# Tarian's Algorithm

# def topological_sort(vertices)
#
# end

# Graph from Specs
#
# V1 ---> V2
# |       |
# |       |
# v       v
# V3 ---> V4

if __FILE__ == $PROGRAM_NAME
  v1 = Vertex.new("Wash Markov")
  v2 = Vertex.new("Feed Markov")
  v3 = Vertex.new("Dry Markov")
  v4 = Vertex.new("Brush Markov")
  Edge.new(v1, v2)
  Edge.new(v1, v3)
  Edge.new(v2, v4)
  Edge.new(v3, v4)
  topological_sort([v1, v2, v3, v4])
end
