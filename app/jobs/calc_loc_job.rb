require 'fileutils'

class CalcLocJob < ApplicationJob
  include RedisMutex::Macro
  auto_mutex :perform, on: [:username, :repository], block: 0
  queue_as :default

  def perform(username, repository)
    FileUtils.rm_rf("tmp/repos/#{username}/#{repository}")
    # Do something later
    Git.clone(
      "https://github.com/#{username}/#{repository}.git",
      repository,
      bare: true,
      path: "tmp/repos/#{username}",
      depth: 1
    )

    @repository = Repository.new(username, repository)

    ActionCable.server.broadcast(
      "loc_#{username}#{repository}",
      repository: @repository
    )
  end
end
