class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :user, foreign_key: true
      t.integer :friend_id
      t.string :message
      # t.integer :requestfeed_id
      t.boolean :approve_status, :default => false
      # t.index ["requestfeed_id"], name: "index_friendships_on_requestfeed_id"

      t.timestamps
    end
  end
end
