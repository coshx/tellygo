class ChannelsController < ApplicationController
  load_and_authorize_resource
  before_filter :leave_channel, :only => [:show, :index]

  respond_to :html, :amf, :json

  def index
  end

  def show
    if current_user
      @channel.users << current_user
    end

    @users = @channel.users
  end

  def current_actor
    @channel = Channel.first(:conditions => {:_id => rubyamf_params[0]})

    # TODO: make this atomic (calling new_actor! from time_left_ms as well)
    if @channel.actors.count == 0
      @channel.new_actor!
    end

    if actor = @channel.actors.first
      amf = actor._id
    else
      amf = ""
    end

    render :amf => amf
  end

  def time_left_ms
    @channel = Channel.first(:conditions => {:_id => rubyamf_params[0]})

    if @channel.actors.length > 0 && @channel.actor_start_time
      elapsed = (Time.now.utc - @channel.actor_start_time)
      puts "Elapsed: #{elapsed.to_f}"
    else
      elapsed = @channel.actor_allowed_time + 1
    end

    amf = ((@channel.actor_allowed_time - elapsed) * 1000).floor

    # TODO: make this atomic, along with updating the actor
    if amf <= 0
      @channel.new_actor!
    end
    render :amf => amf
  end

  private

  def leave_channel
#    if current_user
#      current_user.channel = nil
#      current_user.save!
#    end
  end
end
