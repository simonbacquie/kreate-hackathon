require 'rspec'
require 'pry'
require_relative '../graph'
# require '/home/simon/Development/hackathon2015/2015.rb'

describe Graph do

  context 'starting graph' do
    before do
      @graph = Graph.new nil
      @graph.matrix = [
        [0, 1, 0, 1],
        [1, 0, 1, 1],
        [0, 1, 0, 1],
        [1, 1, 1, 0]
      ]
      @graph.eulerian_cycle_node = 3
      @graph.start_node = 3
      @graph.end_node = 3
    end

    it 'has a possible Eulerian Cycle' do
    end

    it 'has the same start_node as its eulerian_cycle_node' do
    end

    it 'has the same end_node as its eulerian_cycle_node' do
    end

    it 'has the same start_node and end_node' do
    end

  end

  # SO IT TURNS OUT THAT IT CAN BE A EULERIAN CYCLE,
  # AND NOT A EULERIAN PATH,
  # LATER ON AFTER THE FIRST STEP

  context 'partially broken away graph' do

    before do
      @graph = Graph.new nil
      @graph.matrix = [
        [0, 1, 0, 1],
        [1, 0, 1, 0],
        [0, 1, 0, 1],
        [1, 0, 1, 0]
      ]
      @graph.eulerian_cycle_node = 3
      @graph.start_node = 1
      @graph.end_node = 3
    end

# THIS IS THE WRONG DIRECTION< USE AS BAD GRAPH TEST
    # before do
    #   @graph = Graph.new
    #   @graph.matrix = [
    #     [0, 1, 0, 1],
    #     [1, 0, 1, 1],
    #     [0, 1, 0, 0],
    #     [1, 1, 0, 0]
    #   ]
    #   @graph.eulerian_cycle_node = 3
    #   @graph.start_node = 2
    #   @graph.end_node = 3
    # end

    it 'has a possible Eulerian Cycle' do
      # expect(@graph.eulerian_cycle_exists?).to be_true
      require 'pry'; binding.pry
      @graph.eulerian_cycle_exists?.should == true
    end

    it 'has a possible Eulerian Path' do
      @graph.eulerian_path_exists?.should == false
      # expect(@graph.eulerian_path_exists?).to be_true
    end

    it 'has a start_node different from its eulerian_cycle_node' do
    end

  end

  context "graph that's about to be finished" do
    # make an almost finished graph
    # finish the graph
    # check finished? here
    nil
  end

  context "graph with only one possible solution" do

    it 'has the correct number of traversals in its history after it finishes' do
      nil
    end

    it 'has only one solution in its solution set' do
      nil
    end

  end

end
