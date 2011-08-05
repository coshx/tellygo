class Channel
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,        type: String
  field :description, type: String

  key :name

  has_many :users

  validates_presence_of   :name
  validates_uniqueness_of :name
end
