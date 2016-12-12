require_relative 'graph'
require_relative 'priority_map'

# O(|V| + |E|*log(|V|)).
def dijkstra2(source)
  best_paths = {}
  potential_paths = PriorityMap.new { |a, b| a[:cost] <=> b[:cost] }
  potential_paths[source] = { cost: 0, last_edge: nil }

  until potential_paths.empty?
    vertex, path = potential_paths.extract
    best_paths[vertex] = path
    vertex.out_edges.each do |e|
      to_vertex = e.to_vertex
      next_path_cost = path[:cost] + e.cost
      next if best_paths.key?(to_vertex) ||
              (potential_paths.has_key?(to_vertex) &&
               potential_paths[to_vertex][:cost] <= next_path_cost)
      potential_paths[to_vertex] = { cost: next_path_cost, last_edge: e }
    end
  end
  best_paths
end

# refactor:
# PriorityMap spec for has_key? needs to be rewritten to expect
# PriorityMap#key? method, to keep in line with style guide
# "Prefer #key? to #has_key? for hashes and the like"
