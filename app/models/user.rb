class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_id'
  has_many :listeners
  has_many :conversations, through: :listeners
end
