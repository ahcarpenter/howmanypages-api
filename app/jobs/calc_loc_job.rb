require 'fileutils'

class CalcLocJob < ApplicationJob
  queue_as :default

  def perform(username, repository)
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
    FileUtils.rm_rf("tmp/repos/#{username}/#{repository}")
  end
end
