require_relative 'graph'

# O(|V|**2 + |E|).
def dijkstra1(source)
end

# general approach

# for starting node
#   make list of visited nodes, starts with just src
#   make list of costs to reach nodes, start at -1 or inf
#   visit all unvisited nodes possible, updating costs
#   select lowest cost path, add verted to visited, repeat
#   once no more possible paths, return shortest path
