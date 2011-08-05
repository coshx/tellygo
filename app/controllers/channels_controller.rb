class ChannelsController < ApplicationController
  load_and_authorize_resource
  before_filter :leave_channel, :only => [:show, :index]

  def index
  end

  def show
    if current_user
      @channel.users << current_user
      @channel.save!
    end

    @users = @channel.users
  end

  private

  def leave_channel
    current_user.leave_channel! if current_user
  end
end
