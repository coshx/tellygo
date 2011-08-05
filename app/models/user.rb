class User
  include Mongoid::Document
  
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :authentication_token


  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :token_authenticatable

  before_save :ensure_authentication_token

  field :name,  type: String
  field :email, type: String
  field :authentication_token, type: String

  key :name

  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false

  belongs_to :channel
  belongs_to :acting_channel, :class_name => 'Channel', :inverse_of => :actors

end
