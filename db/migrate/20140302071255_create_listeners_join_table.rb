class CreateListenersJoinTable < ActiveRecord::Migration
  def change
    create_table :listeners do |t|
      t.integer :user_id, null: false
      t.integer :conversation_id, null: false
      t.timestamps

      t.index [:user_id, :conversation_id], unique: true
    end
  end
end
