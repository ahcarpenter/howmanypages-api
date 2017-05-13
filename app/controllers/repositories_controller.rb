require 'fileutils'

class RepositoriesController < ApplicationController
  # GET /:username/:repository
  def show
    CalcLocJob.perform_later(
      params[:username],
      params[:repository]
    )
    render json: {}, status: :ok
  end
end
