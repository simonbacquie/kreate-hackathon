class GraphReader

  def self.problem_number num
    file = File.read(num + '.json')
    JSON.parse(file)
  end

end
