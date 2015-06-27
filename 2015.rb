# require 'pry'
# require './graph.rb'
require 'json'
require_relative 'graph'
require_relative 'graph_reader'


# graph = Graph.new(GraphReader.problem_number ARGV[0])


# require 'pry'; binding.pry

og = Graph.new(GraphReader.problem_number ARGV[0])
queue = []
finished = []
(0..og.matrix.length-1).each do |starting_vertex|
  g = og.clone
  g.start_node = starting_vertex
  g.original_start_node = starting_vertex
  # g.end_node = starting_vertex
  g.eulerian_cycle_node = starting_vertex
  # g.history << starting_vertex
  # require 'pry'; binding.pry
  g.available_advances.each do |aa|
    h = g.clone
    # require 'pry'; binding.pry
    h.advance_to(aa)
    puts "h is advanceable, start_node: #{h.start_node}, end_node: #{h.end_node}, eulerian_cycle_node: #{h.eulerian_cycle_node}"
    queue << h if h.advanceable?
    if !h.advanceable?
      if h.start_node == 3
        # require 'pry'; binding.pry
      end
      puts "h is NOT advanceable, start_node: #{h.start_node}, end_node: #{h.end_node}, eulerian_cycle_node: #{h.eulerian_cycle_node}"
    end
# we probably need to check for finished here, but don't worry yet
  end
end


# require 'pry'; binding.pry

until queue.empty? do
  # puts 'begin until loop'
  # require 'pry'; binding.pry
  # queue.each do |q|
    q = queue.pop
        if q.history == [2,3,1,0]
          require 'pry'; binding.pry
        end
    # require 'pry'; binding.pry
    q.available_advances.each do |qaa|
      qh = q.clone
      qh.advance_to(qaa)
      if qh.finished?
        # require 'pry'; binding.pry
        finished << qh
      else
        puts "qh is advanceable, start_node: #{qh.start_node}, end_node: #{qh.end_node}, eulerian_cycle_node: #{qh.eulerian_cycle_node}"
        puts qh.history.join(', ')
        if qh.history == [2,3,1,0]
          require 'pry'; binding.pry
        end
        queue << qh if qh.advanceable?
      end
    end
  # end
end

# require 'pry'; binding.pry
# puts finished
puts "SOLUTIONS: \n"
finished.each do |f|
  puts f.solution.join(' -> ')
end


# binding.pry
