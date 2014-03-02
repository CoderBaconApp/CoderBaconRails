class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_id'
  has_and_belongs_to_many :conversations, join_table: :listeners
end
