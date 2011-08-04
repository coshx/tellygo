class User
  include Mongoid::Document
  
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me


  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :username, type: String
  field :email,    type: String

  key :username

  validates_presence_of :name
  validates_uniqueness_of :username, :email, :case_sensitive => false

  belongs_to :room
end
