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

  def new_actor!
    puts "new_actor!"
    self.actor_start_time = Time.now.utc + 5.seconds
    self.save!
    users = self.users

    new_actor = users[rand(users.count)]
    self.actors.nullify
    self.actors << new_actor
  end
end
