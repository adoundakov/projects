require_relative 'graph'

# O(|V|**2 + |E|).
def dijkstra1(source)
  best_paths = {}
  potential_paths = { source => { cost: 0, last_edge: nil } }
  until potential_paths.empty?
    path = potential_paths.min_by { |_, v| v[:cost] }
    vertex = path[0]
    best_paths[vertex] = path[1]
    potential_paths.delete(vertex)
    curr_path_cost = best_paths[vertex][:cost]
    vertex.out_edges.each do |e|
      to_vertex = e.to_vertex
      next_path_cost = curr_path_cost + e.cost
      next unless best_paths[to_vertex].nil?
      next if potential_paths[to_vertex] &&
              potential_paths[to_vertex][:cost] <= next_path_cost
      potential_paths[to_vertex] = { cost: next_path_cost, last_edge: e }
    end
  end

  best_paths
end

# general approach

# for starting node
#   make list of visited nodes, starts with just src
#   make list of costs to reach nodes, start at -1 or inf
#   visit all unvisited nodes possible, updating costs
#   select lowest cost path, add verted to visited, repeat
#   once no more possible paths, return shortest path
