class ChannelsController < ApplicationController
  load_and_authorize_resource
  before_filter :leave_channel, :only => [:show, :index]

  respond_to :html, :amf, :json

  def index
  end

  def show
    if current_user
      @channel.users << current_user
      @rubyamf_uri = "#{rubyamf_gateway_url.strip}?auth_token=#{current_user.authentication_token}"
    else
      @rubyamf_uri = rubyamf_gateway_url.strip
    end

    # TODO: put this in a configuration somewhere
    #@rtmp_server = 'rtmp://localhost:5080/TellyGo'
    @rtmp_server = 'rtmp://demo.metiva.com/metiva'

    @users = @channel.users
  end

  def current_actor
    @channel = Channel.first(:conditions => {:_id => rubyamf_params[0]})

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
    amf = @channel.time_left_ms

    if amf <= 0
      @channel.new_actor!
    end
    render :amf => amf
  end

  private

  def leave_channel
    if current_user
      current_user.channel_id = nil
      current_user.save!
    end
  end
end
