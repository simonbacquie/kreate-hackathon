class Graph
  attr_accessor :current_node, :matrix, :original_start_node, :history

  def initialize matrix
    @matrix = matrix
    @history = []
  end

  def clone
    Marshal.load(Marshal.dump(self))
  end

  # MATH RULES THAT WE NEED TO FOLLOW

  def eulerian_cycle_exists?
    # To have a Eulerian Cycle:
    # degree of every vertex is even?
    # OR, indegree of every vertex = outdegree of every vertex?
    (0..@matrix.length-1).map{|x| x if vertex_degree_even?(x) && vertex_indegree(x) > 0}.compact.any?
  end

  def eulerian_path_exists?
    # To have a Eulerian Path:
    # (assuming there are 3 or more vertices in the graph)
    (vertices_with_different_indegree_and_outdegree.length == 2 &&
    indegree_outdegree_pair_inverse_relationship?(vertices_with_different_indegree_and_outdegree))
  end

  def overall_degrees_fit_eulerian_cycle?
    (0..@matrix.length-1).map do |x|
      x if vertex_indegree(x) == vertex_outdegree(x)
    end.compact.length == @matrix.length
  end

  def vertices_with_different_indegree_and_outdegree
    (0..@matrix.length-1).map do |x|
      x if vertex_indegree(x) != vertex_outdegree(x)
    end.compact
  end

  def indegree_outdegree_pair_inverse_relationship? vertices_array
    # for there to be a Eulerian Path, in the pair of vertices whose
    # indegrees and outdegrees differ, one vertex must have an outdegree that
    # is one more than its indegree, and the other vertex must have an
    # outdegree that is one less than its indegree
    first, second = vertices_array.first, vertices_array.last
    ((vertex_outdegree(second) == vertex_indegree(second) + 1 &&
      vertex_outdegree(first) == vertex_indegree(first) - 1) ||
    (vertex_outdegree(first) == vertex_indegree(first) + 1 &&
      vertex_outdegree(second) == vertex_indegree(second) - 1))
  end

  # HELPER FUNCTIONS FOR MATH RULES

  def vertex_degree_even? index
    vertex_indegree(index).even?
  end

  def vertex_degree_odd? index
    vertex_indegree(index).odd?
  end

  def vertex_indegree index
    @matrix.map{|x| x[index]}.reduce(:+)
  end

  def vertex_outdegree index
    @matrix[index].reduce(:+)
  end

  # ADVANCING

  def advanceable?
    available_advances.length == 1 || eulerian_cycle_exists? || eulerian_path_exists?
  end

  def advance_to index
    # require 'pry'; binding.pry
    @history << index
    @matrix[@current_node][index] -= 1 unless @matrix[@current_node][index].zero?
    @matrix[index][@current_node] -= 1 unless @matrix[index][@current_node].zero?
    @current_node = index
  end

  def available_advances
    @matrix[@current_node].each_with_index.map{|x,i| i if x > 0}.compact
  end

  def connections_open?
    @matrix.flatten.reduce(:+) > 0
  end

  def finished?
    !connections_open?
  end

  def solution
    s = @history
    s.unshift(@original_start_node)
  end

end
