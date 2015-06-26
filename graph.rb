class Graph
  attr_accessor :eulerian_cycle_node, :start_node, :end_node, :matrix, :edges_crossed, :original_number_of_connections, :history

  def initialize
    @matrix = [
      [0, 1, 0, 1],
      [1, 0, 1, 1],
      [0, 1, 0, 1],
      [1, 1, 1, 0]
    ]
    @history = []
    @edges_crossed = 0
    # @original_number_of_connections = @matrix.flatten.reduce(:+)
    # total number of connections, could be: total in degrees - total out degrees (or the other way around?)
  end

  def eulerian_cycle_exists?
    # degree of every vertex has to be even
    (0..@matrix.length-1).map{|x| x if vertex_degree_even?(x) && vertex_indegree(x) > 0}.compact.any?
  end

  def eulerian_path_exists?
    overall_degrees_fit_eulerian_path? && start_vertex_fits_eulerian_path? && end_vertex_fits_eulerian_path?
  end

  # each vertex except 2 have the same in-degree as out-degree
  def overall_degrees_fit_eulerian_path?
    vertices_with_different_indegree_and_outdegree.length == 2
  end

  def vertices_with_different_indegree_and_outdegree
    (0..@matrix.length-1).map do |x|
      x if vertex_indegree(x) != vertex_outdegree(x)
    end.compact
  end

  def start_vertex_fits_eulerian_path?
    # one of those 2 vertices has out-degree with one greater than in-degree
    vertex_outdegree(@start_node) == vertex_indegree(@start_node) - 1
  end

  def end_vertex_fits_eulerian_path?
    # the other vertex has in-degree with one greater than out-degree
    vertex_indegree(@start_node) == vertex_outdegree(@start_node) + 1
  end

  def total_vertices_count
    nil
  end

  def odd_vertices_count
    nil
  end

  def even_vertices_count
    nil
  end


  def same_even_and_odd_vertices_count
    nil
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
