class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :title
      t.integer :user_id
      t.boolean :completed

      t.timestamps
    end
  end
end
