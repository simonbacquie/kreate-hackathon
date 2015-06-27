class Graph
  attr_accessor :eulerian_cycle_node, :start_node, :end_node, :matrix, :edges_crossed, :original_number_of_connections, :history

  def initialize matrix
    @matrix = matrix
    @history = []
    @edges_crossed = 0
    # @original_number_of_connections = @matrix.flatten.reduce(:+)
    # total number of connections, could be: total in degrees - total out degrees (or the other way around?)
  end

  def solution_foreseeable?
    # we use @matrix.length to count the number of vertices in the graph
    # if the graph has less than 3 vertices our fancy rules of math don't
    # apply that well here, and we can go ahead and brute force it
    @matrix.length < 3 || eulerian_cycle_exists? || eulerian_path_exists?
  end

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
    eulerian_cycle_exists? || eulerian_path_exists?
  end

  def advance_to index
    # require 'pry'; binding.pry
    @history << index
    @edges_crossed += 1
    @matrix[@start_node][index] -= 1 unless @matrix[@start_node][index].zero?
    @matrix[index][@start_node] -= 1 unless @matrix[index][@start_node].zero?
    @start_node = index
  end

  def available_advances
    # require 'pry'; binding.pry
    # @matrix.each_with_index.map{|x,i| i if x.map{|y| y > 0}.any? }.compact
    @matrix[@start_node].each_with_index.map{|x,i| i if x > 0}.compact
  end

  def connections_open?
    @matrix.flatten.reduce(:+) > 0
  end

  def finished?
    # number of nodes crossed matches original number of connections
    # start_node is equal to eulerian_cycle_node
    # @edges_crossed == @original_number_of_connections && @start_node == @eulerian_cycle_node
    # require 'pry'; binding.pry
    !connections_open? && @start_node == @eulerian_cycle_node
  end

  def clone
    Marshal.load(Marshal.dump(self))
  end

end
