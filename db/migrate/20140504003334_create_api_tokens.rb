class CreateApiTokens < ActiveRecord::Migration
  def change
    create_table :api_tokens do |t|
      t.string :token
      t.belongs_to :user

      t.timestamps
    end
  end
end
