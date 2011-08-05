class Channel
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,        type: String
  field :description, type: String
  field :actor_start_time, type: Time
  field :actor_allowed_time, type: Integer, :default => 120

  key :name

  has_many :users
  has_many :actors, :class_name => 'User', :inverse_of => 'acting_channel'

  validates_presence_of   :name
  validates_uniqueness_of :name

  def time_left_ms
    if self.actor_start_time
      elapsed = Time.now.utc - self.actor_start_time
    else
      elapsed = self.actor_allowed_time + 1
    end

    ((self.actor_allowed_time - elapsed) * 1000).floor
  end

  def new_actor!
    # TODO: make this an atomic operation to prevent race conditions when running multiple instances!
    return unless self.actors.length == 0 || self.time_left_ms <= 0
    puts "new_actor!"
    self.actor_start_time = Time.now.utc + 5.seconds
    self.save!
    users = self.users

    new_actor = users[rand(users.count)]
    self.actors.nullify
    self.actors << new_actor
  end
end
