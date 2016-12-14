# Dynamic Programming practice
# NB: you can, if you want, define helper functions to create the necessary caches as instance variables in the constructor.
# You may find it helpful to delegate the dynamic programming work itself to a helper method so that you can
# then clean out the caches you use.  You can also change the inputs to include a cache that you pass from call to call.

class DPProblems
  def initialize
    # Use this to create any instance variables you may need
  end

  # Takes in a positive integer n and returns the nth Fibonacci number
  # Should run in O(n) time
  def fibonacci(n)
    fibb = []
    fibb[0], fibb[1], fibb[2] = 0, 1, 1
    (3).upto(n) do |i|
      fibb[i] = fibb[i - 2] + fibb[i - 1]
    end
    fibb[n]
  end

  # Make Change: write a function that takes in an amount and a set of coins.  Return the minimum number of coins
  # needed to make change for the given amount.  You may assume you have an unlimited supply of each type of coin.
  # If it's not possible to make change for a given amount, return nil.  You may assume that the coin array is sorted
  # and in ascending order.

  # approach
  # if amt is in coin_cache, return it (already calculated)
  # if amt is greater than smallest coin, return nil
  # set best_change to amt (largest value)
  # iterate through coins
  # next if coin is bigger than amt
  # calc current change as 1 plus make_change of amt - coin
  # if current change or amt - coin is !nil? then set value in hash
  def make_change(amt, coins, coin_cache = {0 => 0})
    ### THIS FAILS SPECS BECAUSE NIL.nan? IS NOT A METHOD ###
    return coin_cache[amt] if coin_cache.key?(amt)
    return nil if amt < coins.first

    best_change = amt
    coins.each do |coin|
      next if amt < coin
      prev_change = make_change(amt - coin, coins, coin_cache)
      if prev_change.nil?
        coin_cache[amt] = nil
      else
        best_change = [best_change, prev_change + 1].min
        coin_cache[amt] = best_change
      end
    end

    best_change == amt ? nil : best_change
  end

  # Knapsack Problem: write a function that takes in an array of weights, an array of values, and a weight capacity
  # and returns the maximum value possible given the weight constraint.  For example: if weights = [1, 2, 3],
  # values = [10, 4, 8], and capacity = 3, your function should return 10 + 4 = 14, as the best possible set of items
  # to include are items 0 and 1, whose values are 10 and 4 respectively.  Duplicates are not allowed -- that is, you
  # can only include a particular item once.
  def knapsack(weights, values, capacity)
    return 0 if capacity <= 0 || weights.empty? || values.empty?
    build_table(weights, values, capacity)[capacity][weights.length - 1]
  end

  def build_table(weights, values, capacity)
    solutions = []
    (0).upto(capacity) do |i|
      solutions[i] = []
      (0).upto(weights.size - 1) do |j|
        if i.zero?
          # building left column
          solutions[i][j] = 0
        elsif j.zero?
          # building first row
          solutions[i][j] = weights.first > i ? 0 : values.first
          else
          with_item = calc_with_item(weights, values, solutions, i, j)
          without_item = solutions[i][j - 1] # best value without taking item
          solutions[i][j] = [with_item, without_item].max
        end
      end
    end

    solutions
  end

  def calc_with_item(weights, values, solutions, i, j)
    if i < weights[j] # if capacity is less than weight of current item
      return 0
    else
      # value of current item plus best soln with capacity - weight of item
      return solutions[i - weights[j]][j - 1] + values[j]
    end
  end

  # Stair Climber: a frog climbs a set of stairs.  It can jump 1 step, 2 steps, or 3 steps at a time.
  # Write a function that returns all the possible ways the frog can get from the bottom step to step n.
  # For example, with 3 steps, your function should return [[1, 1, 1], [1, 2], [2, 1], [3]].
  # NB: this is similar to, but not the same as, make_change.  Try implementing this using the opposite
  # DP technique that you used in make_change -- bottom up if you used top down and vice versa.
  def stair_climb(n)
    routes = [[[]], [[1]], [[1, 1], [2]]] # like fibb sequence

    (3).upto(n) do |dest_step|
      current_routes = []
      (1).upto(3) do |last_step|
        routes[dest_step - last_step].each do |route|
          current_routes << [last_step] + route
        end
      end
      routes << current_routes
    end

    routes[n]
  end

  # String Distance: given two strings, str1 and str2, calculate the minimum number of operations to change str1 into
  # str2.  Allowed operations are deleting a character ("abc" -> "ac", e.g.), inserting a character ("abc" -> "abac", e.g.),
  # and changing a single character into another ("abc" -> "abz", e.g.).
  def str_distance(str1, str2)
  end

  # Maze Traversal: write a function that takes in a maze (represented as a 2D matrix) and a starting
  # position (represented as a 2-dimensional array) and returns the minimum number of steps needed to reach the edge of the maze (including the start).
  # Empty spots in the maze are represented with ' ', walls with 'x'. For example, if the maze input is:
  #            [['x', 'x', 'x', 'x'],
  #             ['x', ' ', ' ', 'x'],
  #             ['x', 'x', ' ', 'x']]
  # and the start is [1, 1], then the shortest escape route is [[1, 1], [1, 2], [2, 2]] and thus your function should return 3.
  def maze_escape(maze, start)
  end
end
