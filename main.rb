require 'json'
require_relative 'graph'
require_relative 'graph_reader'


graph = Graph.new(GraphReader.problem_number ARGV[0])


require 'pry'; binding.pry
