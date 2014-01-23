class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sent_messages, :foreign_key => 'sender_id'
  has_many :received_messages, :foreign_key => 'receiver_id'
end
