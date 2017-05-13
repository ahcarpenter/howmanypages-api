class LocChannel < ApplicationCable::Channel
  def subscribed
    stream_from "loc_#{params[:username]}#{params[:repository]}"
  end
end
