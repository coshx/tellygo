class User
  include Mongoid::Document
  
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me


  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :name, type: String
  field :email,    type: String

  key :name

  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false

  belongs_to :channel

  def leave_channel!
    self.channel_id = nil
    save!
  end

end
