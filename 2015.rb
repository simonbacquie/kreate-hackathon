require 'json'
require_relative 'graph'
require_relative 'graph_reader'

og = Graph.new(GraphReader.problem_number ARGV[0])
queue = []
finished = []
(0..og.matrix.length-1).each do |starting_vertex|
  g = og.clone
  g.current_node = starting_vertex
  g.original_start_node = starting_vertex
  g.available_advances.each do |aa|
    h = g.clone
    h.advance_to(aa)
    if h.finished?
      finished << h
      next
    end
    queue << h if h.advanceable?
  end
end

until queue.empty? do
  q = queue.pop
  q.available_advances.each do |qaa|
    qh = q.clone
    qh.advance_to(qaa)
    if qh.finished?
      finished << qh
    else
      queue << qh if qh.advanceable?
    end
  end
end

puts "SOLUTIONS: \n"
finished.each do |f|
  puts f.solution.join(' -> ')
end
