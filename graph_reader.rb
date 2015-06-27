class GraphReader

  def self.problem_number num
    file = File.read("json/#{num}.json")
    JSON.parse(file)
  end

end
