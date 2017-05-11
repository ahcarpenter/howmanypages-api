class Repository
  attr_accessor :loc, :username, :name

  def initialize(username, name)
    @username = username
    @name = name
    @loc = loc
  end

  def loc
    repo = Rugged::Repository.new("#{Dir.pwd}/tmp/repos/#{username}/#{name}")
    project = Linguist::Repository.new(repo, repo.head.target_id)
    project.languages.inject(0) do |sum, (_, values)|
      sum += values[:loc]
    end
  end
end
