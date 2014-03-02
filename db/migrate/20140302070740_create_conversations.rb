class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |c|
      c.timestamps
    end
  end
end
